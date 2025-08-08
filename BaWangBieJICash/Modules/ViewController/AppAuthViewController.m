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

- (void)setUpSubView {
    [super setUpSubView];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
}

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
