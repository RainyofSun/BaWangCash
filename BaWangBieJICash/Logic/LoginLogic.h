//
//  LoginLogic.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
#import "LoginPresent.h"
#import "LoginCodeModel.h"
#import "LoginConfig.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * PC_DidLoginSucc_NotiKey = @"PC_DidLoginSucc_NotiKey";
static NSString * PC_DidLogoutSucc_NotiKey = @"PC_DidLogoutSucc_NotiKey";

typedef void(^PC_LoginTool_DidSendCode)(NSString *mobile, NSInteger expiry, bool succ);

typedef void(^PC_LoginTool_DidSendAddBankCardCode)(bool succ, NSInteger expiry);

typedef void(^PC_LoginTool_DidReqLogin)(bool succ);

typedef void(^PC_LoginTool_GetConfigBlock)(bool succ);

typedef void(^PC_LoginTool_GetVoiceBlock)(bool succ);

@interface LoginLogic : NSObject

@property (nonatomic ,strong ,readonly) LoginModel *loginModel;
@property (nonatomic , assign) bool isLogin;

@property (nonatomic , strong, readonly) LoginConfig *loginConfig;

+ (instancetype)tool;

/// 检查自动登录和跳转
- (void)checkAutoLoginAndJump;

/// 登陆
/// - Parameters:
///   - mobile: 手机号 不带区号
///   - code: 验证码
- (void)loginWithMobile:(NSString *)mobile Code:(NSString *)code WithBlock:(PC_LoginTool_DidReqLogin)compelet;

/// 登出
- (void)logOut;

/// 注销
- (void)logOff;

#pragma mark - Code


/// 发送验证码 会在内部判断手机号的完整性
/// - Parameters:
///   - mobile: 手机号不带区号
///   - didSendCodeBlock: 完成的回调
- (void)sendLoginCodeWithMobile:(NSString *)mobile SuccBlock:(PC_LoginTool_DidSendCode)didSendCodeBlock;

/// 获取语音验证码
/// - Parameter mobile: 电话
- (void)getLoginVoiceCodeWithMobile:(NSString *)mobile WithBlock:(PC_LoginTool_GetVoiceBlock)compelet;

#pragma mark - Config

/// 获取登陆配置
/// - Parameter completeBlock: 完成回调
- (void)getLoginConfigWithCompleteBlock:(PC_LoginTool_GetConfigBlock)completeBlock;

@end

NS_ASSUME_NONNULL_END
