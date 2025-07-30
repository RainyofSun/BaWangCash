//
//  SettingViewController.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "SettingViewController.h"
#import "LogoutPresentView.h"
#import "ExitPresentView.h"
#import "LoginLogic.h"

@interface SettingViewController ()

@property (nonatomic, strong) AC_BaseButton *exitBtn;
@property (nonatomic, strong) AC_BaseButton *accountcancelBtn;

@end

@implementation SettingViewController

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.title = @"Settings";

    ImgViewWithName(topImg, @"setting_bk_top");
    [self.view insertSubview:topImg atIndex:0];
    [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
    }];
    
    ImgViewWithName(icon, @"setting_logo");
    [self.view addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navBar.mas_bottom).offset(32);
        make.width.height.equalTo(@80);
        make.centerX.equalTo(@0);
    }];
    
    UILabel *pcLab = [UILabel LabelWithFont:Semibold(20) TextColor:@"#000000" Text:@"Power Cash"];
    [self.view addSubview:pcLab];
    [pcLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_bottom).offset(12);
        make.centerX.equalTo(@0);
        make.height.equalTo(@28);
    }];
    
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *version = [@"V" stringByAppendingString:UIApplication.sharedApplication.appVersion];
    UILabel *versionLab = [UILabel LabelWithFont:Regular(14) TextColor:@"#0A0220" Text:version];
    [self.view addSubview:versionLab];
    [versionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pcLab.mas_bottom).offset(6);
        make.centerX.equalTo(@0);
        make.height.equalTo(@20);
    }];
    
    [self.view addSubview:self.exitBtn];
    [self.exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-100);
        make.left.equalTo(@32);
        make.right.equalTo(@-32);
        make.height.equalTo(@54);
    }];
    
    [self.view addSubview:self.accountcancelBtn];
    [self.accountcancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-34);
        make.left.equalTo(@32);
        make.right.equalTo(@-32);
        make.height.equalTo(@54);
    }];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


#pragma mark - func

- (void)accountCancelCall
{
    LogoutPresentView *view = [LogoutPresentView new];
    view.disMissBlock = ^(LogoutPresentView * _Nonnull logoff) {
      
        if (view.isAgree == false) {
            [ProgressHud showMessage:@"Please read the above content carefully"];
        }else {
            [logoff disMiss];
            [LoginLogic.tool logOff];
        }
    };
    [view show];
    
    
}

- (void)exitCall
{
    ExitPresentView *view = [ExitPresentView new];
    view.comfirmBlock = ^{
        [LoginLogic.tool logOut];
    };
    [view show];
}



#pragma mark - init

- (AC_BaseButton *)exitBtn
{
    if (_exitBtn == nil) {
        _exitBtn = [AC_BaseButton TextBtnWithTitle:@"Exit" titleColor:@"#FFFFFF" font:Regular(18)];
        [_exitBtn setBackgroundImage:IMAGE(@"setting_exit") forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(exitCall) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitBtn;
}

- (AC_BaseButton *)accountcancelBtn
{
    if (_accountcancelBtn == nil) {
        _accountcancelBtn = [AC_BaseButton TextBtnWithTitle:@"Account cancellation" titleColor:@"#4497F5" font:Regular(18)];
        [_accountcancelBtn setCornerRadius:30];
        _accountcancelBtn.backgroundColor = HEXCOLOR(@"#FFFFFF");
        _accountcancelBtn.layer.borderWidth = 1;
        _accountcancelBtn.layer.borderColor = HEXCOLOR(@"#4497F5").CGColor;
        [_accountcancelBtn addTarget:self action:@selector(accountCancelCall) forControlEvents:UIControlEventTouchUpInside];
    }
    return _accountcancelBtn;
}

@end
