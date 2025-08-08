//
//  AC_BaseMsgComfirmView.m
//  ACAuotCode
//
//  Created by Acery on 2024/7/2.
//

#import "AC_BaseMsgComfirmView.h"

@interface AC_BaseMsgComfirmView ()

@property (nonatomic, strong) UIStackView *stackView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) AC_BaseButton *comfirmBtn;

@end

@implementation AC_BaseMsgComfirmView

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
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@48);
        make.right.equalTo(@-48);
        make.top.equalTo(@28);
    }];
    
    [self.contentView addSubview:self.comfirmBtn];
    [self.comfirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.height.equalTo(@30);
        make.top.equalTo(self.stackView.mas_bottom).offset(28);
        make.right.equalTo(@-20);
        make.bottom.equalTo(@-20);
    }];
}

- (void)comfirmCall
{
    [self disMiss];
    if (self.comfirmBlock)self.comfirmBlock();
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    if (![title isExist]) return;
    self.titleLabel.text = title;
    [self.stackView insertArrangedSubview:self.titleLabel atIndex:0];
}

- (void)setContent:(NSString *)content
{
    _content = content;
    if (![content isExist]) return;
    self.contentLabel.text = content;
    [self.stackView addArrangedSubview:self.contentLabel];
}

#pragma mark - init

- (UILabel *)titleLabel
{
    if (_titleLabel == nil){
        _titleLabel = [UILabel LabelWithFont:Regular(16) TextColor:@"#DDDDDD" Text:@""];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 1;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@21);
        }];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil){
        _contentLabel = [UILabel LabelWithFont:Regular(14) TextColor:@"#999999" Text:@""];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (AC_BaseButton *)comfirmBtn
{
    if (_comfirmBtn == nil){
        _comfirmBtn = [AC_BaseButton new];
        [_comfirmBtn setCornerRadius:15];
        _comfirmBtn.backgroundColor = MAIN_COLOR;
        [_comfirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_comfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _comfirmBtn.titleLabel.font = Regular(14);
        [_comfirmBtn addTarget:self action:@selector(comfirmCall) forControlEvents:UIControlEventTouchUpInside];
    }
    return _comfirmBtn;
}

- (UIStackView *)stackView
{
    if (_stackView == nil){
        _stackView = [UIStackView new];
        _stackView.spacing = 8;
        _stackView.axis = UILayoutConstraintAxisVertical;
    }
    return _stackView;
}

@end
