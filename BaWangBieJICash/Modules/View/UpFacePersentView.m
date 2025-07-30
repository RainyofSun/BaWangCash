//
//  UpFacePersentView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "UpFacePersentView.h"

@implementation UpFacePersentView

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
    
    ImgViewWithName(contentbk, @"idcart_bk");
    contentbk.userInteractionEnabled = YES;
    [self.contentView addSubview:contentbk];
    [contentbk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [contentbk addSubview:self.stackView];
    [contentbk addSubview:self.comfirmBtn];
    ImgViewWithName(idcard, @"face_bianzu");
    [self.stackView addArrangedSubview:idcard];
    [idcard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(idcard.mas_width).multipliedBy(342.0/300.0);
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
