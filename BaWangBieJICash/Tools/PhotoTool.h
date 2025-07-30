//
//  PhotoTool.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoTool : NSObject

+ (instancetype)tool;

- (void)isGetCameraAuth:(void (^)(BOOL granted))completion;
- (void)isGetPhotoAuth:(void (^)(BOOL granted))completion;

@end

NS_ASSUME_NONNULL_END
