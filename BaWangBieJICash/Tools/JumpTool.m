//
//  JumpTool.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "JumpTool.h"
#import "BaseTabViewController.h"
#import "HomePageViewController.h"
#import "OrderListViewController.h"
#import "MineViewController.h"
#import "LoginPresent.h"
#import "HtmlViewController.h"
#import "CertificationListViewController.h"
#import "SettingViewController.h"

@interface JumpTool ()

@property (nonatomic, strong) NSDictionary <NSString *,Class> *jumpMap;

@end

@implementation JumpTool

+ (instancetype)tool
{
    static JumpTool *_tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [JumpTool new];
    });
    return _tool;
}

- (void)jumpWithStr:(NSString *)str
{
    NSURL *url = [[NSURL alloc]initWithString:str];
    NSString *scheme = [url scheme];
    if ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"]) {
        [self jumpWithH5WithURL:str];
        return;
    }
    [self jumpWithSchemeWithStr:str];
}

- (void)jumpWithH5WithURL:(NSString *)url
{
    HtmlViewController *vc = [HtmlViewController new];
    vc.isInAuthMode = self.isInAuthMode;
    vc.isNeedPopToRoot = self.isNeedPopToRoot;
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    [vc loadWithURL:url];
    [UIViewController.navVC pushViewController:vc animated:true];
}

- (void)jumpWithSchemeWithStr:(NSString *)str
{
    NSString *path = [str componentsSeparatedByString:@"?"].firstObject;
    NSString *params = [str componentsSeparatedByString:@"?"].lastObject;
    Class vcClass = self.jumpMap[path];
    if (vcClass == nil) {
        
        // 首页
        if ([path isEqualToString:@"po://weios.rca.sh/joolyes"]) {
            [UIViewController.navVC popToRootViewControllerAnimated:false];
            BaseTabViewController *tabVC = (BaseTabViewController *)UIViewController.nowWindow.rootViewController;
            if (![tabVC isKindOfClass:BaseTabViewController.class]) return;
            tabVC.selectedIndex = 0;
        }
        
        // 登陆
        if ([path isEqualToString:@"po://weios.rca.sh/inlove"]) {
            LoginPresent *view = [LoginPresent new];
            [view show];
        }
        
        return;
        
    }
    
    for (__kindof AC_BaseVC *subVC in UIViewController.navVC.childViewControllers) {
        if ([subVC isKindOfClass:vcClass]) {
            [UIViewController.navVC popToViewController:subVC animated:true];
            return;
        }
    }
    
    __kindof AC_BaseVC *vc = [vcClass new];
    
    if ([vc isKindOfClass:CertificationListViewController.class]) {
        CertificationListViewController *authVC = vc;
        authVC.productID = [self getPathParamWithName:@"filmmaker" ParamStr:params].integerValue;
    }
    
    [UIViewController.navVC pushViewController:vc animated:true];
}

- (NSString *)getPathParamWithName:(NSString *)paramName ParamStr:(NSString *)paramStr
{
    NSArray <NSString *>*paramItems = [paramStr componentsSeparatedByString:@"&"];
    for (NSString *paramItem in paramItems) {
        NSString *paramKey = [paramItem componentsSeparatedByString:@"="].firstObject;
        NSString *param = [paramItem componentsSeparatedByString:@"="].lastObject;
        
        if ([paramKey isEqualToString:paramName]) return param;
    }
    return @"";
}

#pragma mark - Init

- (NSDictionary *)jumpMap
{
    if (_jumpMap == nil) {
        _jumpMap = @{
            @"po://weios.rca.sh/showslove":SettingViewController.class,
            @"po://weios.rca.sh/crowyes":CertificationListViewController.class,
        };
    }
    return _jumpMap;
}

@end
