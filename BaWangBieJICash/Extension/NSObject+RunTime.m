//
//  NSObject+RunTime.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "NSObject+RunTime.h"
#import <objc/runtime.h>

@implementation NSObject (RunTime)

- (void)addPropertyWithKey:(void *)key ToObject:(__kindof NSObject*)toObject PropertyType:(PC_PropertyType)propertyType
{
    objc_setAssociatedObject(toObject, key, self, (objc_AssociationPolicy)propertyType);
}

+ (instancetype)getPropertyWithKey:(void *)key FromObject:(__kindof NSObject*)fromObject
{
    return objc_getAssociatedObject(fromObject, key);
}

@end
