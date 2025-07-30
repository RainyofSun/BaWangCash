//
//  CertificationListTableViewCell.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "CertificationListTableViewCell.h"

@interface CertificationListTableViewCell ()

@property (nonatomic, strong) UILabel *title;

@property (nonatomic ,strong) UIImageView *icon;

@property (nonatomic, strong) UIImageView *allowImg;

@end

@implementation CertificationListTableViewCell

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.contentView.backgroundColor = UIColor.clearColor;
    
    
    ImgViewWithName(contentbk, @"ident_whiteView");
    contentbk.userInteractionEnabled = YES;
    [self.contentView addSubview:contentbk];
    [contentbk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@14);
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
        make.height.equalTo(@60);
        make.bottom.equalTo(@0);
    }];
    
    [contentbk addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@83);
        make.centerY.equalTo(@0);
        make.height.equalTo(@20);
    }];
    
    [contentbk addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@26);
        make.centerY.equalTo(@0);
        make.height.width.equalTo(@40);
    }];
    
    [contentbk addSubview:self.allowImg];
    [self.allowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@20);
        make.right.equalTo(@-20);
        make.centerY.equalTo(@0);
    }];
   
}


- (void)setDislayModel:(PC_ProduceDetailModel_Rec *)dislayModel
{
    _dislayModel = dislayModel;
    
    self.title.text = dislayModel.pc_beck;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:dislayModel.pc_closed]];
    
    // 是否已完成状态 0未完成 1已完成
    NSInteger complet = dislayModel.pc_usenet;
    if (complet == 1) {
        self.allowImg.image = IMAGE(@"icon_complete_black");
    }else{
        self.allowImg.image = IMAGE(@"ident_arrow_left");
    }
    
}




#pragma mark - init

- (UILabel *)title
{
    if (_title == nil) {
        _title = [UILabel LabelWithFont:Regular(16) TextColor:@"#000000" Text:@""];
    }
    return _title;
}

- (UIImageView *)icon
{
    if (_icon == nil){
        _icon = [UIImageView new];
        _icon.userInteractionEnabled = YES;
    }
    return _icon;
}

- (UIImageView *)allowImg
{
    if (_allowImg == nil){
        ImgViewWithName(imgView, @"ident_arrow_left");
        _allowImg = imgView;
        _allowImg.userInteractionEnabled = YES;
    }
    return _allowImg;
}

@end
