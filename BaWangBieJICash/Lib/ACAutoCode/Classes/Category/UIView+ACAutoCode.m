//
//  UIView+ACAutoCode.m
//  ACAutoCode
//
//  Created by Acery on 2024/10/15.
//

#import "UIView+ACAutoCode.h"
#import "UIView+ACAutoCodePrivate.h"

@implementation UIView (ACAutoCode)

+ (void)load
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
      [AC_RunTimeTool ExChangeMethodWithClass:UIView.class OriginalSelector:@selector(layoutSubviews) SwizzledSelector:@selector(AC_layoutSubviews)];
  });
}

- (void)AC_layoutSubviews
{
    [self AC_layoutSubviews];
    if (!self.needPartCorner) return;
    [self makeCornerRadius:self.partCornerRadius rectCorner:self.partCornerType];
}

#pragma mark - Rect Corner

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius rectCorner:(UIRectCorner)rectCorner
{
    self.partCornerRadius = cornerRadius;
    self.partCornerType = rectCorner;
    self.needPartCorner = true;
    
    [self layoutIfNeeded];
}

#pragma mark - Gest

- (UITapGestureRecognizer *)addTarget:(id)target action:(SEL)action
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
    return tap;
}

#pragma mark - Shadow

- (void)makeShadowWithColor:(UIColor *)color
                    opacity:(CGFloat)opacity
                     radius:(CGFloat)radius
                     offset:(CGSize)offset
{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = offset;
}

@end
