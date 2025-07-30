//
//  AppAuthViewController.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "AppAuthViewController.h"
#import "CertificationListViewController.h"

@interface AppAuthViewController ()

@end

@implementation AppAuthViewController

- (void)backBtnClick
{
    for (__kindof UIViewController *subVC in self.navigationController.childViewControllers) {
        if ([subVC isMemberOfClass:CertificationListViewController.class]) {
            [self.navigationController popToViewController:subVC animated:true];
            return;
        }
    }
}

@end
