//
//  NSObject+AndyClass.h
//  GrandDB_Test
//
//  Created by 李扬 on 2017/2/23.
//  Copyright © 2017年 andyshare. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  遍历所有类的block（父类）
 */
typedef void (^AndyClassesEnumeration)(Class c, BOOL *stop);

@interface NSObject (AndyClass)

+ (void)andy_enumerateClasses:(AndyClassesEnumeration)enumeration;

@end
