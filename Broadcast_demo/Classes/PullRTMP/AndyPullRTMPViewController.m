//
//  AndyPullRTMPViewController.m
//  Broadcast_demo
//
//  Created by 李扬 on 16/7/20.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "AndyPullRTMPViewController.h"

@interface AndyPullRTMPViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnClose;

@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;

@end

@implementation AndyPullRTMPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSubViwes];
    
    [self setupAutoLayout];

    [self initObserver];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [SVProgressHUD andy_ShowLoadingWithStatus:@"正在获取视频流，请稍后..."];
}

- (IJKFFMoviePlayerController *)moviePlayer
{
    if (_moviePlayer == nil)
    {
        IJKFFOptions *options = [IJKFFOptions optionsByDefault];
        [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
        
        // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
        [options setPlayerOptionIntValue:29.97 forKey:@"r"];
        // -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
        [options setPlayerOptionIntValue:512 forKey:@"vol"];
        NSString *rtmpUrl = (NSString *)[[AndyUserDefaultsStore sharedUserDefaultsStore] getValueForKey:RTMP_IP_KEY DefaultValue:nil];
        _moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:rtmpUrl withOptions:options];
        // 填充fill
        _moviePlayer.scalingMode = IJKMPMovieScalingModeNone;
        // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
        _moviePlayer.shouldAutoplay = NO;
        // 默认不显示直播帧率信息
        _moviePlayer.shouldShowHudView = NO;

        [_moviePlayer prepareToPlay];
    }
    return _moviePlayer;
}

- (void)setupSubViwes
{
    [self.view insertSubview:self.moviePlayer.view belowSubview:self.btnClose];
}

- (void)setupAutoLayout
{
    CGFloat commonMargin = 25;
    
    [self.btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.right).offset(-commonMargin);
        make.top.equalTo(self.view.top).offset(commonMargin);
    }];
    
    [self.moviePlayer.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.top.equalTo(self.view.top);
        make.bottom.equalTo(self.view.bottom);
        make.right.equalTo(self.view.right);
    }];
}

- (IBAction)btnClose_Click:(UIButton *)sender
{
    if (self.moviePlayer != nil)
    {
        [self.moviePlayer shutdown];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
        [self.moviePlayer.view removeFromSuperview];
    }
    
    [SVProgressHUD dismiss];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initObserver
{
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
}

- (void)stateDidChange
{
    if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0)
    {
        if (!self.moviePlayer.isPlaying)
        {
            [self.moviePlayer play];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled)
    {
        // 网速不佳, 自动暂停状态
        [SVProgressHUD andy_ShowLoadingWithStatus:@"正在获取视频流，请稍后..."];
    }
}

- (void)didFinish
{
    AndyLog(@"加载状态...%ld %ld %s", self.moviePlayer.loadState, self.moviePlayer.playbackState, __func__);
    // 因为网速或者其他原因导致直播stop了
//    if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled)
//    {
        [SVProgressHUD andy_ShowInfoWithStatus:@"直播结束"];
        
        [self btnClose_Click:self.btnClose];
        
        return;
    //}
}


- (void)dealloc
{
    AndyLog(@"拉流控制器 已销毁");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
