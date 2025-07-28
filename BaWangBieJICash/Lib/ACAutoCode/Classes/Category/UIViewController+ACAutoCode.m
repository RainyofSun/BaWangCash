//
//  UIViewController+ACAutoCode.m
//  ACAutoCode
//
//  Created by Acery on 2024/10/16.
//

#import "UIViewController+ACAutoCode.h"

@implementation UIViewController (ACAutoCode)

+ (UIViewController*)findLastVC:(UIViewController*)vc
{
    if (vc.presentedViewController) {
        return [UIViewController findLastVC:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0) {
            return [UIViewController findLastVC:svc.viewControllers.lastObject];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0) {
            return [UIViewController findLastVC:svc.topViewController];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0) {
            return [UIViewController findLastVC:svc.selectedViewController];
        } else {
            return vc;
        }
    } else {
        return vc;
    }
}

+ (UIWindow*)nowWindow
{
    UIWindow * win = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive || windowScene.activationState == UISceneActivationStateForegroundInactive){
                for (UIWindow *window in windowScene.windows){
                    if (window.isKeyWindow){
                        win = window;
                        break;
                    }
                }
            }
        }
        return win;
    }else {
        return  UIApplication.sharedApplication.keyWindow;
    }
}

+ (UIViewController*)tabBarVC
{
    UIViewController *viewController = nil;
    if (@available(iOS 13.0, *)) {
        viewController = [UIViewController nowWindow].rootViewController;
        if (viewController == nil) {
            return nil;
        }
    }else {
        viewController = [UIViewController nowWindow].rootViewController;
        if (viewController == nil) {
            return nil;
        }
    }
    if ([viewController isKindOfClass:UITabBarController.class]) {
        return viewController;
    }
    return nil;
}

+ (UIViewController *)currentVC
{
    UIViewController *viewController = [self nowWindow].rootViewController;
    if (viewController == nil)viewController = [self nowWindow].rootViewController;
    return [UIViewController findLastVC:viewController];
}

+ (UINavigationController*)navVC
{
    return UIViewController.currentVC.navigationController;
}

@end
