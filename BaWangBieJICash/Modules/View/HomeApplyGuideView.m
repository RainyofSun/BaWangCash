//
//  HomeApplyGuideView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/8/6.
//

#import "HomeApplyGuideView.h"

@interface HomeApplyGuideView ()

@property (nonatomic, strong) UIScrollView *hScrollView;
@property (nonatomic, strong) NSArray <NSString *>* sources;

@end

@implementation HomeApplyGuideView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"home_h_bg"];
        self.userInteractionEnabled = YES;
        
        self.sources = @[@"home_cell_1", @"home_cell_2", @"home_cell_3"];
        
        self.hScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        self.hScrollView.showsHorizontalScrollIndicator = NO;
        CGSize imgSize = CGSizeMake(112, 158);
        
        self.hScrollView.contentSize = CGSizeMake((imgSize.width + 8) * self.sources.count + 8, 10);
        self.hScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.hScrollView];
        
        if (self.hScrollView.contentSize.width < kScreenWidth - 32) {
            [self.hScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self).offset((kScreenWidth - 32 - self.hScrollView.contentSize.width) * 0.5);
                make.width.mas_equalTo(self.hScrollView.contentSize.width);
                make.top.mas_equalTo(self).offset(50);
                make.bottom.mas_equalTo(self).offset(-20);
            }];
        } else {
            [self.hScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self);
                make.top.mas_equalTo(self).offset(50);
                make.bottom.mas_equalTo(self).offset(-20);
            }];
        }
        
        __block UIImageView *_tempImageView = nil;
        
        [self.sources enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:obj]];
            [self.hScrollView addSubview:imageView];
        
            if (_tempImageView != nil) {
                if (idx == self.sources.count - 1) {
                    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.size.centerY.mas_equalTo(_tempImageView);
                        make.left.mas_equalTo(_tempImageView.mas_right).offset(8);
                        make.right.mas_equalTo(self.hScrollView).offset(-8);
                    }];
                } else {
                    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.size.centerY.mas_equalTo(_tempImageView);
                        make.left.mas_equalTo(_tempImageView.mas_right).offset(8);
                    }];
                }
            } else {
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.hScrollView);
                    make.left.mas_equalTo(self.hScrollView).offset(8);
                    make.size.mas_equalTo(imgSize);
                }];
            }

            _tempImageView = imageView;
        }];
    }
    return self;
}

@end
