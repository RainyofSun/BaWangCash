//
//  CertiTopView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/8/7.
//

#import "CertiTopView.h"

@interface CertiTopView ()

@property (nonatomic, strong) UILabel *tipLab;
@property (nonatomic, strong) UILabel *PriceLab;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UIImageView *dayView;
@property (nonatomic, strong) UILabel *dayLab;
@property (nonatomic, strong) UIImageView *rateView;
@property (nonatomic, strong) UILabel *rateLab;

@end

@implementation CertiTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.image = [UIImage imageNamed:@"identity_cardbg"];
        
        [self addSubview:self.tipLab];
        [self addSubview:self.PriceLab];
        [self addSubview:self.lineView];
        [self addSubview:self.dayView];
        [self addSubview:self.dayLab];
        [self addSubview:self.rateView];
        [self addSubview:self.rateLab];
        
        [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(52);
        }];
        
        [self.PriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.tipLab.mas_bottom).offset(10);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.PriceLab.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(1, 20));
        }];
        
        [self.dayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(30);
            make.centerY.mas_equalTo(self.lineView);
        }];
        
        [self.dayLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.dayView);
            make.left.mas_equalTo(self.dayView.mas_right).offset(12);
        }];
        
        [self.rateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-30);
            make.centerY.mas_equalTo(self.lineView);
        }];
        
        [self.rateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.rateLab.mas_left).offset(-12);
            make.centerY.mas_equalTo(self.lineView);
        }];
    }
    return self;
}

- (void)setDetailModel:(ProductDetailModel *)detailModel {
    _detailModel = detailModel;
    
    self.PriceLab.text = FORMAT(@"₱%ld", detailModel.pc_gore.pc_computer);
    
    self.rateLab.text = detailModel.pc_gore.pc_far.pc_zappa.pc_earliest;
    self.dayLab.text = FORMAT(@"%@/day", detailModel.pc_gore.pc_far.pc_expressed.pc_earliest);
    
    self.tipLab.text = detailModel.pc_gore.pc_thing;
}

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLab.textColor = [UIColor whiteColor];
        _tipLab.font = Regular(14);
    }
    
    return _tipLab;
}

- (UILabel *)PriceLab {
    if (!_PriceLab) {
        _PriceLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _PriceLab.textColor = [UIColor whiteColor];
        _PriceLab.font = ShuHeiTi(56);
    }
    
    return _PriceLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    
    return _lineView;
}

- (UIImageView *)dayView {
    if (!_dayView) {
        _dayView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rate_icon"]];
    }
    
    return _dayView;
}

- (UILabel *)dayLab {
    if (!_dayLab) {
        _dayLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _dayLab.textColor = [UIColor whiteColor];
        _dayLab.font = Regular(15);
    }
    
    return _dayLab;
}

- (UIImageView *)rateView {
    if (!_rateView) {
        _rateView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"term_icon"]];
    }
    
    return _rateView;
}

- (UILabel *)rateLab {
    if (!_rateLab) {
        _rateLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _rateLab.textColor = [UIColor whiteColor];
        _rateLab.font = Regular(15);
    }
    
    return _rateLab;
}
@end
