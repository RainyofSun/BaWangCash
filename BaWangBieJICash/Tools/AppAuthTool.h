//
//  AppAuthTool.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PC_AuthStepBlock)(NSString *authType);

@interface AppAuthTool : NSObject

@property (nonatomic, assign, readonly) NSInteger productID;

+ (instancetype)tool;

/// 更新并获取下一步的认证类型
/// - Parameters:
///   - productID: 产品ID
- (void)getAndUpdateNextAuthStatusWithProductID:(NSInteger)productID StepBlock:(PC_AuthStepBlock)stepBlock;

/// 是否已经获得数据
- (BOOL)hasInfo;

/// 获取当前的下一步认证，并不会更新数据
- (NSString *)getNextAuthStatus;

/// 跳转到下一步的控制器
- (void)jumpToNextStepVC;

/// 跳转到下一步的控制器 判断是否点击验证完成的项目，一般在认证首页调用
- (void)jumpToNextStepVCWithTypeStr:(NSString *)typeStr IsComplete:(BOOL)isComplete Count:(NSInteger)count;
@end

NS_ASSUME_NONNULL_END
