//
//  AndyDictStore.m
//  AndyStore_Test
//
//  Created by 李扬 on 16/6/23.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "AndyDictStore.h"

@interface AndyDictStore ()

/**
 *  保持原子性，防止线程死锁
 */
@property (atomic, strong) NSMutableDictionary *dictM;

@end

@implementation AndyDictStore

static id instance = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return instance;
}

- (instancetype)init
{
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        instance = [super init];
        
        self.dictM = [NSMutableDictionary dictionary];
    });
    
    return instance;
}

+ (instancetype)sharedDictStore
{
    return [[self alloc] init];
}


- (BOOL)setOrUpdateValue:(id)value ForKey:(NSString *)key
{
    @try {
        
        if ([self.dictM objectForKey:key] != nil)
        {
            self.dictM[key] = value;
        }
        else
        {
            [self.dictM setObject:value forKey:key];
        }
        return YES;
    } @catch (NSException *exception) {
        return NO;
    }
}

- (instancetype)getValueForKey:(NSString *)key DefaultValue:(id)defaultValue
{
    id value = [self.dictM objectForKey:key];
    
    if (value != nil)
    {
        return value;
    }
    else
    {
        return defaultValue;
    }
}

- (BOOL)removeValueForKey:(NSString *)key
{
    [self.dictM removeObjectForKey:key];
    
    return YES;
}

- (BOOL)clear
{
    [self.dictM removeAllObjects];
    
    return YES;
}


@end
