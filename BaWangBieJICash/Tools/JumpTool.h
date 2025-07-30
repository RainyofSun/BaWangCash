//
//  JumpTool.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JumpTool : NSObject

@property (nonatomic, assign) bool isInAuthMode;
@property (nonatomic, assign) bool isNeedPopToRoot;

+ (instancetype)tool;

/// 从接口字符串跳转
/// - Parameter str: 包含地址或者协议的字符串
- (void)jumpWithStr:(NSString *)str;


- (void)jumpWithSchemeWithStr:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
