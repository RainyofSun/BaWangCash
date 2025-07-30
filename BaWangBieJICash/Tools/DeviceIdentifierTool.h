//
//  DeviceIdentifierTool.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceIdentifierTool : NSObject

+ (NSString *)getIDFVWithKeychain;
+ (NSString *)getIDFA; // 仅获取不存储

@end

NS_ASSUME_NONNULL_END
