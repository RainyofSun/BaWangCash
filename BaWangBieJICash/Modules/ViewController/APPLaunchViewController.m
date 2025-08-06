//
//  APPLaunchViewController.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "APPLaunchViewController.h"
#import "LoginLogic.h"
#import "NetMonitorTool+DNS.h"
#import "BaseTabViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import "APPLogTool.h"
#import "APPGuideViewController.h"
#import "NetMonitorTool+Monitor.h"
#import "AddressTool.h"

@interface APPLaunchViewController ()

@property (nonatomic , strong) AC_BaseButton *retryBtn;

@property (nonatomic , assign) bool isInNet;

@end

@implementation APPLaunchViewController

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.navBar.hidden = true;
    
    [Noti_Center addObserver:self selector:@selector(checkNormalDNS) name:WhenNetworkEnable_NotiKey object:nil];
    
    ImgViewWithName(launch, @"launch");
    launch.contentMode = UIViewContentModeScaleAspectFill;
    [self.view insertSubview:launch atIndex:0];
    [launch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.view addSubview:self.retryBtn];
    [self.retryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@32);
        make.right.equalTo(@-32);
        make.height.equalTo(@54);
        make.bottom.equalTo(@((kBottomHeight+56)*-1));
    }];
    
//    [LoginLogic.tool getLoginConfigWithCompleteBlock:^(_Bool succ) {
//        
//    }];
//
//    [PositionTool.tool startUpdatingLocation];
}

- (void)checkNormalDNS
{
    [ProgressHud showLoading];
    __weakSelf;
    [LoginLogic.tool getLoginConfigWithCompleteBlock:^(_Bool succ) {
        __strongSelf;
        if (!succ) {
            // 切换动态域名
            PCLog(@"需要切换动态域名");
            [NetMonitorTool.tool switchDDNSWithSuccBlock:^(_Bool succ) {
                [ProgressHud hiddenLoading];
                __strongSelf;
                if (succ) {
                    PCLog(@"动态域名获取成功");
                    [self getLoginConfig];
                }else{
                    PCLog(@"动态域名获取失败");
                    self.retryBtn.hidden = false;
                }
            }];
            return;
        }
        PCLog(@"不需要切换动态域名");
        [ProgressHud hiddenLoading];
//        [self getLoginConfig];
        self.retryBtn.hidden = false;
    }];
    
    [APPLogTool.tool reportDeviceIDsWithCompletion:^(BOOL success) {
        
    }];
    
    [APPLogTool.tool reportDeviceWithCompletion:^(BOOL success) {
        
    }];
}

- (void)getLoginConfig
{
    [AddressTool.tool updateAdressInfo];
    [LoginLogic.tool getLoginConfigWithCompleteBlock:^(_Bool succ) {
        if (!succ) return;
        FBSDKSettings.sharedSettings.appID = LoginLogic.tool.loginConfig.pc_disney.pc_virgin;
        FBSDKSettings.sharedSettings.clientToken = LoginLogic.tool.loginConfig.pc_disney.pc_poster;
        FBSDKSettings.sharedSettings.displayName = LoginLogic.tool.loginConfig.pc_disney.pc_yeared;
        FBSDKSettings.sharedSettings.appURLSchemeSuffix = LoginLogic.tool.loginConfig.pc_disney.pc_happy;
        [[FBSDKApplicationDelegate sharedInstance] application:self.application didFinishLaunchingWithOptions:self.launchOptions];
        [self reqTrackAuth];
        [self jumpToGuide];
    }];
}

- (void)reqTrackAuth
{
    ATTrackingManagerAuthorizationStatus status = ATTrackingManager.trackingAuthorizationStatus;
    
    switch (status) {
        case ATTrackingManagerAuthorizationStatusNotDetermined:{
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                            
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)jumpToGuide
{
    NSNumber *needJumpGuide = [UserDefaultsObj objectForKey:@"needJumpGuide"];
    if (needJumpGuide != nil && needJumpGuide.boolValue) {
      
        BaseTabViewController *tabVC = [BaseTabViewController new];
        UIViewController.nowWindow.rootViewController = tabVC;
        return;
    }
    
    APPGuideViewController *guideVC = [APPGuideViewController new];
    UIViewController.nowWindow.rootViewController = guideVC;
    [UIViewController.nowWindow makeKeyWindow];
}

- (void)retryCall
{
    [ProgressHud showLoading];
    self.retryBtn.enabled = false;
    __weakSelf;
    [NetMonitorTool.tool switchDDNSWithSuccBlock:^(_Bool succ) {
        __strongSelf;
        [ProgressHud hiddenLoading];
        self.retryBtn.enabled = true;
        
        if (succ) {
            [self getLoginConfig];
            PCLog(@"动态域名获取成功");
        }
        
        PCLog(@"动态域名获取失败");
    }];
}

#pragma mark - Init

- (AC_BaseButton *)retryBtn
{
    if (_retryBtn == nil) {
        _retryBtn = [AC_BaseButton TextBtnWithTitle:@"Try again" titleColor:@"#000000" font:Semibold(18)];
        _retryBtn.hidden = true;
        _retryBtn.backgroundColor = HEXCOLOR(@"#FFFFFF");
        [_retryBtn setCornerRadius:27];
        [_retryBtn addTarget:self action:@selector(retryCall) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retryBtn;
}

@end
