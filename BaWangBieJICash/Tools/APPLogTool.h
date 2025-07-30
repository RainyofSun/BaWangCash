//
//  APPLogTool.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APPLogTool : NSObject

+ (instancetype)tool;

/// idfv&idfa上报
- (void)reportDeviceIDsWithCompletion:(void(^)(BOOL))completion;

/// 设备信息上报
- (void)reportDeviceWithCompletion:(void(^)(BOOL success))completion;

@end

NS_ASSUME_NONNULL_END
