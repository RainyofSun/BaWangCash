//
//  AddressTableViewCell.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self.contentView addSubview:self.addressTitle];
    [self.addressTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@11);
        make.bottom.equalTo(@-10);
        make.height.equalTo(@18);
    }];
    
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.addressTitle.mas_centerY);
        make.right.equalTo(@-16);
        make.height.width.equalTo(@20);
    }];
}

- (void)setAddressModel:(PC_AdressModel_Inserting *)addressModel
{
    _addressModel = addressModel;
    self.addressTitle.text = addressModel.pc_shoot;
}

#pragma mark - init

- (UILabel *)addressTitle
{
    if (_addressTitle == nil) {
        _addressTitle = [UILabel LabelWithFont:Regular(14) TextColor:@"#0A0220" Text:@""];
    }
    return _addressTitle;
}

- (AC_BaseButton *)selectBtn
{
    if (_selectBtn == nil) {
        _selectBtn = [AC_BaseButton new];
        [_selectBtn setBackgroundImage:IMAGE(@"address_icon_done") forState:UIControlStateNormal];
    }
    return _selectBtn;
}

@end
