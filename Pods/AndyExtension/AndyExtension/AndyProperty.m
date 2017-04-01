//
//  AndyProperty.m
//  GrandDB_Test
//
//  Created by 李扬 on 2017/2/23.
//  Copyright © 2017年 andyshare. All rights reserved.
//

#import "AndyProperty.h"
#import "AndyExtensionConst.h"
#import <objc/message.h>

@implementation AndyProperty

+ (instancetype)cachedPropertyWithProperty:(objc_property_t)property
{
    AndyProperty *propertyObj = objc_getAssociatedObject(self, property);
    if (propertyObj == nil)
    {
        propertyObj = [[self alloc] init];
        propertyObj.property = property;
        objc_setAssociatedObject(self, property, propertyObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return propertyObj;
}

- (void)setProperty:(objc_property_t)property
{
    _property = property;
    
    _name = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
}

- (NSString *)typeStr
{
    //属性的特性
    unsigned int attrCount = 0;
    objc_property_attribute_t * attrs = property_copyAttributeList(self.property, &attrCount);
    for (unsigned int j = 0; j < attrCount; j ++)
    {
        objc_property_attribute_t attr = attrs[j];
        const char * name = attr.name;
        const char * value = attr.value;
        
        if (strstr(name, "T") != NULL)
        {
            NSString *ocValue = [[NSString alloc] initWithCString:value encoding:NSUTF8StringEncoding];
            
            NSRange range = [ocValue rangeOfString:@"\""];
            if (range.location != NSNotFound)
            {
                _typeStr = [ocValue substringFromIndex:range.location + range.length];
                range = [_typeStr rangeOfString:@"\""];
                if (range.location != NSNotFound)
                {
                    _typeStr = [_typeStr substringToIndex:range.location];
                }
            }
            break;
        }
    }
    
    return _typeStr;
}

@end
