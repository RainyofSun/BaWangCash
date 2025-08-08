//
//  OrderTableViewCell.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/30.
//

#import "OrderTableViewCell.h"
#import "CustomGradientLabel.h"

@interface OrderTableViewCell ()

@property (nonatomic ,strong) AC_BaseView *cellView;

// 右侧按钮
@property (nonatomic ,strong) AC_BaseButton *applyBtn;

/// 标题
@property (nonatomic, strong) CustomGradientLabel *nameLabel;

/// 底部协议链接
@property (nonatomic, strong) AC_BaseButton *loanAgreementButton;

@property (nonatomic, strong) UIStackView *infoView;

@property (nonatomic, strong) UIImageView *iconImg;

@end

@implementation OrderTableViewCell

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self.contentView addSubview:self.cellView];
    [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@16);
        make.bottom.equalTo(@0).priorityLow();
    }];
    
    [self.cellView addSubview:self.applyBtn];
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-16);
        make.top.equalTo(@17);
        make.width.equalTo(@100);
        make.height.equalTo(@34);
    }];
}

- (void)setOrderModel:(PC_OrderListModel_Inserting *)orderModel
{
    _orderModel = orderModel;
    
    self.nameLabel.text = orderModel.pc_instruct;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:orderModel.pc_seminar]];
    [self.applyBtn setTitle:orderModel.pc_conflicts forState:UIControlStateNormal];
    
    for (UIView *subView in self.infoView.arrangedSubviews) {
        [self.infoView removeArrangedSubview:subView];
        [subView removeFromSuperview];
    }
    for (PC_OrderListModel_Inserting_Stuffed *model in orderModel.pc_stuffed) {
        [self.infoView addArrangedSubview:[self makeInfoCellWithModel:model]];
    }
    
    
    // 借款协议 展示文案  为空不显示
    if ([orderModel.pc_golfer isEqualToString:@""]) {
        self.loanAgreementButton.hidden = YES;
    }else {
        [self.loanAgreementButton setTitle:orderModel.pc_golfer forState:UIControlStateNormal];
        self.loanAgreementButton.hidden = NO;
    }
}

- (AC_BaseView *)makeInfoCellWithModel:(PC_OrderListModel_Inserting_Stuffed *)model
{
    AC_BaseView *view = [AC_BaseView new];
    
    UILabel *title = [UILabel LabelWithFont:Regular(14) TextColor:@"#333333" Text:model.pc_beck];
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(@0);
        make.height.equalTo(@20);
    }];
    
    UILabel *subTitle = [UILabel LabelWithFont:Regular(14) TextColor:@"#333333" Text:model.pc_johnny];
    subTitle.textAlignment = NSTextAlignmentRight;
    [view addSubview:subTitle];
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(@0);
        make.height.equalTo(@20);
        make.left.equalTo(title.mas_right);
    }];
    
    return view;
}


- (void)loanAgreementButtonClick
{
    [JumpTool.tool jumpWithStr:self.orderModel.pc_viewing];
}

#pragma mark - init

- (AC_BaseView *)cellView
{
    if (_cellView == nil) {
        _cellView = [AC_BaseView new];
        [_cellView setCornerRadius:14];
        _cellView.backgroundColor = HEXCOLOR(@"#FFFFFF");
        [_cellView makeShadowWithColor:[HEXCOLOR(@"#595959") colorWithAlphaComponent:0.09] opacity:8 radius:2 offset:CGSizeMake(0, 0)];
        
        ImgViewWithName(iconImg, @"");
        self.iconImg = iconImg;
        [iconImg setCornerRadius:4];
        [_cellView addSubview:iconImg];
        [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.top.equalTo(@21);
            make.width.equalTo(@30);
            make.height.equalTo(iconImg.mas_width).multipliedBy(1.0);
        }];
        
        [_cellView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImg.mas_right).offset(8);
            make.top.equalTo(@25);
            make.height.equalTo(@22);
        }];
        
        ImgViewWithName(line, @"line");
        [_cellView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.top.equalTo(@61);
            make.right.equalTo(@-16);
            make.height.equalTo(@1);
        }];
        
        [_cellView addSubview:self.infoView];
        [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(7);
            make.left.equalTo(@16);
            make.right.equalTo(@-16);
        }];
        
        [_cellView addSubview:self.loanAgreementButton];
        [self.loanAgreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.infoView.mas_bottom).offset(7);
            make.left.equalTo(@16);
            make.height.equalTo(@20);
            make.bottom.equalTo(@-12);
        }];
    }
    return _cellView;
}


- (AC_BaseButton *)applyBtn
{
    if (_applyBtn == nil) {
        _applyBtn = [AC_BaseButton TextBtnWithTitle:@"" titleColor:@"#FFFFFF" font:Semibold(12)];
        [_applyBtn setCornerRadius:17];
        _applyBtn.backgroundColor = MAIN_COLOR;
    }
    return _applyBtn;
}

- (AC_BaseButton *)loanAgreementButton
{
    if (_loanAgreementButton == nil) {
        _loanAgreementButton = [AC_BaseButton new];
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@""];
        NSRange titleRange = {0,[title length]};
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
        [_loanAgreementButton setAttributedTitle:title forState:UIControlStateNormal];
        [_loanAgreementButton setTitleColor:HEXCOLOR(@"#9471F3") forState:UIControlStateNormal];
        _loanAgreementButton.titleLabel.font = Semibold(14);
        [_loanAgreementButton addTarget:self action:@selector(loanAgreementButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loanAgreementButton;
}

- (UIStackView *)infoView
{
    if (_infoView == nil) {
        _infoView = [UIStackView new];
        _infoView.spacing = 6;
        _infoView.distribution = UIStackViewDistributionEqualSpacing;
        _infoView.axis = UILayoutConstraintAxisVertical;
    }
    return _infoView;
}

- (CustomGradientLabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [CustomGradientLabel LabelWithFont:HouDiHei(16) TextColor:@"#333333" Text:@""];
    }
    return _nameLabel;
}

@end
