//
//  BankCardPresentView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "BankCardPresentView.h"

@implementation BankCardPresentView

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28);
        make.right.equalTo(@-28);
        make.top.equalTo(@231);
   
    }];
    
    ImgViewWithName(contentbk, @"logoff_bk");
    contentbk.userInteractionEnabled = YES;
    [self.contentView addSubview:contentbk];
    [contentbk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    
    ImgViewWithName(bank, @"icon_Bank");
    [contentbk addSubview:bank];
    [bank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(bank.mas_width).multipliedBy(90.0/90.0);
        make.centerX.equalTo(@0);
        make.top.equalTo(@32);
    }];
    
    UILabel *lab = [UILabel LabelWithFont:Semibold(25) TextColor:@"#000000" Text:@"1234 1234 1234"];
    [contentbk addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@22);
        make.centerX.equalTo(@0);
        make.top.equalTo(bank.mas_bottom).offset(24);
    }];
    
    UILabel *detaillab = [UILabel LabelWithFont:Regular(14) TextColor:@"#000000" Text:@"pleas confirm the credit card number you provided is correct from"];
    detaillab.numberOfLines = 0;
    detaillab.textAlignment = NSTextAlignmentCenter;
    [contentbk addSubview:detaillab];
    [detaillab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.top.equalTo(lab.mas_bottom).offset(14);
    }];
    
    [contentbk addSubview:self.comfirmBtn];
}

@end
