//
//  LoginLogic.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "LoginLogic.h"
#import "BaseTabViewController.h"

@implementation LoginLogic

+ (instancetype)tool
{
    static dispatch_once_t onceToken;
    static LoginLogic *_tool = nil;
    dispatch_once(&onceToken, ^{
        if (_tool == nil) {
            _tool = [LoginLogic new];
        }
    });
    return _tool;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setLoginModel:[LoginModel readFromDisk]];
    }
    return self;
}

- (void)checkAutoLoginAndJump
{
    if (!self.isLogin) {
        [self showLogin];
    }
}

- (void)showLogin
{
    LoginPresent *view = [LoginPresent new];
    [view show];
}

- (void)loginWithMobile:(NSString *)mobile Code:(NSString *)code WithBlock:(PC_LoginTool_DidReqLogin)compelet
{
    if ([mobile isEqualToString:@""]) {
        [ProgressHud showMessage:@"Please enter your mobile phone number"];
        return;
    }else if ([code isEqualToString:@""]) {
        [ProgressHud showMessage:@"Please enter the verification code"];
        return;
    }else {
        NSDictionary *dict = @{@"raging":mobile,@"resembling":code};
        __weakSelf;
        [ProgressHud showLoading];
        [NetMonitorTool.tool postWithPath:@"/before/snob" Parameters:dict SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
            __strongSelf;
            [ProgressHud hiddenLoading];
            if (responseModel.success) {
                LoginModel *model = [LoginModel ACModel_withDict:responseModel.pc_portal];
                [self setLoginModel:model];
            }else {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [ProgressHud showMessage:responseModel.pc_flag];
                });
                return;
            }
            compelet(responseModel.success);
            
        } FailBlock:^(NSError * _Nonnull error) {
            compelet(false);
            [ProgressHud hiddenLoading];
        }];
    }
}

- (void)sendLoginCodeWithMobile:(NSString *)mobile SuccBlock:(PC_LoginTool_DidSendCode)didSendCodeBlock
{
    NSDictionary *dict = @{@"bender":mobile};
    [ProgressHud showLoading];
    [NetMonitorTool.tool postWithPath:@"/before/camp" Parameters:dict SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        [ProgressHud hiddenLoading];
        if (!responseModel.success || [mobile isEqualToString:@""]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHud showMessage:responseModel.pc_flag];
            });
            return;
        }else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHud showMessage:responseModel.pc_flag];
            });
        }
        LoginCodeModel *codeModel = [LoginCodeModel ACModel_withDict:responseModel.pc_portal];
    
        NSInteger expiry = codeModel.pc_consists.pc_expecting;
        NSString *status = responseModel.pc_snob;
        if (status == 0){
            if (didSendCodeBlock) didSendCodeBlock(mobile,expiry,true);
        }else{
            if (didSendCodeBlock) didSendCodeBlock(mobile,expiry,true);
        }
    } FailBlock:^(NSError * _Nonnull error) {
        if (didSendCodeBlock) didSendCodeBlock(@"",0,false);
        [ProgressHud hiddenLoading];
    }];
    
}

- (void)logOut
{
    [ProgressHud showLoading];
    [NetMonitorTool.tool getWithPath:@"/before/com" Parameters:@{} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        [ProgressHud hiddenLoading];
        if (!responseModel.success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHud showMessage:responseModel.pc_flag];
            });
            return;
        }
        [LoginModel removeFromDisk];
        self.loginModel = nil;
        [Noti_Center postNotificationName:PC_DidLogoutSucc_NotiKey object:nil];
        
        [UIViewController.navVC popToRootViewControllerAnimated:false];
        
        BaseTabViewController *tabVC = (BaseTabViewController *)UIViewController.nowWindow.rootViewController;
        if (![tabVC isKindOfClass:BaseTabViewController.class]) return;
        tabVC.selectedIndex = 0;
        
        
//        [tabVC.tabbar setNeedsLayout];
//        [tabVC.tabbar layoutIfNeeded];
    } FailBlock:^(NSError * _Nonnull error) {
        [ProgressHud hiddenLoading];
    }];
}


- (void)logOff
{
    [ProgressHud showLoading];
    [NetMonitorTool.tool getWithPath:@"/before/consists" Parameters:@{} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        [ProgressHud hiddenLoading];
        if (!responseModel.success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHud showMessage:responseModel.pc_flag];
            });
            return;
        }
        self.loginModel = nil;
        [LoginModel removeFromDisk];
        [Noti_Center postNotificationName:PC_DidLogoutSucc_NotiKey object:nil];
        [UIViewController.navVC popToRootViewControllerAnimated:false];
        BaseTabViewController *tabVC = (BaseTabViewController *)UIViewController.nowWindow.rootViewController;
        if (![tabVC isKindOfClass:BaseTabViewController.class]) return;
        tabVC.selectedIndex = 0;
    } FailBlock:^(NSError * _Nonnull error) {
        [ProgressHud hiddenLoading];
    }];
}

#pragma mark - Login Info

- (void)setLoginModel:(LoginModel *)loginModel
{
    _loginModel = loginModel;
    
    if (loginModel != nil) {
        [Noti_Center postNotificationName:PC_DidLoginSucc_NotiKey object:nil];
    }
    [loginModel saveToDisk];
}

- (_Bool)isLogin
{
    return self.loginModel != nil;
}

/// 获取语音验证码
/// - Parameter mobile: 电话
- (void)getLoginVoiceCodeWithMobile:(NSString *)mobile WithBlock:(PC_LoginTool_GetVoiceBlock)compelet
{
    [ProgressHud showLoading];
    [NetMonitorTool.tool postWithPath:@"/before/kitsch" Parameters:@{@"bender":mobile} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        [ProgressHud hiddenLoading];
        if (!responseModel.success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHud showMessage:responseModel.pc_flag];
            });
            compelet(false);
        }else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHud showMessage:responseModel.pc_flag];
            });
            compelet(responseModel.success);
        }
        } FailBlock:^(NSError * _Nonnull error) {
            compelet(false);
            [ProgressHud hiddenLoading];
        }];
}


#pragma mark - Config

- (void)getLoginConfigWithCompleteBlock:(PC_LoginTool_GetConfigBlock)completeBlock
{
    __weakSelf;
    NSDictionary *dict = @{@"schlefaz":@"en",@"camp":@([NetMonitorTool isProxy]),@"kitsch":@([NetMonitorTool isVPNConnected])};
    [NetMonitorTool.tool postWithPath:@"/before/schlefaz" Parameters:dict SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        __strongSelf;
        if (!responseModel.success) {
            completeBlock(false);
            [ProgressHud showMessage:responseModel.pc_flag];
            return;
        }
        self.loginConfig = [LoginConfig ACModel_withDict:responseModel.pc_portal];
        completeBlock(true);
    } FailBlock:^(NSError * _Nonnull error) {
        completeBlock(false);
    }];
}

- (void)setLoginConfig:(LoginConfig *)loginConfig
{
    _loginConfig = loginConfig;
}

@end
