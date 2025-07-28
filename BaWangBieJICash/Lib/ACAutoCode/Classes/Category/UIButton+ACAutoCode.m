//
//  UIButton+ACAutoCode.m
//  ACAutoCode
//
//  Created by Acery on 2024/10/16.
//

#import "UIButton+ACAutoCode.h"
#import "UIView+ACAutoCodePrivate.h"

@implementation UIButton (ACAutoCode)

+ (instancetype)ImageBtnWithImgName:(NSString *)img_name
{
    __kindof UIButton *btn = [self new];
    [btn setImage:IMAGE(img_name) forState:UIControlStateNormal];
    return btn;
}

+ (instancetype)TextBtnWithTitle:(NSString *)title titleColor:(NSString *)titleColor font:(UIFont *)font
{
    __kindof UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:titleColor] forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}

#pragma mark - Rect Corner

+ (void)load
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
      [AC_RunTimeTool ExChangeMethodWithClass:self.class OriginalSelector:@selector(layoutSubviews) SwizzledSelector:@selector(AC_BTN_layoutSubviews)];
  });
}

- (void)AC_BTN_layoutSubviews
{
    [self AC_BTN_layoutSubviews];
    if (!self.needPartCorner) return;
    [self makeCornerRadius:self.partCornerRadius rectCorner:self.partCornerType];
}

@end
