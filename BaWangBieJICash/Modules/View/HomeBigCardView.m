//
//  HomeBigCardView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/8/6.
//

#import "HomeBigCardView.h"
#import "HomeApplyGuideView.h"
#import "HomeProductView.h"

@interface HomeBigCardView ()

@property (nonatomic ,strong) UIImageView *topImg;
@property (nonatomic ,strong) HomeApplyGuideView *strengthView;

@end

@implementation HomeBigCardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.topImg];
        [self.topImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.right.equalTo(@0);
        }];
        
        self.topSubImg = [[HomeApplyView alloc] initWithFrame:CGRectZero];
        [self addSubview: self.topSubImg];
        
        [self.topSubImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topImg.mas_bottom).offset(-150);
            make.left.mas_equalTo(self).offset(16);
            make.right.mas_equalTo(self).offset(-16);
            make.height.mas_equalTo((kScreenWidth - 32) * 0.6);
        }];
        
        [self addSubview:self.strengthView];
        [self.strengthView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.right.equalTo(@-16);
            make.top.mas_equalTo(self.topSubImg.mas_bottom).offset(16);
        }];
        
        [self addSubview:self.phoneApplyView];
        [self.phoneApplyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.right.equalTo(@-16);
            make.top.equalTo(self.strengthView.mas_bottom).offset(12);
            make.height.equalTo(@101);
            make.bottom.mas_equalTo(self).offset(-10);
        }];
    }
    return self;
}

- (UIImageView *)topImg
{
    if (_topImg == nil) {
        _topImg = [[UIImageView alloc]initWithImage:IMAGE(@"home_top")];
        _topImg.userInteractionEnabled = YES;
        _topImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _topImg;
}


- (HomeApplyGuideView *)strengthView
{
    if (_strengthView == nil) {
        _strengthView = [[HomeApplyGuideView alloc] initWithFrame:CGRectZero];
    }
    return _strengthView;
}

- (UIImageView *)phoneApplyView
{
    if (_phoneApplyView == nil) {
        _phoneApplyView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bainzu"]];
    }
    return _phoneApplyView;
}

@end
