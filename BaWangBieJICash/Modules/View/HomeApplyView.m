//
//  HomeApplyView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/8/6.
//

#import "HomeApplyView.h"

@interface HomeApplyView ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic ,strong) UIImageView *loantermLab;
@property (nonatomic ,strong) UIImageView *interLab;

@end

@implementation HomeApplyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.image = [UIImage imageNamed:@"cardbg"];
        self.userInteractionEnabled = YES;
        
        self.LoanLab = [UILabel LabelWithFont:Regular(14) TextColor:@"#FFFFFF" Text:@""];
        [self addSubview:self.LoanLab];
        
        [self.LoanLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(8);
            make.left.equalTo(@10);
            make.height.equalTo(@22);
        }];
        
        [self addSubview:self.priceLab];
        [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.LoanLab.mas_bottom).offset(15);
            make.centerX.equalTo(@0);
            make.height.equalTo(@40);
        }];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectZero];
        self.lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.lineView];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(1, 10));
        }];
        
        self.loantermLab = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"rate_icon"]];
        [self addSubview:self.loantermLab];
        
        self.interLab = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"term_icon"]];
        [self addSubview:self.interLab];
        
        [self addSubview:self.termLab];
        [self addSubview:self.rateLab];
        
        [self.rateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.lineView.mas_left).offset(-20);
            make.centerY.equalTo(self.lineView);
        }];
        
        [self.loantermLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rateLab.mas_left).offset(-10);
            make.centerY.equalTo(self.lineView);
        }];
        
        [self addSubview:self.rateLab];
        [self.interLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView.mas_left).offset(20);
            make.centerY.equalTo(self.lineView);
        }];
        
        [self.termLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.interLab.mas_right).offset(10);
            make.centerY.equalTo(self.lineView);
        }];
        
        [self addSubview:self.applyBtn];
        [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineView.mas_bottom).offset(30);
            make.centerX.equalTo(self.lineView);
            make.height.equalTo(@50);
        }];
    }
    return self;
}

- (UILabel *)priceLab
{
    if (_priceLab == nil) {
        _priceLab = [UILabel LabelWithFont:ShuHeiTi(48) TextColor:@"#FFFFFF" Text:@""];
    }
    return _priceLab;
}

- (UILabel *)termLab
{
    if (_termLab == nil) {
        _termLab = [UILabel LabelWithFont:Semibold(16) TextColor:@"#FFFFFF" Text:@""];
    }
    return _termLab;
}

- (UILabel *)rateLab
{
    if (_rateLab == nil) {
        _rateLab = [UILabel LabelWithFont:Semibold(16) TextColor:@"#FFFFFF" Text:@""];
    }
    return _rateLab;
}

- (HomeApplyButton *)applyBtn
{
    if (_applyBtn == nil) {
        _applyBtn = [[HomeApplyButton alloc] initWithFrame:CGRectZero];;
    }
    return _applyBtn;
}

@end
