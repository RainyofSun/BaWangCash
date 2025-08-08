//
//  HomeSmallApplyButton.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/8/7.
//

#import "HomeSmallApplyButton.h"

@interface HomeSmallApplyButton ()

@property (nonatomic, strong) UIImageView *arrowImgView;

@end

@implementation HomeSmallApplyButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MAIN_COLOR;
        self.layer.cornerRadius = 18;
        self.clipsToBounds = YES;
        
        self.arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"small_cell_arrow"]];
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLab.font = ShuHeiTi(14);
        self.titleLab.textColor = [UIColor whiteColor];
        
        [self addSubview:self.titleLab];
        [self addSubview:self.arrowImgView];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(20);
            make.centerY.mas_equalTo(self.arrowImgView);
            make.width.mas_greaterThanOrEqualTo(20);
        }];
        
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab.mas_right).offset(8);
            make.top.mas_equalTo(self).offset(8);
            make.bottom.mas_equalTo(self).offset(-8);
            make.right.mas_equalTo(self).offset(-15);
        }];
    }
    return self;
}

@end
