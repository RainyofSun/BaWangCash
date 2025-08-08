//
//  HomeProductView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/8/7.
//

#import "HomeProductView.h"
#import "CustomGradientLabel.h"

@interface HomeProductView ()

@property (nonatomic, strong) UIImageView *logoImgView;
@property (nonatomic, strong) CustomGradientLabel *titleLab;

@end

@implementation HomeProductView

- (instancetype)initWithFrame:(CGRect)frame iconSize:(CGSize)size {
    self = [super initWithFrame:frame];
    if (self) {
        self.logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"identity_logo"]];
        self.titleLab = [[CustomGradientLabel alloc] initWithFrame:CGRectZero];
        
        [self addSubview:self.logoImgView];
        [self addSubview:self.titleLab];
        
        [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(self);
            make.size.mas_equalTo(size);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self.logoImgView.mas_right).offset(8);
            make.right.mas_equalTo(self).offset(8);
        }];
    }
    
    return self;
}

- (void)refreshProductTitle:(NSString *)title titleSize:(CGFloat)size {
    self.titleLab.text = title;
    self.titleLab.font = HouDiHei(size);
    [self.titleLab layoutIfNeeded];
}

@end
