//
//  AndyJsonStore.m
//  AndyStore_Test
//
//  Created by 李扬 on 16/6/23.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <AndyExtension/AndyExtension.h>
#import "AndyJsonStore.h"

@interface AndyJsonStore ()

@property (nonatomic, copy) NSString *key;

@end

@implementation AndyJsonStore

SingletonM(JsonStore);

- (BOOL)setOrUpdateValue:(id)value ForKey:(NSString *)key
{
    self.key = [key copy];
    
    NSString *jsonStoreFilePath = [self getJsonStoreFilePath];
    
    if (jsonStoreFilePath != nil)
    {
        @try {
            NSString *jsonString;
            
            if ([value isKindOfClass:[NSValue class]] || [value isKindOfClass:[NSString class]])
            {
                jsonString = [NSString stringWithFormat:@"%@", value];
            }
            else if ([value isKindOfClass:[NSURL class]])
            {
                jsonString = [value absoluteString];
            }
            else
            {
                jsonString = [value andy_JSONString];
            }
            
            BOOL isSuccess = [self saveContentToFile:jsonString atomically:YES];
            return isSuccess;
            
        } @catch (NSException *exception) {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

- (instancetype)getValueForClass:(Class)valueClass ForKey:(NSString *)key DefaultValue:(id)defaultValue
{
    self.key = [key copy];
    
    NSString *jsonStoreFilePath = [self getJsonStoreFilePath];
    
    if (jsonStoreFilePath != nil)
    {
        NSError *error = nil;
        
        @try {
            
            if (valueClass == [NSValue class] || valueClass == [NSString class])
            {
                NSString *string = [NSString stringWithContentsOfFile:jsonStoreFilePath encoding:NSUTF8StringEncoding error:&error];
                if (error == nil)
                {
                    return (id)string;
                }
                else
                {
                    return defaultValue;
                }
            }
            else
            {
                NSData *jsonData = [NSData dataWithContentsOfFile:jsonStoreFilePath];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
                
                if (error == nil)
                {
                    return [valueClass andy_objectWithKeyValues:dict];
                }
                else
                {
                    return defaultValue;
                }
                
            }
        } @catch (NSException *exception) {
            return defaultValue;
        }
    }
    else
    {
        return defaultValue;
    }
}

- (BOOL)removeValueForKey:(NSString *)key
{
    self.key = [key copy];
    
    NSString *jsonStoreFilePath = [self getJsonStoreFilePath];
    
    if (jsonStoreFilePath != nil)
    {
        NSError *error = nil;
        
        @try {
            NSFileManager *manager = [NSFileManager defaultManager];
            [manager removeItemAtPath:jsonStoreFilePath error:&error];
            if (error == nil)
            {
                return YES;
            }
            else
            {
                return NO;
            }
        } @catch (NSException *exception) {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

- (BOOL)clear
{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if(![manager removeItemAtPath:[self getJsonStoreDirectoryPath] error:nil])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (NSString *)getJsonStoreDirectoryPath
{
    NSString *directoryPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"JsonStore"];
    
    BOOL isDirectoryAlreadyExists = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:nil];
    if (!isDirectoryAlreadyExists)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    return directoryPath;
    
}

- (NSString *)getJsonStoreFilePath
{
    NSString *directoryPath = [self getJsonStoreDirectoryPath];
    NSString *filePath = [directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jk", self.key]];
    
    return filePath;
    
}

- (BOOL)saveContentToFile:(NSString *)jsonString atomically:(BOOL)useAuxiliaryFile
{
    NSString *jsonStoreFilePath = [self getJsonStoreFilePath];
    
    if (jsonStoreFilePath != nil)
    {
        NSError *error = nil;
        
        [jsonString writeToFile:jsonStoreFilePath atomically:useAuxiliaryFile encoding:NSUTF8StringEncoding error:&error];
        
        if (error == nil)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}


@end
