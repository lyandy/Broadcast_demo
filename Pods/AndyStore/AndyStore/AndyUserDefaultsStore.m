//
//  AndyUserDefaultsStore.m
//  AndyStore_Test
//
//  Created by 李扬 on 16/6/23.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "AndyUserDefaultsStore.h"

@implementation AndyUserDefaultsStore

SingletonM(UserDefaultsStore);

- (BOOL)setOrUpdateValue:(id)value ForKey:(NSString *)key
{
    @try {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:value forKey:key];
        
        [defaults synchronize];
        
        return YES;
    } @catch (NSException *exception) {
        return NO;
    }
}

- (instancetype)getValueForKey:(NSString *)key DefaultValue:(id)defaultValue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    id value = [defaults objectForKey:key];
    
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults removeObjectForKey:key];
    
    [defaults synchronize];
    
    return YES;
}

- (BOOL)clear
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *appDomainStr = [[NSBundle mainBundle] bundleIdentifier];
    
    [defaults removePersistentDomainForName:appDomainStr];
    
    [defaults synchronize];
    
    return YES;
}


@end
