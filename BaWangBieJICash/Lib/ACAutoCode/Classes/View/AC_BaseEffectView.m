//
//  AC_BaseEffectView.m
//  ACAuotCode
//
//  Created by Acery on 2022/10/28.
//

#import "AC_BaseEffectView.h"

@interface AC_BaseEffectView ()

@property (nonatomic, strong) UIVisualEffect *theEffect;

/// 模糊的动画
@property (nonatomic, strong) UIViewPropertyAnimator *animator;


@end

@implementation AC_BaseEffectView

- (instancetype)initWithEffect:(UIVisualEffect *)effect intensity:(CGFloat)intensity
{
    self = [super initWithEffect:nil];
    if (self) {
        self.theEffect = effect;
        self.customIntensity = intensity;
        [self setUpSubView];
    }
    return self;
}

+ (instancetype)defaultEffectView
{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemThinMaterialDark];
    AC_BaseEffectView *effectView = [[self alloc]initWithEffect:blurEffect intensity:0.7];
    return effectView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubView];
    }
    return self;
}

- (void)setUpSubView
{
    
}

// 使用动画映射到模糊度
// 这个映射不是线性的
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.effect = nil;
    if (self.animator) {
        [self.animator stopAnimation:YES];
    }
    self.animator = [[UIViewPropertyAnimator alloc] initWithDuration:1 curve:UIViewAnimationCurveLinear animations:^{
        self.effect = self.theEffect;
    }];
    self.animator.fractionComplete = self.customIntensity;
}

- (void)setCustomIntensity:(CGFloat)customIntensity
{
    _customIntensity = customIntensity;
    
}

- (void)dealloc
{
    [self.animator stopAnimation:YES];
}

@end
