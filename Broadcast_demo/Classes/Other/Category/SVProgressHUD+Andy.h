//
//  SVProgressHUD+Andy.h
//  Broadcast_demo
//
//  Created by 李扬 on 16/7/20.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface SVProgressHUD (Andy)

+ (void)andy_ShowLoadingWithStatus:(NSString *)status;

+ (void)andy_ShowInfoWithStatus:(NSString*)status;

+ (void)andy_ShowSuccessWithStatus:(NSString*)status;

+ (void)andy_ShowErrorWithStatus:(NSString*)status;

@end
