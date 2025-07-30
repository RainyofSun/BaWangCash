//
//  AppTipsConfirmView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "AppTipsConfirmView.h"

@implementation AppTipsConfirmView

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.contentView.backgroundColor = UIColor.clearColor;
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28);
        make.right.equalTo(@-28);
        make.top.equalTo(@219);
        
    }];
    
    ImgViewWithName(contentbk, @"kingtips_bk");
    contentbk.userInteractionEnabled = YES;
    [self.contentView insertSubview:contentbk atIndex:0];
    [contentbk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    
    UILabel *lab = [UILabel LabelWithFont:Semibold(24) TextColor:@"#000000" Text:@"Kind tips"];
    [contentbk addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@22);
        make.centerX.equalTo(@0);
        make.top.equalTo(@100);
    }];
    

    [contentbk addSubview:self.detailab];
    [self.detailab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@126);
        make.centerX.equalTo(@0);
        make.top.equalTo(@173);
    }];
    
}

- (UILabel *)detailab
{
    if (_detailab == nil) {
        _detailab = [UILabel LabelWithFont:Medium(14) TextColor:@"#7A7A7A" Text:@""];
        _detailab.numberOfLines = 0;
        _detailab.textAlignment = NSTextAlignmentLeft;
    }
    return _detailab;
}

@end
