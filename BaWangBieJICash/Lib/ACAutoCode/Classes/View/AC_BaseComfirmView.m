//
//  AC_BaseComfirmView.m
//  ACAuotCode
//
//  Created by Acery on 2024/5/7.
//

#import "AC_BaseComfirmView.h"

@interface AC_BaseComfirmView ()

@property (nonatomic, strong) AC_BaseButton *cancelBtn;

@end

@implementation AC_BaseComfirmView

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.contentView.backgroundColor = HEXCOLOR(@"#1D1C22");
    [self.contentView setCornerRadius:15];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@53);
        make.right.equalTo(@-53);
        make.centerY.equalTo(@0);
    }];
    
    [self.contentView addSubview:self.stackView];
    [self.stackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@48);
        make.right.equalTo(@-48);
        make.top.equalTo(@28);
    }];
    
    [self.contentView addSubview:self.cancelBtn];
    [self.cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.height.equalTo(@30);
        make.top.equalTo(self.stackView.mas_bottom).offset(28);
        make.bottom.equalTo(@-20);
    }];
    
    [self.contentView addSubview:self.comfirmBtn];
    [self.comfirmBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.height.equalTo(@30);
        make.centerY.equalTo(self.cancelBtn);
        make.left.equalTo(self.cancelBtn.mas_right).offset(20);
        make.width.equalTo(self.cancelBtn);
    }];
}

- (void)cancelCall
{
    [self disMiss];
    if (self.cancelBlock)self.cancelBlock();
}

+ (void)showWithTitle:(NSString *)title
                      Content:(NSString *)content
                 ComfirmBlock:(void(^)(void))comfirmBlock
{
    AC_BaseComfirmView *view = [AC_BaseComfirmView new];
    view.title = title;
    view.content = content;
    view.comfirmBlock = ^{
        if (comfirmBlock) comfirmBlock();
    };
    [view show];
}

#pragma mark - init

- (AC_BaseButton *)cancelBtn
{
    if (_cancelBtn == nil){
        _cancelBtn = [AC_BaseButton new];
        [_cancelBtn setCornerRadius:15];
        _cancelBtn.backgroundColor = [HEXCOLOR(@"#FFFFFF") colorWithAlphaComponent:0.5];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:HEXCOLOR(@"#C0C0C0") forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = Regular(14);
        [_cancelBtn addTarget:self action:@selector(cancelCall) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}


@end
