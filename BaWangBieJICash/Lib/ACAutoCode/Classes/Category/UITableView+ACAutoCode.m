//
//  UITableView+ACAutoCode.m
//  ACAutoCode
//
//  Created by Acery on 2024/10/20.
//

#import "UITableView+ACAutoCode.h"
#import "UIView+ACAutoCodePrivate.h"

@implementation UITableView (ACAutoCode)

+ (void)load
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
      [AC_RunTimeTool ExChangeMethodWithClass:self.class OriginalSelector:@selector(layoutSubviews) SwizzledSelector:@selector(AC_TABVIew_layoutSubviews)];
  });
}

- (void)AC_TABVIew_layoutSubviews
{
    [self AC_TABVIew_layoutSubviews];
    if (!self.needPartCorner) return;
    [self makeCornerRadius:self.partCornerRadius rectCorner:self.partCornerType];
}

@end
