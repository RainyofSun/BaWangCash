//
//  UIApplication+ACAutoCode.m
//  ACAutoCode
//
//  Created by Acery on 2025/3/14.
//

#import "UIApplication+ACAutoCode.h"

@implementation UIApplication (ACAutoCode)

- (CGFloat)getStatusBarHeight
{
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = (UIWindowScene *)[UIApplication.sharedApplication.connectedScenes anyObject];
        if (windowScene)
            return windowScene.statusBarManager.statusBarFrame.size.height;
    }else{
        return UIApplication.sharedApplication.statusBarFrame.size.height;
    }
    return 0;
}

@end
