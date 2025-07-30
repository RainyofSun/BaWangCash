//
//  HtmlJSHelp.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "HtmlJSHelp.h"
#import <WebKit/WebKit.h>
#import "LoginPresent.h"
#import "BaseTabViewController.h"
#import <StoreKit/StoreKit.h>
#import "HtmlViewController.h"
#import "JumpTool.h"

@interface HtmlJSHelp ()

@property (nonatomic, weak) WKWebView *webView;

@property (nonatomic, weak) id <WKScriptMessageHandler> scriptDelegate;

@end

@implementation HtmlJSHelp

- (instancetype)initWithWebView:(__kindof WKWebView *)webView ScriptDelegate:(id <WKScriptMessageHandler>)scriptDelegate
{
    self = [super init];
    if (self) {
        self.webView = webView;
        self.scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)removeAllBridge
{
    [self.webView.configuration.userContentController removeAllScriptMessageHandlers];
}

- (void)addJsBridges
{
    [self addScriptWithName:@"BroughtJanitor"];
    [self addScriptWithName:@"AndEmily"];
    [self addScriptWithName:@"MstkAlso"];
    [self addScriptWithName:@"PehlJonah"];
    [self addScriptWithName:@"TheseLittle"];
    [self addScriptWithName:@"AndEffort"];
    [self addScriptWithName:@"InitiallyAnd"];
    [self addScriptWithName:@"EdenPicked"];
    [self addScriptWithName:@"PlatformOriginally"];
    [self addScriptWithName:@"MovieViewership"];
    [self addScriptWithName:@"RecentlyWould"];
}

- (void)addScriptWithName:(NSString *)name
{
    [self.webView.configuration.userContentController addScriptMessageHandler:self.scriptDelegate name:name];
}

#pragma mark - JS Do

- (void)fromJSCallWithMessage:(WKScriptMessage *)msg
{
    if ([msg.name isEqualToString:@"BroughtJanitor"]) {
        [self closeH5];
    }
    
    if ([msg.name isEqualToString:@"AndEmily"]) {
        [self jumpToH5WithBody:msg.body];
    }
    
    if ([msg.name isEqualToString:@"MstkAlso"]) {
        [self jumpWithBody:msg.body];
    }
    
    if ([msg.name isEqualToString:@"PehlJonah"]) {
        [self backToHomePage];
    }
    
    if ([msg.name isEqualToString:@"TheseLittle"]) {
        [self backToProfilePage];
    }
    
    if ([msg.name isEqualToString:@"AndEffort"]) {
        [self switchToLogin];
    }
    
    if ([msg.name isEqualToString:@"InitiallyAnd"]) {
        [self makePhoneCallWithBody:msg.body];
    }
    
    if ([msg.name isEqualToString:@"EdenPicked"]) {
        [self jumpToRateUs];
    }
    
    if ([msg.name isEqualToString:@"PlatformOriginally"]) {
        [self eventUpload];
    }
    
    if ([msg.name isEqualToString:@"MovieViewership"]) {
        [self bindStart];
    }
    
    if ([msg.name isEqualToString:@"RecentlyWould"]) {
        [self bindEnd];
    }
}

/// 关闭H5
- (void)closeH5
{
    HtmlViewController *h5VC = (HtmlViewController *)self.webView.viewController;
    [h5VC backBtnClick];
}

- (void)jumpToH5WithBody:(id)body
{
    NSString *urlStr = @"";
    if ([body isKindOfClass:NSArray.class]) urlStr = ((NSArray *)body).firstObject;
    if (![urlStr isExist]) return;
    
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlReq];
}

/// 带参数的跳转
- (void)jumpWithBody:(id)body
{
    if (![body isKindOfClass:[NSArray class]]) return;
    
    NSString *path = ((NSArray *)body).firstObject;
    [JumpTool.tool jumpWithStr:path];
}

/// 返回首页并关闭当前H5
- (void)backToHomePage
{
    [UIViewController.navVC popToRootViewControllerAnimated:false];
    BaseTabViewController *tabVC = (BaseTabViewController *)UIViewController.nowWindow.rootViewController;
    if (![tabVC isKindOfClass:BaseTabViewController.class]) return;
    tabVC.selectedIndex = 0;
}

/// 返回个人中心并关闭当前H5
- (void)backToProfilePage
{
    [UIViewController.navVC popToRootViewControllerAnimated:false];
    BaseTabViewController *tabVC = (BaseTabViewController *)UIViewController.nowWindow.rootViewController;
    if (![tabVC isKindOfClass:BaseTabViewController.class]) return;
    tabVC.selectedIndex = 2;
}

/// 切换到登陆页
- (void)switchToLogin
{
    LoginPresent *view = [LoginPresent new];
    [view show];
}

/// 拨打电话
- (void)makePhoneCallWithBody:(id)body
{
    NSString *str = @"tel://";
    NSString *urlStr = [str stringByAppendingString:body];
    NSURL *url = [NSURL URLWithString:urlStr];
    [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil];
}

/// 跳转评分
- (void)jumpToRateUs
{
    if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
    } else {
    }
}

/// 事件上报
- (void)eventUpload
{
    [PositionTool.tool startReportWithType:RiskPointType_LoanEnd];
    [PositionTool.tool endReportWithType:RiskPointType_LoanEnd];
}

/// 绑卡开始时间
- (void)bindStart
{
    [PositionTool.tool startReportWithType:RiskPointType_BindCard];
}

/// 绑卡结束时间
- (void)bindEnd
{
    [PositionTool.tool endReportWithType:RiskPointType_BindCard];
    
}

@end
