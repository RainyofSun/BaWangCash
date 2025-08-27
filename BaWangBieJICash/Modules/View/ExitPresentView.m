//
//  ExitPresentView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "ExitPresentView.h"

@implementation ExitPresentView

- (void)setUpSubView
{
    [super setUpSubView];
    
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
    
    UILabel *lab = [UILabel LabelWithFont:Semibold(25) TextColor:@"#000000" Text:@"Abort"];
    [contentbk addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@22);
        make.centerX.equalTo(@0);
        make.top.equalTo(@35);
    }];
    
    UILabel *detaillab = [UILabel LabelWithFont:Regular(16) TextColor:@"#000000" Text:@"You will not be able to enjoy this loan after you withdraw"];
    detaillab.numberOfLines = 0;
    detaillab.textAlignment = NSTextAlignmentCenter;
    [contentbk addSubview:detaillab];
    [detaillab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.left.equalTo(@32);
        make.right.equalTo(@-32);
        make.top.equalTo(lab.mas_bottom).offset(21);
    }];
    
    UILabel *numlab = [UILabel LabelWithFont:ShuHeiTi(48) TextColor:@"#000000" Text:@"₱ 98,000"];
    ImgViewWithName(loan, @"exit_priceview");
    [loan addSubview:numlab];
    [contentbk addSubview:loan];
    [loan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@250);
        make.centerX.equalTo(@0);
        make.top.equalTo(detaillab.mas_bottom).offset(7);
    }];
    
    [numlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(loan);
        make.centerY.mas_equalTo(loan).offset(3);
    }];
    
    [contentbk addSubview:self.comfirmBtn];
    [self.comfirmBtn setTitle:@"Exit" forState:UIControlStateNormal];
    self.comfirmBlock = ^{
        
    };
}

@end
