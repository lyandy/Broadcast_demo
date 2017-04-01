//
//  NSObject+AndyKeyValue.m
//  AndyExtension_Test
//
//  Created by 李扬 on 16/6/16.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "NSObject+AndyKeyValue.h"
#import "NSObject+AndyProperty.h"
#import "NSObject+AndyProperty.h"
#import "AndyProperty.h"
#import "AndyFoundation.h"
#import "AndyExtensionConst.h"
#import <objc/message.h>

@implementation NSObject (AndyKeyValue)

+ (instancetype)andy_objectWithFileName:(NSString *)fileName
{
    return [self andy_objectWithFilePath:[[NSBundle mainBundle] pathForResource:fileName ofType:nil]];
}

+ (instancetype)andy_objectWithFilePath:(NSString *)filePath
{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if (dict == nil)
    {
        NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        dict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    }
    
    return [self andy_objectWithKeyValues:dict];
}

+ (instancetype)andy_objectWithString:(NSString *)jsonString
{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    
    return [self andy_objectWithKeyValues:dict];
}

+ (instancetype)andy_objectWithKeyValues:(NSDictionary *)keyValues
{
    AndyExtensionAssert([keyValues isKindOfClass:[NSDictionary class]], @"keyValues参数不是一个字典");
    
    NSDictionary *dict = keyValues;
    
    id objc = [[self alloc] init];
    
    Class clazz = [self class];
    
    [clazz andy_enumerateProperties:^(AndyProperty *property, BOOL *stop) {
        // 获取key
        NSString *key = property.name;
        
        // 获取字典的value
        id value = dict[key];
        //如果value为nil的话，就去andy_replacedKeyFromPropertyName方法里找有没有实现对应的
        if (value == nil)
        {
            //这里实际上应该用 respondsToSelector 判断一下是否实现了，当然这里我采用了runtime的动态添加方法 andy_resolveClassMethod 来解决的
            NSDictionary *replacedKeyDict = [self andy_replacedKeyFromPropertyName];
            if (replacedKeyDict != nil)
            {
                //找到已经被替换成了其他成员名称
                NSString *replacedKey = replacedKeyDict[key];
                if (replacedKey != nil)
                {
                    value = dict[replacedKey];
                }
                //如果发现为字典里没有替换key对应的replacedKey，则抛弃此成员的解析
                else{}
            }
            //如果发现没有实现andy_replacedKeyFromPropertyName，则抛弃此成员的解析
            else{}
        }
        
        // 给模型的属性赋值
        // 成员属性类型
        NSString *propertyType = property.typeStr;
        // 值是字典,成员属性的类型不是字典,才需要转换成模型
        if ([value isKindOfClass:[NSDictionary class]] && ![propertyType containsString:@"NS"]) {
            // 获取需要转换类的类对象
            Class modelClass =  NSClassFromString(propertyType);
            
            if (modelClass) {
                value =  [modelClass andy_objectWithKeyValues:value];
            }
        }
        //值是数组
        else if ([value isKindOfClass:[NSArray class]])
        {
            //如果已经andy_objectClassInArray方法，指定数据里的数据类型
            //这里实际上应该用 respondsToSelector 判断一下是否实现了，当然这里我采用了runtime的动态添加方法 andy_resolveClassMethod 来解决的
            NSDictionary *replacedArrayModelDict = [self andy_objectClassInArray];
            if (replacedArrayModelDict != nil)
            {
                Class replacedModelClass = nil;
                
                id replacedValue = replacedArrayModelDict[key];
                
                if ([replacedValue isKindOfClass:[NSString class]])
                {
                    replacedModelClass = NSClassFromString(replacedValue);
                }
                else
                {
                    replacedModelClass = replacedValue;
                }
                
                //如果找到 数据 里的数据模型类型
                if (replacedModelClass != nil)
                {
                    NSArray * tempValue = [replacedModelClass andy_objectArrayWithKeyValuesArray:value];
                    if (tempValue != nil)
                    {
                        value = tempValue;
                    }
                }
            }
        }
        
        if (value) {
            // KVC赋值:不能传空. 万一出现空值则有杜蕾斯拦截错误，不会崩溃
            [objc setValue:value forKey:key];
        }

    }];
    
    return objc;
}

+ (NSArray *)andy_objectArrayWithFileName:(NSString *)fileName
{
    return [self andy_objectArrayWithFilePath:[[NSBundle mainBundle] pathForResource:fileName ofType:nil]];
}

+ (NSArray *)andy_objectArrayWithFilePath:(NSString *)filePath
{
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    if (array == nil)
    {
        NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        array = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    }
    
    return [self andy_objectArrayWithKeyValuesArray:array];
}

+ (NSArray *)andy_objectArrayWithString:(NSString *)jsonString
{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    
    return [self andy_objectArrayWithKeyValuesArray:arr];

}

+ (NSArray *)andy_objectArrayWithKeyValuesArray:(NSArray *)keyValuesArray
{
    NSMutableArray *arrM = [NSMutableArray array];
    
    for (NSDictionary *modelDict in keyValuesArray)
    {
        [arrM addObject:[self andy_objectWithKeyValues:modelDict]];
    };
    
    if (arrM.count == 0)
    {
        return nil;
    }
    else
    {
        return [arrM copy];
    }
}



- (NSData *)andy_JSONData
{
    if ([self isKindOfClass:[NSString class]])
    {
        return [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding];
    }
    else if ([self isKindOfClass:[NSData class]])
    {
        return (NSData *)self;
    }
    
    return [NSJSONSerialization dataWithJSONObject:[self andy_JSONObject] options:kNilOptions error:nil];
}

- (instancetype)andy_JSONObject
{
    if ([self isKindOfClass:[NSString class]])
    {
        return [NSJSONSerialization JSONObjectWithData:[(NSString *)self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    }
    else if ([self isKindOfClass:[NSData class]])
    {
        return [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:nil];
    }
    
    return [self andy_keyValues];
}

- (NSString *)andy_JSONString
{
    if ([self isKindOfClass:[NSString class]])
    {
        return (NSString *)self;
    }
    else if ([self isKindOfClass:[NSData class]])
    {
        return [[NSString alloc] initWithData:(NSData *)self encoding:NSUTF8StringEncoding];
    }
    
    return [[NSString alloc] initWithData:[self andy_JSONData] encoding:NSUTF8StringEncoding];
}

- (NSDictionary *)andy_keyValues
{
    //如果是Foundation框架下的类型,比如NSArray下是{"name":"超重低音","gainArray":[6,8,7,4,0,-1,-5,1,2,-2],"equalizerEffect":2}，根本没有key，此时直接返回即可。
    if ([self class] && [AndyFoundation isClassFromFoundation:[self class]]) {
        return (NSDictionary *)self;
    }
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    
    Class clazz = [self class];
    
    [clazz andy_enumerateProperties:^(AndyProperty *property, BOOL *stop) {
        
        // 获取key
        NSString *key = property.name;
        
        // 获取字典的value
        id value = [self valueForKey:key];
        
        //这里要判断是不是 自己 创建的类 字典。（判断当前oc类是不是Foundation自有的。因为NSDcitonary的value只能添加oc类的对象，如果不是就需要自己处理一下转换成NSDictionary）
        if ([value class] && ![AndyFoundation isClassFromFoundation:[value class]]) {
            value = [value andy_keyValues];
        }
        //如果是数组的话遍历来处理
        else if ([value isKindOfClass:[NSArray class]])
        {
            value = [NSObject andy_keyValuesWithObjectArray:value];
        }
        else if ([value isKindOfClass:[NSURL class]])
        {
            value = [value absoluteString];
        }
        
        dictM[key] = value;

    }];

    return [dictM copy];
}

+ (NSArray *)andy_keyValuesWithObjectArray:(NSArray *)objectArray
{
    // 1.创建数组
    NSMutableArray *keyValuesArray = [NSMutableArray array];
    for (id object in objectArray) {
        [keyValuesArray addObject:[object andy_keyValues]];
    }
    return [keyValuesArray copy];
}

@end
















