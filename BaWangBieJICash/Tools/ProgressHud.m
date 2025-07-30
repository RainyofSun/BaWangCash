//
//  ProgressHud.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "ProgressHud.h"

@implementation ProgressHud

+ (void)showMessage:(NSString *)Msg
{
    if (![Msg isExist]) return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *tip = [[MBProgressHUD alloc]initWithView:UIViewController.nowWindow];
        [UIViewController.nowWindow addSubview:tip];
        tip.mode = MBProgressHUDModeText;
        
        tip.label.text = Msg;
        tip.label.numberOfLines = 0;
        [tip showAnimated:YES];
        [tip hideAnimated:YES afterDelay:1.0];
    });
}


+ (void)showLoading
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:UIViewController.nowWindow animated:true];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.contentColor = HEXCOLOR(@"#F6F6F6");
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [HEXCOLOR(@"#000000") colorWithAlphaComponent:0.7];
        hud.margin = 16.0;
        hud.bezelView.layer.cornerRadius = 8.0;
        [hud showAnimated:YES];
    });
}

+ (void)hiddenLoading
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:UIViewController.nowWindow animated:true];
    });
}

@end
