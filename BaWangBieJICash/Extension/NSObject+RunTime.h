//
//  NSObject+RunTime.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, PC_PropertyType) {
    PC_PropertyType_ASSIGN          = 0,
    PC_PropertyType_RETAIN          = 1,
    PC_PropertyType_COPY            = 3,
};


#define SetPropertyForInteger(__integerVal__,__key__)       NSNumber *obj = [NSNumber numberWithInteger:__integerVal__]; \
                                                            [obj addPropertyWithKey:&__key__ ToObject:self PropertyType:MK_PropertyType_RETAIN];

#define GetPropertyForInteger(__key__)                      NSNumber *obj = [NSNumber getPropertyWithKey:&__key__ FromObject:self]; \
                                                            return obj.integerValue;

#define SetPropertyForObject(__objVal__,__key__)            [__objVal__ addPropertyWithKey:&__key__ ToObject:self PropertyType:MK_PropertyType_RETAIN]
#define GetPropertyForObject(__objClass__,__key__)          [__objClass__ getPropertyWithKey:&__key__ FromObject:self]

@interface NSObject (RunTime)


/// 向指定的对象添加变量
/// - Parameters:
///   - key: key
///   - toObject: 指定对象
///   - propertyType: 变量修饰类型
- (void)addPropertyWithKey:(void *)key ToObject:(__kindof NSObject*)toObject PropertyType:(PC_PropertyType)propertyType;

/// 从指定对象获取变量
/// - Parameters:
///   - key: key
///   - fromObject: 指定对象
+ (instancetype)getPropertyWithKey:(void *)key FromObject:(__kindof NSObject*)fromObject;

@end

NS_ASSUME_NONNULL_END
