//
//  HomeSmallCardView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/8/6.
//

#import "HomeSmallCardView.h"

@interface HomeSmallCardView ()

@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIImageView *goldImgView;

@end

@implementation HomeSmallCardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgImgView];
        [self.bgImgView addSubview:self.productView];
        [self.bgImgView addSubview:self.applyView];
        [self.bgImgView addSubview:self.goldImgView];
        [self addSubview:self.smallView];
        
        [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
        }];
        
        [self.productView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(kStatusBarHeight + 15);
        }];
        
        [self.applyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.right.mas_equalTo(self).offset(-16);
            make.height.mas_equalTo((kScreenWidth - 32) * 0.6);
            make.top.mas_equalTo(self.productView.mas_bottom).offset(15);
        }];
        
        [self.goldImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.applyView.mas_top).offset(-10);
            make.right.mas_equalTo(self.applyView.mas_right).offset(8);
        }];
        
        [self.smallView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.applyView.mas_bottom).offset(20);
            make.left.right.bottom.mas_equalTo(self);
        }];
    }
    return self;
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_small_top"]];
        _bgImgView.userInteractionEnabled = YES;
    }
    
    return _bgImgView;
}

- (UIImageView *)goldImgView {
    if (!_goldImgView) {
        _goldImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_small_gold"]];
    }
    
    return _goldImgView;
}

- (HomeProductView *)productView {
    if (!_productView) {
        _productView = [[HomeProductView alloc] initWithFrame:CGRectZero iconSize:CGSizeMake(35, 35)];
    }
    
    return _productView;
}

- (HomeApplyView *)applyView {
    if (!_applyView) {
        _applyView = [[HomeApplyView alloc] initWithFrame:CGRectZero];
    }
    
    return _applyView;
}

- (HomePageSmallView *)smallView {
    if (!_smallView) {
        _smallView = [[HomePageSmallView alloc] initWithFrame:CGRectZero];
    }
    
    return _smallView;
}

@end
