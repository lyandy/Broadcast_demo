//
//  AndyJsonStore.h
//  AndyStore_Test
//
//  Created by 李扬 on 16/6/23.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AndySingleton.h"

@interface AndyJsonStore : NSObject

SingletonH(JsonStore);

- (BOOL)setOrUpdateValue:(id)value ForKey:(NSString *)key;

- (instancetype)getValueForClass:(Class)valueClass ForKey:(NSString *)key DefaultValue:(id)defaultValue ;

- (BOOL)removeValueForKey:(NSString *)key;

- (BOOL)clear;

@end
