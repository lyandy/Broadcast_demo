//
//  AndyPushRTMPViewController.m
//  Broadcast_demo
//
//  Created by 李扬 on 16/7/20.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "AndyPushRTMPViewController.h"
#import <LFLiveKit.h>

@interface AndyPushRTMPViewController ()<LFLiveSessionDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnBeautiful;
@property (weak, nonatomic) IBOutlet UIButton *btnSwitchCamera;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnStart;

/** RTMP地址 */
@property (nonatomic, copy) NSString *rtmpUrl;
@property (nonatomic, strong) LFLiveSession *session;
@property (nonatomic, strong) UIView *livingPreView;

@end

@implementation AndyPushRTMPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSubViews];
    
    [self setupInit];

    [self setupAutoLayout];
}

- (UIView *)livingPreView
{
    if (_livingPreView == nil)
    {
        _livingPreView = [[UIView alloc] initWithFrame:self.view.bounds];
        _livingPreView.backgroundColor = [UIColor clearColor];
    }
    return _livingPreView;
}

- (LFLiveSession*)session{
    if(!_session)
    {
        /***   默认分辨率368 ＊ 640  音频：44.1 iphone6以上48  双声道  方向竖屏 ***/
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium2]];
        
        // 设置代理
        _session.delegate = self;
        _session.running = YES;
        _session.preView = self.livingPreView;
    }
    return _session;
}

- (void)setupSubViews
{
    [self.view insertSubview:self.livingPreView atIndex:0];
}

- (void)setupInit
{
    self.btnBeautiful.layer.cornerRadius = self.btnBeautiful.andy_Height * 0.5;
    self.btnBeautiful.layer.masksToBounds = YES;
    
    self.btnStart.backgroundColor = AndyColor;
    self.btnStart.layer.cornerRadius = self.btnStart.andy_Height* 0.5;
    self.btnStart.layer.masksToBounds = YES;
    
    self.statusLabel.numberOfLines = 0;
    
    // 默认开启后置摄像头
    self.session.captureDevicePosition = AVCaptureDevicePositionBack;
}

- (void)setupAutoLayout
{
    CGFloat commonMargin = 25;
    
    [self.btnBeautiful mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(commonMargin);
        make.centerY.equalTo(self.btnClose.centerY);
    }];
    
    [self.btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.right).offset(-commonMargin);
        make.top.equalTo(self.view.top).offset(commonMargin);
    }];
    
    [self.btnSwitchCamera mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnClose.left).offset(-commonMargin);
        make.top.equalTo(self.view.top).offset(commonMargin);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.view.top).offset(4 * commonMargin);
    }];
    
    [self.btnStart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(200);
        make.height.equalTo(40);
        make.centerX.equalTo(self.view.centerX);
        make.bottom.equalTo(self.view.bottom).offset(-2 * commonMargin);
    }];
    
    [self.livingPreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.top.equalTo(self.view.top);
        make.bottom.equalTo(self.view.bottom);
        make.right.equalTo(self.view.right);
    }];
    
}

- (IBAction)btnBeautiful_Click:(UIButton *)sender
{
    sender.selected = !sender.selected;
    // 默认是开启了美颜功能的
    self.session.beautyFace = !self.session.beautyFace;
}

- (IBAction)btnSwitchCamera_Click:(UIButton *)sender
{
    AVCaptureDevicePosition devicePositon = self.session.captureDevicePosition;
    self.session.captureDevicePosition = (devicePositon == AVCaptureDevicePositionBack) ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
    AndyLog(@"切换前置/后置摄像头");
}

- (IBAction)btnClose_Click:(UIButton *)sender
{
    if (self.session.state == LFLivePending || self.session.state == LFLiveStart)
    {
        [self.session stopLive];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnStart_Click:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        // 开始直播
        LFLiveStreamInfo *stream = [LFLiveStreamInfo new];
        //在这里换成你的rtmp推流地址
        stream.url = (NSString *)[[AndyUserDefaultsStore sharedUserDefaultsStore] getValueForKey:RTMP_IP_KEY DefaultValue:nil];
        self.rtmpUrl = stream.url;
        [self.session startLive:stream];
    }
    else
    {
        // 结束直播
        [self.session stopLive];
        self.statusLabel.text = [NSString stringWithFormat:@"状态: 直播被关闭\n地址: %@", self.rtmpUrl];
    }

}

- (void)liveSession:(LFLiveSession *)session liveStateDidChange:(LFLiveState)state
{
    NSString *tempStatus;
    switch (state) {
        case LFLiveReady:
            tempStatus = @"准备中";
            break;
        case LFLivePending:
            tempStatus = @"连接中";
            break;
        case LFLiveStart:
            tempStatus = @"已连接";
            break;
        case LFLiveStop:
            tempStatus = @"已断开";
            break;
        case LFLiveError:
            tempStatus = @"连接出错";
            break;
        default:
            break;
    }
    self.statusLabel.text = [NSString stringWithFormat:@"状态: %@\n地址: %@", tempStatus, self.rtmpUrl];

}

- (void)liveSession:(LFLiveSession *)session debugInfo:(LFLiveDebug *)debugInfo
{
    
}

- (void)liveSession:(LFLiveSession *)session errorCode:(LFLiveSocketErrorCode)errorCode
{
    
}

- (void)dealloc
{
    AndyLog(@"推流控制器 已销毁");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
