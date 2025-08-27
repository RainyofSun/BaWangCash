//
//  BasePresentView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "BasePresentView.h"

@implementation BasePresentView

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

- (void)show {
    [UIViewController.nowWindow endEditing:YES];
    [super show];
}

- (void)disMiss
{
    if (self.didDismissBlock) self.didDismissBlock();
    [super disMiss];
}

@end
