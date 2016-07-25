//
//  AndySingleton.h
//  AndyStore_Test
//
//  Created by 李扬 on 16/6/23.
//  Copyright © 2016年 andyli. All rights reserved.
//

#ifndef AndySingleton_h
#define AndySingleton_h

//.h文件的实现
#define SingletonH(methodName) + (instancetype)shared##methodName;

//.m文件的实现
#define SingletonM(methodName) \
static id instance = nil;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
    static dispatch_once_t oneToken;\
    dispatch_once(&oneToken, ^{\
        instance = [super allocWithZone:zone];\
    });\
    return instance;\
}\
\
- (id)copyWithZone:(NSZone *)zone\
{\
    return instance;\
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone\
{\
    return instance;\
}\
\
- (instancetype)init\
{\
    static dispatch_once_t oneToken;\
    dispatch_once(&oneToken, ^{\
        instance = [super init];\
    });\
    return instance;\
}\
\
+ (instancetype)shared##methodName\
{\
    return [[self alloc] init];\
}


#endif /* AndySingleton_h */
