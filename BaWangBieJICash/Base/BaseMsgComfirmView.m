//
//  BaseMsgComfirmView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "BaseMsgComfirmView.h"

@implementation BaseMsgComfirmView

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.backgroundColor = [HEXCOLOR(@"#000000") colorWithAlphaComponent:0.7];
    
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28);
        make.right.equalTo(@-28);
        make.centerY.equalTo(@0);
    }];
    
    UIButton *btn = [UIButton ImageBtnWithImgName:@"present_close"];
    [btn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.contentView.mas_bottom).offset(16);
        make.height.equalTo(btn.mas_width).multipliedBy(24.0/24.0);
    }];
    
    
    self.titleLabel.textColor = HEXCOLOR(@"#000000");
    self.titleLabel.font = Semibold(17);
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel removeConstraints:self.titleLabel.constraints];
    
    self.contentLabel.textColor = HEXCOLOR(@"#666666");
    self.contentLabel.font = Regular(14);
    
    
    [self.comfirmBtn setBackgroundImage:IMAGE(@"next_btn") forState:UIControlStateNormal];
    self.comfirmBtn.backgroundColor = HEXCOLOR(@"#FFFFFF");
    [self.comfirmBtn setTitle:@"OK" forState:UIControlStateNormal];
    self.comfirmBtn.titleLabel.font = Semibold(16);
    [self.comfirmBtn setTitleColor:HEXCOLOR(@"#FFFFFF") forState:UIControlStateNormal];
    
    self.stackView.spacing = 12;
    
    // layout
    [self.comfirmBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.height.equalTo(@52);
        make.top.equalTo(self.stackView.mas_bottom).offset(20);
        make.right.equalTo(@-24);
        make.bottom.equalTo(@-16);
    }];
    
    [self.stackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@21);
        make.right.equalTo(@-21);
        make.top.equalTo(@24);
    }];
}

- (void)addKeyboardAutoOffset
{
    [Noti_Center addObserver:self selector:@selector(keyboardShowCall:) name:UIKeyboardWillShowNotification object:nil];
    [Noti_Center addObserver:self selector:@selector(keyboardHideCall:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Event

- (void)keyboardShowCall:(NSNotification *)noti
{
    
    NSValue *keyRect = noti.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyFrame = keyRect.CGRectValue;
    
    UIView *fristResponder = [UIViewController.nowWindow getFristResponder];
    CGRect rectInWin = [fristResponder.superview convertRect:fristResponder.frame toView:UIViewController.nowWindow];
    
    CGFloat yOffset = rectInWin.origin.y + rectInWin.size.height - keyFrame.origin.y + 10;
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@((yOffset)*-1));
        make.width.equalTo(@(kScreenWidth));
    }];
}

- (void)keyboardHideCall:(NSNotification *)noti
{
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@(0));
        make.width.equalTo(@(kScreenWidth));
    }];
}

@end
