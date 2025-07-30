//
//  ProgressHud.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgressHud : NSObject

+ (void)showMessage:(NSString *)Msg;

+ (void)showLoading;
+ (void)hiddenLoading;

@end

NS_ASSUME_NONNULL_END
