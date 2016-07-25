//
//  SVProgressHUD+Andy.m
//  Broadcast_demo
//
//  Created by 李扬 on 16/7/20.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "SVProgressHUD+Andy.h"

@implementation SVProgressHUD (Andy)

+ (void)setCustomStyle
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.65]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
}

+ (void)andy_ShowLoadingWithStatus:(NSString *)status
{
    [self setCustomStyle];
    
    [SVProgressHUD setMinimumDismissTimeInterval:MAXFLOAT];
    [SVProgressHUD showInfoWithStatus:status];
}

+ (void)andy_ShowInfoWithStatus:(NSString *)status
{
    [self setCustomStyle];
    
    [SVProgressHUD setMinimumDismissTimeInterval:((float)status.length * 0.06 + 0.5)];
    [SVProgressHUD showInfoWithStatus:status];
}

+ (void)andy_ShowErrorWithStatus:(NSString *)status
{
    [self setCustomStyle];
    
    [SVProgressHUD setMinimumDismissTimeInterval:((float)status.length * 0.06 + 0.5)];
    [SVProgressHUD showErrorWithStatus:status];
}

+ (void)andy_ShowSuccessWithStatus:(NSString *)status
{
    [self setCustomStyle];
    
    [SVProgressHUD setMinimumDismissTimeInterval:((float)status.length * 0.06 + 0.5)];
    [SVProgressHUD showSuccessWithStatus:status];
}

@end
