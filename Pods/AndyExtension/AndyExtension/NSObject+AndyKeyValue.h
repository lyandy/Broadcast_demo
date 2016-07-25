//
//  NSObject+AndyKeyValue.h
//  AndyExtension_Test
//
//  Created by 李扬 on 16/6/16.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AndyKeyValue)

+ (NSDictionary *)andy_replacedKeyFromPropertyName;

+ (NSDictionary *)andy_objectClassInArray;

/**
 *  通过一个文件(不仅限于plist文件类型)来创建一个对象
 *
 *  @param fileName 文件名称(仅限于mainBundle中的)
 *
 *  @return 新建的对象
 */
+ (instancetype)andy_objectWithFileName:(NSString *)fileName;

+ (instancetype)andy_objectWithFilePath:(NSString *)filePath;

+ (instancetype)andy_objectWithString:(NSString *)jsonString;

+ (instancetype)andy_objectWithKeyValues:(NSDictionary *)keyValues;


+ (NSArray *)andy_objectArrayWithFileName:(NSString *)fileName;

+ (NSArray *)andy_objectArrayWithFilePath:(NSString *)filePath;

+ (NSArray *)andy_objectArrayWithString:(NSString *)jsonString;

+ (NSArray *)andy_objectArrayWithKeyValuesArray:(NSArray *)keyValuesArray;



- (NSString *)andy_JSONString;

@end









