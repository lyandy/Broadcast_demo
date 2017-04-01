//
//  AndyProperty.h
//  GrandDB_Test
//
//  Created by 李扬 on 2017/2/23.
//  Copyright © 2017年 andyshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface AndyProperty : NSObject

/** 成员属性 */
@property (nonatomic, assign) objc_property_t property;

/** 成员属性的名字 */
@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, copy) NSString *typeStr;

/** 成员属性来源于哪个类（可能是父类） */
@property (nonatomic, assign) Class srcClass;

/**
 *  初始化
 */
+ (instancetype)cachedPropertyWithProperty:(objc_property_t)property;

@end
