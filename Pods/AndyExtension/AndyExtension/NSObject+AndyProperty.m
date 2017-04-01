//
//  NSObject+AndyProperty.m
//  GrandDB_Test
//
//  Created by 李扬 on 2017/2/23.
//  Copyright © 2017年 andyshare. All rights reserved.
//

#import "NSObject+AndyProperty.h"
#import "NSObject+AndyClass.h"
#import "AndyFoundation.h"
#import "AndyProperty.h"
#import <objc/message.h>

@implementation NSObject (AndyProperty)

+ (NSArray *)andy_properties
{
    NSMutableArray *cachedProperties = [NSMutableArray array];
    
    [self andy_enumerateClasses:^(__unsafe_unretained Class c, BOOL *stop) {
        unsigned int outCount = 0;
        objc_property_t *properties = class_copyPropertyList(c, &outCount);
        for (unsigned int i = 0 ; i < outCount; i++)
        {
            AndyProperty *property = [AndyProperty cachedPropertyWithProperty:properties[i]];
            if ([AndyFoundation isClassFromFoundation:property.srcClass])
            {
                continue;
            }
            
            property.srcClass = c;
            [cachedProperties addObject:property];
        }
        free(properties);
    }];
    
    return [cachedProperties copy];
}


+ (void)andy_enumerateProperties:(AndyPropertiesEnumeration)enumeration
{
    NSArray *cachedProperties = [self andy_properties];
    
    BOOL stop = NO;
    
    for (AndyProperty *propery in cachedProperties)
    {
        enumeration(propery, &stop);
        if (stop)
        {
            break;
        }
    }
}

@end
