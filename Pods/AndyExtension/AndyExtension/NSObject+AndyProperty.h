//
//  NSObject+AndyProperty.h
//  GrandDB_Test
//
//  Created by 李扬 on 2017/2/23.
//  Copyright © 2017年 andyshare. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AndyProperty;

/**
 *  遍历成员变量用的block
 *
 *  @param property 成员的包装对象
 *  @param stop   YES代表停止遍历，NO代表继续遍历
 */
typedef void (^AndyPropertiesEnumeration)(AndyProperty *property, BOOL *stop);


@interface NSObject (AndyProperty)

/**
 *  遍历所有的成员
 */
+ (void)andy_enumerateProperties:(AndyPropertiesEnumeration)enumeration;

@end
