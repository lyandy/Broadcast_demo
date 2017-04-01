//
//  NSObject+AndyClass.m
//  GrandDB_Test
//
//  Created by 李扬 on 2017/2/23.
//  Copyright © 2017年 andyshare. All rights reserved.
//

#import "NSObject+AndyClass.h"
#import "AndyFoundation.h"
#import <objc/runtime.h>

@implementation NSObject (AndyClass)

+ (void)andy_enumerateClasses:(AndyClassesEnumeration)enumeration
{
    if (enumeration == nil)
    {
        return;
    }
    
    BOOL stop = NO;
    
    Class c = self;
    
    while (c != nil && !stop) {
        enumeration(c, &stop);
        
        c = class_getSuperclass(c);
        
        if ([AndyFoundation isClassFromFoundation:c])
        {
            break;
        }
    }
}

@end
