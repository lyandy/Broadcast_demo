//
//  NSObject+AndyDurex.m
//  AndyExtension_Test
//
//  Created by 李扬 on 16/6/16.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "NSObject+AndyDurex.h"
#import "NSObject+AndyKeyValue.h"
#import <objc/message.h>

@implementation NSObject (AndyDurex)

+ (void)load
{
    Method setValueforUndefinedKeyMethod = class_getClassMethod([NSObject class], @selector(setValue:forUndefinedKey:));
    
    Method andy_setValueforUndefinedKeyMethod = class_getClassMethod([NSObject class], @selector(andy_setValue:forUndefinedKey:));
    
    method_exchangeImplementations(setValueforUndefinedKeyMethod, andy_setValueforUndefinedKeyMethod);
    
    
    Method setNilValueForKeyMethod = class_getClassMethod([NSObject class], @selector(setNilValueForKey:));
    
    Method andy_setNilValueForKeyMethod = class_getClassMethod([NSObject class], @selector(andy_setNilValueForKey:));
    
    method_exchangeImplementations(setNilValueForKeyMethod, andy_setNilValueForKeyMethod);
    
    

//    Method tempResolveInstanceMethod = class_getClassMethod([NSObject class], @selector(resolveInstanceMethod:));
//    
//    Method andy_resolveInstanceMethod = class_getClassMethod([NSObject class], @selector(andy_resolveInstanceMethod:));
//    
//    method_exchangeImplementations(tempResolveInstanceMethod, andy_resolveInstanceMethod);
    
    
    Method tempResolveClassMethod = class_getClassMethod([NSObject class], @selector(resolveClassMethod:));
    
    Method andy_resolveClassMethod = class_getClassMethod([NSObject class], @selector(andy_resolveClassMethod:));
    
    method_exchangeImplementations(tempResolveClassMethod, andy_resolveClassMethod);
}

//拦截以为value为空导致的崩溃
- (void)andy_setNilValueForKey:(NSString *)key
{
    //不要再次调用此方法，因为方法替换后是andy_setNilValueForKey:，此方法存有应用崩溃的代码
    //[self andy_setNilValueForKey:key];
    NSLog(@"出错了，杜蕾斯拦截: %s", __func__);
}

//拦截因为key为nil导致的崩溃
- (void)andy_setValue:(id)value forUndefinedKey:(NSString *)key
{
    //不要再次调用此方法，因为方法替换后是setValue:forUndefinedKey:，此方法存有应用崩溃的代码
    //[self andy_setValue:value forUndefinedKey:key];
    
    NSLog(@"出错了，杜蕾斯拦截: %s", __func__);
}

////拦截 对象方法 没有实现导致的崩溃
//+ (BOOL)andy_resolveInstanceMethod:(SEL)sel
//{
//    if (sel == @selector(andy_objectClassInArray))
//    {
//        // @:对象 :SEL
//        class_addMethod(self, sel, (IMP)CObjectClassInArray, "@@:");
//        
//        return YES;
//    }
//    else if (sel == @selector(andy_replacedKeyFromPropertyName))
//    {
//        class_addMethod(self, sel, (IMP)CReplacedKeyFromPropertyName, "@@:");
//        
//        return YES;
//    }
//    
//    return [self andy_resolveInstanceMethod:sel];
//}


////拦截 类方法 没有实现导致的崩溃
+ (BOOL)andy_resolveClassMethod:(SEL)sel
{
    Class selfMetaClass = objc_getMetaClass([NSStringFromClass([self class]) UTF8String]);
    
    if (sel == @selector(andy_objectClassInArray))
    {
        // @:对象 :SEL
        class_addMethod(selfMetaClass, sel, (IMP)CObjectClassInArray, "@@:");
        
        return YES;
    }
    else if (sel == @selector(andy_replacedKeyFromPropertyName))
    {
        class_addMethod(selfMetaClass, sel, (IMP)CReplacedKeyFromPropertyName, "@@:");
        
        return YES;
    }
    
    return [self andy_resolveClassMethod:sel];
}

id CObjectClassInArray(id self, SEL _cmd)
{
    //NSLog(@"未实现andy_objectClassInArray -- 动态添加 %@ %@",self,NSStringFromSelector(_cmd));
    return nil;
}

id CReplacedKeyFromPropertyName(id self, SEL _cmd)
{
    
    //NSLog(@"未实现andy_replacedKeyFromPropertyName -- 动态添加 %@ %@",self,NSStringFromSelector(_cmd));
    return nil;
}


@end
