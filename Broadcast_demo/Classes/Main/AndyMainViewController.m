//
//  AndyMainViewController.m
//  Broadcast_demo
//
//  Created by 李扬 on 16/7/20.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "AndyMainViewController.h"
#import "AndyPullRTMPViewController.h"
#import "AndyPushRTMPViewController.h"

@interface AndyMainViewController ()

@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UITextField *ipTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *btnPushRTMP;
@property (weak, nonatomic) IBOutlet UIButton *btnPullRTMP;


@end

@implementation AndyMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"直播测试";
    
    [self setupAutoLayout];
}

- (void)setupAutoLayout
{
    CGFloat commonVerticalMargin = 80;
    
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(285);
        make.height.equalTo(35);
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.view.top).offset(commonVerticalMargin + 64);
    }];
    
    [self.btnPushRTMP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.addressView.bottom).offset(commonVerticalMargin);
    }];
    
    [self.btnPullRTMP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.btnPushRTMP.bottom).offset(commonVerticalMargin);
    }];
}

- (IBAction)btnPushRTMP_Click:(UIButton *)sender
{
    BOOL isDeviceReady = self.checkDeviceStatus;
    
    if (isDeviceReady)
    {
        BOOL isAddressValid = [self checkRTMPIPValid];
        if (isAddressValid == YES)
        {
            [[AndyUserDefaultsStore sharedUserDefaultsStore]  setOrUpdateValue:[NSString stringWithFormat:@"rtmp://%@:1935/rtmplive/room", self.ipTextFiled.text.andy_trim] ForKey:RTMP_IP_KEY];
            
            AndyPushRTMPViewController * pushRTMPVc = [[AndyPushRTMPViewController alloc] init];
            [self presentViewController:pushRTMPVc animated:YES completion:nil];
        }
        else
        {
            [SVProgressHUD andy_ShowErrorWithStatus:@"RTMP服务器ip地址不正确，请重新输入"];
        }
    }
    
}

- (IBAction)btnPullRTMP_Click:(UIButton *)sender
{
    BOOL isAddressValid = [self checkRTMPIPValid];
    if (isAddressValid == YES)
    {
         [[AndyUserDefaultsStore sharedUserDefaultsStore]  setOrUpdateValue:[NSString stringWithFormat:@"rtmp://%@:1935/rtmplive/room", self.ipTextFiled.text.andy_trim] ForKey:RTMP_IP_KEY];
        
        AndyPullRTMPViewController * pullRTMPVc = [[AndyPullRTMPViewController alloc] init];
        [self presentViewController:pullRTMPVc animated:YES completion:nil];
    }
    else
    {
        [SVProgressHUD andy_ShowErrorWithStatus:@"RTMP服务器ip地址不正确，请重新输入"];
    }

}

- (BOOL)checkRTMPIPValid
{
    if (self.ipTextFiled.text.andy_trim.length == 0)
    {
        return NO;
    }
    else
    {
        return [self.ipTextFiled.text.andy_trim isValidateIPAdddress];
    }
}

- (BOOL)checkDeviceStatus
{
    // 判断是否是模拟器
    if ([[UIDevice deviceVersion] isEqualToString:@"iPhone Simulator"]) {
        [SVProgressHUD andy_ShowInfoWithStatus:@"请用真机进行测试, 此模块不支持模拟器测试"];
        return NO;
    }
    
    // 判断是否有摄像头
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [SVProgressHUD andy_ShowErrorWithStatus:@"您的设备没有摄像头或者相关的驱动, 不能进行直播"];
        return NO;
    }
    
    // 判断是否有摄像头权限
    AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
        [SVProgressHUD andy_ShowErrorWithStatus:@"app需要访问您的摄像头。\n请启用摄像头-设置/隐私/摄像头"];
        return NO;
    }
    
    // 开启麦克风权限
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                return YES;
            }
            else {
                [SVProgressHUD andy_ShowErrorWithStatus:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"];
                return NO;
            }
        }];
    }
    return YES;
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
