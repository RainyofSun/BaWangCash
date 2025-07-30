//
//  BaseCameraRetView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "BaseCameraRetView.h"

@interface BaseCameraRetView ()

@property (nonatomic , strong) UIImageView *retImageView;

@property (nonatomic , strong) AC_BaseView *toolView;

@property (nonatomic , strong) UIButton *retakeBtn;

@property (nonatomic , strong) UIButton *useBtn;

@end

@implementation BaseCameraRetView

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self addSubview:self.retImageView];
    [self.retImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self addSubview:self.toolView];
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

- (void)setRetImg:(UIImage *)retImg
{
    _retImg = retImg;
    
    self.retImageView.image = retImg;
}

#pragma mark - Event

- (void)retakeCall
{
    [self removeFromSuperview];
}

- (void)usePhoto
{
    if (self.needUseThisImgBlock) self.needUseThisImgBlock(self.retImg);
}

#pragma mark - Inti

- (UIImageView *)retImageView
{
    if (_retImageView == nil) {
        _retImageView = [UIImageView new];
        _retImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _retImageView;
}

- (AC_BaseView *)toolView
{
    if (_toolView == nil) {
        _toolView = [AC_BaseView new];
        _toolView.backgroundColor = UIColor.blackColor;
        
        [_toolView addSubview:self.retakeBtn];
        [self.retakeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.left.equalTo(@20);
            make.height.equalTo(@30);
            make.bottom.equalTo(@(kBottomHeight*-1));
        }];
        
        [_toolView addSubview:self.useBtn];
        [self.useBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-20);
            make.height.equalTo(@30);
            make.bottom.equalTo(@(kBottomHeight*-1));
        }];
    }
    return _toolView;
}

- (UIButton *)retakeBtn
{
    if (_retakeBtn == nil) {
        _retakeBtn = [UIButton TextBtnWithTitle:@"Retake" titleColor:@"#FFFFFF" font:Bold(20)];
        [_retakeBtn addTarget:self action:@selector(retakeCall) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retakeBtn;
}

- (UIButton *)useBtn
{
    if (_useBtn == nil) {
        _useBtn = [UIButton TextBtnWithTitle:@"Use Photo" titleColor:@"#FFFFFF" font:Bold(20)];
        [_useBtn addTarget:self action:@selector(usePhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return _useBtn;
}

@end
