//
//  AppDelegate.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "AppDelegate.h"
#import "NetMonitorTool+Monitor.h"
#import "APPLaunchViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [NetMonitorTool startReachabilityMonitoring];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    APPLaunchViewController *launchVC = [APPLaunchViewController new];
    launchVC.application = application;
    launchVC.launchOptions = launchOptions;
    self.window.rootViewController = launchVC;
    [self.window makeKeyAndVisible];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES; // 点击空白处收起键盘
    
    return YES;
}


@end
