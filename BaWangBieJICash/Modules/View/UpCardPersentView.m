//
//  UpCardPersentView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "UpCardPersentView.h"

@interface UpCardPersentView ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation UpCardPersentView

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.title = @"Correct case";
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@17);
    }];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28);
        make.right.equalTo(@-28);
        make.top.equalTo(@147);
   
    }];
    
    ImgViewWithName(contentbk, @"logoff_bk");
    contentbk.userInteractionEnabled = YES;
    [self.contentView addSubview:contentbk];
    [contentbk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [contentbk addSubview:self.stackView];
    [contentbk addSubview:self.comfirmBtn];
    ImgViewWithName(idcard, @"idcard_bianzu");
    [self.stackView addArrangedSubview:idcard];
    [idcard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(idcard.mas_width).multipliedBy(342.0/300.0);
    }];
    
    ImgViewWithName(idcard_red_one, @"idcard_red_one");
    [idcard addSubview:idcard_red_one];
    [idcard_red_one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@68);
        make.top.equalTo(@255);
        make.height.width.equalTo(@16);
    }];
    ImgViewWithName(idcard_red_two, @"idcard_red_two");
    [idcard addSubview:idcard_red_two];
    [idcard_red_two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@179);
        make.top.equalTo(@255);
        make.height.width.equalTo(@16);
    }];
    ImgViewWithName(idcard_red_three, @"idcard_red_three");
    [idcard addSubview:idcard_red_three];
    [idcard_red_three mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.top.equalTo(@255);
        make.height.width.equalTo(@16);
    }];
    
    __weakSelf;
    self.comfirmBlock = ^{
        __strongSelf;
        [self disMiss];
        if (self.disMissBlock) self.disMissBlock();
    };
    
}

- (void)disMiss
{
    [super disMiss];
    
}

@end
