//
//  LogoutPresentView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "LogoutPresentView.h"

@interface LogoutPresentView ()

@property (nonatomic, strong) AC_BaseView *grayView;
@property (nonatomic, strong) AC_BaseView *agreeView;

@property (nonatomic, strong) UIImageView *agreeImg;

@property (nonatomic, strong) AC_BaseButton *cancelBtn;

@end

@implementation LogoutPresentView

- (void)setUpSubView
{
    [super setUpSubView];
    
//    self.title = @"Cancel your account";
//    self.titleLabel.font = Semibold(25);
    
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28);
        make.right.equalTo(@-28);
        make.centerY.equalTo(@0);
    }];
    
    ImgViewWithName(contentbk, @"logoff_bk");
    contentbk.userInteractionEnabled = YES;
    [self.contentView addSubview:contentbk];
    [contentbk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    UILabel *titleLab = [UILabel LabelWithFont:Semibold(25) TextColor:@"#000000" Text:@"Cancel your account"];
    [contentbk addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@30);
        make.centerX.equalTo(@0);
        make.height.equalTo(@26);
    }];
    
    UILabel *lab = [UILabel LabelWithFont:Semibold(18) TextColor:@"#000000" Text:@"Deleting your accountwill result in thepermanentloss ofthefollowing data andfeatures:"];
    lab.numberOfLines = 0;
    lab.textAlignment = NSTextAlignmentLeft;
    [contentbk addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(19);
        make.left.equalTo(@21);
        make.right.equalTo(@-21);
    }];
    

    [contentbk addSubview:self.grayView];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab.mas_bottom).offset(12);
        make.left.equalTo(@18);
        make.right.equalTo(@-18);
    }];
    
    [contentbk addSubview:self.agreeView];
    [self.agreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.grayView.mas_bottom).offset(16);
        make.left.equalTo(@28);
        make.right.equalTo(@-28);
        make.height.equalTo(@22);
    }];
    
    [contentbk addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.height.equalTo(@52);
        make.top.equalTo(self.agreeImg.mas_bottom).offset(20);
        make.right.equalTo(@-24);
        make.bottom.greaterThanOrEqualTo(@-16);
    }];
    
    UIButton *btn = [UIButton ImageBtnWithImgName:@"present_close"];
    [btn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.contentView.mas_bottom).offset(16);
        make.height.equalTo(btn.mas_width).multipliedBy(24.0/24.0);
    }];
    
    self.isAgree = false;
}


- (void)comfirmCilck
{
    if (self.disMissBlock) self.disMissBlock(self);
}

- (void)disMiss
{
    [super disMiss];
}

- (void)setIsAgree:(bool)isAgree
{
    _isAgree = isAgree;
    if (isAgree){
        self.agreeImg.image = IMAGE(@"login_chose_yes");
    }else{
        self.agreeImg.image = IMAGE(@"logoff_disable");
    }
}

- (void)agreeImgCall
{
    self.isAgree = !self.isAgree;
}

#pragma mark - init

- (AC_BaseView *)grayView
{
    if (_grayView == nil) {
        _grayView = [AC_BaseView new];
        [_grayView setCornerRadius:15];
        _grayView.backgroundColor = HEXCOLOR(@"#F6F6F6");
        
        UILabel *onelab = [UILabel LabelWithFont:Regular(14) TextColor:@"#727272" Text:@"All history will be deleted and cannot be recovered"];
        onelab.numberOfLines = 0;
        onelab.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:onelab];
        [onelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@12);
            make.right.equalTo(@-11);
            make.top.equalTo(@11);
        }];
        
        UILabel *twolab = [UILabel LabelWithFont:Regular(14) TextColor:@"#727272" Text:@"Including your identity information, personal information and other related information"];
        twolab.numberOfLines = 0;
        twolab.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:twolab];
        [twolab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(onelab.mas_bottom).offset(6);
            make.left.equalTo(@12);
            make.right.equalTo(@-11);
        }];
        
        UILabel *threelab = [UILabel LabelWithFont:Regular(14) TextColor:@"#727272" Text:@"Including your identity information, personal information and other related information"];
        threelab.numberOfLines = 0;
        threelab.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:threelab];
        [threelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(twolab.mas_bottom).offset(6);
            make.left.equalTo(@12);
            make.right.equalTo(@-11);
        }];
    }
    return _grayView;
}

- (AC_BaseView *)agreeView
{
    if (_agreeView == nil) {
        _agreeView = [AC_BaseView new];
        _agreeView.backgroundColor = HEXCOLOR(@"#FFFFFF");
        
        
        [_agreeView addSubview:self.agreeImg];
        [self.agreeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.equalTo(@0);
            make.height.width.equalTo(@20);
        }];
        
        UILabel *agreelab = [UILabel LabelWithFont:Regular(14) TextColor:@"#000000" Text:@"I have read and agreed to the above"];
        [_agreeView addSubview:agreelab];
        [agreelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(self.agreeImg.mas_right).offset(6);
            make.height.equalTo(@22);
        }];
    }
    return _agreeView;
}

- (UIImageView *)agreeImg
{
    if (_agreeImg == nil) {
        _agreeImg = [UIImageView new];
        ImgViewWithName(agree, @"Credito_Pesos_xuan_blue");
        _agreeImg = agree;
        _agreeImg.userInteractionEnabled = YES;
        [_agreeImg addTarget:self action:@selector(agreeImgCall)];
        
    }
    return _agreeImg;
}

- (AC_BaseButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        _cancelBtn = [AC_BaseButton TextBtnWithTitle:@"Account cancellation" titleColor:@"#FFFFFF" font:Semibold(16)];
            [_cancelBtn setBackgroundImage:IMAGE(@"next_btn") forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"Account cancellation" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(comfirmCilck) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

@end
