//
//  AC_BaseBottomAlertView.m
//  ACAuotCode
//
//  Created by Acery on 2024/5/7.
//

#import "AC_BaseBottomAlertView.h"
#import "AC_BaseButton.h"
#import "UIButton+ACAutoCode.h"

@interface AC_BaseBottomAlertView ()

@property (nonatomic, strong) AC_BaseButton *cancelBtn;

@property (nonatomic, strong) AC_BaseView *spacingView;

@end

@implementation AC_BaseBottomAlertView

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.contentView.backgroundColor = HEXCOLOR(@"#1D1C22");
    [self.alertStackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
    }];
    
    [self.contentView addSubview:self.spacingView];
    [self.spacingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.alertStackView.mas_bottom);
        make.height.equalTo(@8);
    }];
    
    [self.contentView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.spacingView.mas_bottom);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@(kBottomHeight*-1));
        make.height.equalTo(@56);
    }];
}

#pragma mark - init

- (AC_BaseButton *)cancelBtn
{
    if (_cancelBtn == nil){
        _cancelBtn = [AC_BaseButton TextBtnWithTitle:@"取消" titleColor:@"#C0C0C0" font:Regular(16)];
        [_cancelBtn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (AC_BaseView *)spacingView
{
    if (_spacingView == nil) {
        _spacingView = [AC_BaseView new];
        _spacingView.backgroundColor = HEXCOLOR(@"#151419");
    }
    return _spacingView;
}

@end
