//
//  AC_BasePresentView.m
//  ACAuotCode
//
//  Created by Acery on 2022/8/4.
//

#import "AC_BasePresentView.h"
#import "AC_Tool.h"

@interface AC_BasePresentView ()

@end

@implementation AC_BasePresentView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.canOutsideClose) return;
    
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    if (!CGRectContainsPoint(self.contentView.frame, touchPoint)) {
        [self disMissCall];
    }
}

- (void)setUpSubView
{
    self.frame = UIScreen.mainScreen.bounds;
    self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
    self.canOutsideClose = true;
    
    _contentView = [self makeContentView];
    self.contentView.userInteractionEnabled = true;
    [self addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@(0));
        make.width.equalTo(@(kScreenWidth));
    }];
}

- (__kindof AC_BaseView *)makeContentView
{
    return [AC_BaseView new];
}

#pragma mark - func

- (void)showInView:(__kindof UIView *)showInView
{
    _isShow = true;
    [showInView addSubview:self];
}

- (void)show
{
    [self showInView:UIViewController.nowWindow];
}

#pragma mark - event handel

- (void)disMissCall
{
    [self disMiss];
}

- (void)disMiss
{
    _isShow = false;
    [self removeFromSuperview];
}

@end
