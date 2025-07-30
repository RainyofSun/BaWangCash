//
//  MineTableViewCell.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "MineTableViewCell.h"

@interface MineTableViewCell ()

@property (nonatomic, strong) UILabel *title;

@property (nonatomic ,strong) UIImageView *icon;

@property (nonatomic, strong) UIImageView *allowImg;

@end

@implementation MineTableViewCell

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.contentView.backgroundColor = UIColor.clearColor;
   
    AC_BaseView *contentbk = [AC_BaseView new];
    contentbk.backgroundColor = HEXCOLOR(@"#FFFFFF");
    [contentbk setCornerRadius:16];
    [self.contentView addSubview:contentbk];
    [contentbk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@16);
        make.left.right.equalTo(@0);
        make.height.equalTo(@60);
        make.bottom.equalTo(@0);
    }];
    
    [contentbk addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.height.width.equalTo(@25);
        make.centerY.equalTo(@0);
    }];
    [contentbk addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(25);
        make.height.equalTo(@20);
        make.centerY.equalTo(@0);
    }];
    
    [contentbk addSubview:self.allowImg];
    [self.allowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-17);
        make.height.width.equalTo(@15);
        make.centerY.equalTo(@0);
    }];
}

- (void)setMeModel:(PC_MeModel_Inserting *)meModel
{
    _meModel = meModel;
    self.title.text = meModel.pc_beck;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:meModel.pc_gathered]];
}

#pragma mark - init

- (UILabel *)title
{
    if (_title == nil) {
        _title = [UILabel LabelWithFont:Regular(16) TextColor:@"0A0220" Text:@""];
    }
    return _title;
}

- (UIImageView *)icon
{
    if (_icon == nil){
        ImgViewWithName(imgView, @"me_icon_about");
        _icon = imgView;
    }
    return _icon;
}

- (UIImageView *)allowImg
{
    if (_allowImg == nil){
        ImgViewWithName(imgView, @"me_arrow_left");
        _allowImg = imgView;
    }
    return _allowImg;
}

@end
