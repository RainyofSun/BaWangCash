//
//  BaseViewController.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.view.backgroundColor = HEXCOLOR(@"#FFFFFF");
    self.navStyle = AC_BaseVC_NAVStyle_White;
    self.vcTitleLabel.font = Medium(16);
    self.vcTitleLabel.textColor = HEXCOLOR(@"#FFFFFF");
    [self.backBtn setBackgroundImage:IMAGE(@"ident_back_white") forState:UIControlStateNormal];
    
    [self.backBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.width.height.equalTo(@21);
        make.left.equalTo(@18);
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (@available(iOS 13.0, *)) {
        return UIStatusBarStyleDarkContent;
    } else {
        return UIStatusBarStyleLightContent;
    }
}

- (NSString *)getBackBtnIcon
{
    switch (self.navStyle) {
        case AC_BaseVC_NAVStyle_White:
            return @"nav_back";
            break;
            
        default:
            return @"1";
            break;
    }
}

- (NSDictionary<NSAttributedStringKey, id> *)getNavBarTitleAttribut
{
    
    switch (self.navStyle) {
        case AC_BaseVC_NAVStyle_White:
            return @{NSForegroundColorAttributeName:HEXCOLOR(@"#FFFFFF"),
                     NSFontAttributeName:Medium(22)};
            break;
            
        default:
            return @{NSForegroundColorAttributeName:HEXCOLOR(@"#FFFFFF"),
                     NSFontAttributeName:Regular(26)};
            break;
    }
}

- (__kindof LYEmptyView *)makeEmptyView
{
    LYEmptyView *emptyView = [LYEmptyView emptyViewWithImage:IMAGE(@"") titleStr:@"" detailStr:@""];
    emptyView.titleLabTextColor = HEXCOLOR(@"#666666");
    
    return emptyView;
}

@end
