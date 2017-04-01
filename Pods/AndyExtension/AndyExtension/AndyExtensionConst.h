//
//  AndyExtensionConst.h
//  GrandDB_Test
//
//  Created by 李扬 on 2017/2/23.
//  Copyright © 2017年 andyshare. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ANDYEXTENSION_EXTERN UIKIT_EXTERN

#define AndyExtensionAssert(condition, desc, ...)  NSAssert(condition, desc, ##__VA_ARGS__)

#define AndyExtensionDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

/**
 *  类型（属性类型）
 */
ANDYEXTENSION_EXTERN NSString *const MJPropertyTypeInt;
ANDYEXTENSION_EXTERN NSString *const MJPropertyTypeShort;
ANDYEXTENSION_EXTERN NSString *const MJPropertyTypeFloat;
ANDYEXTENSION_EXTERN NSString *const MJPropertyTypeDouble;
ANDYEXTENSION_EXTERN NSString *const MJPropertyTypeLong;
ANDYEXTENSION_EXTERN NSString *const MJPropertyTypeLongLong;
ANDYEXTENSION_EXTERN NSString *const MJPropertyTypeChar;
ANDYEXTENSION_EXTERN NSString *const MJPropertyTypeBOOL1;
ANDYEXTENSION_EXTERN NSString *const MJPropertyTypeBOOL2;
ANDYEXTENSION_EXTERN NSString *const MJPropertyTypePointer;

ANDYEXTENSION_EXTERN NSString *const MJPropertyTypeIvar;
ANDYEXTENSION_EXTERN NSString *const MJPropertyTypeMethod;
ANDYEXTENSION_EXTERN NSString *const MJPropertyTypeBlock;
ANDYEXTENSION_EXTERN NSString *const MJPropertyTypeClass;
ANDYEXTENSION_EXTERN NSString *const MJPropertyTypeSEL;
ANDYEXTENSION_EXTERN NSString *const MJPropertyTypeId;
