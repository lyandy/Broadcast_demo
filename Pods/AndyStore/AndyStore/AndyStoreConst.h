//
//  AndyStoreConst.h
//  AndyStore_Test
//
//  Created by 李扬 on 2017/2/23.
//  Copyright © 2017年 andyli. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ANDYSTORE_EXTERN UIKIT_EXTERN

#define AndyStoreAssert(condition, desc, ...)  NSAssert(condition, desc, ##__VA_ARGS__)

#define AndyStoreDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
