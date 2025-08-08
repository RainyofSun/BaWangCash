//
//  HomeApplyButton.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/8/6.
//

#import "HomeApplyButton.h"

@interface HomeApplyButton ()

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *rightImgView;

@end

@implementation HomeApplyButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"home_apply_btn"];
        self.userInteractionEnabled = YES;
        
        self.leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_gold"]];
        self.rightImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apply_btn_arrow"]];
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLab.font = ShuHeiTi(18);
        self.titleLab.text = @"Apply Now";
        
        [self addSubview:self.leftImageView];
        [self addSubview:self.titleLab];
        [self addSubview:self.rightImgView];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
        
        [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self.titleLab.mas_left).offset(-15);
        }];
        
        [self.rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self.titleLab.mas_right).offset(15);
        }];
    }
    return self;
}

- (void)refreshApplyButtonTitle:(NSString *)title {
    self.titleLab.text = title;
}

@end
