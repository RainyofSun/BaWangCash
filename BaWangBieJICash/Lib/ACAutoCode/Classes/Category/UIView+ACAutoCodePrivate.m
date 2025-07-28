//
//  UIView+ACAutoCodePrivate.m
//  ACAutoCode
//
//  Created by Acery on 2024/10/20.
//

#import "UIView+ACAutoCodePrivate.h"

static NSString *PartCorner_Radius_Key          = @"PartCorner_Radius_Key";
static NSString *PartCorner_CornerType_Key      = @"PartCorner_CornerType_Key";
static NSString *PartCorner_NeedCorner_Key      = @"PartCorner_NeedCorner_Key";

@implementation UIView (ACAutoCodePrivate)

- (void)makeCornerRadius:(CGFloat)cornerRadius rectCorner:(UIRectCorner)rectCorner
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)setPartCornerRadius:(CGFloat)partCornerRadius
{
    objc_setAssociatedObject(self, &PartCorner_Radius_Key, @(partCornerRadius), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)partCornerRadius
{
    return ((NSNumber *)objc_getAssociatedObject(self, &PartCorner_Radius_Key)).doubleValue;
}

- (void)setPartCornerType:(UIRectCorner)partCornerType
{
    objc_setAssociatedObject(self, &PartCorner_CornerType_Key, @(partCornerType), OBJC_ASSOCIATION_ASSIGN);
}

- (UIRectCorner)partCornerType
{
    return ((NSNumber *)objc_getAssociatedObject(self, &PartCorner_CornerType_Key)).integerValue;
}

- (void)setNeedPartCorner:(bool)needPartCorner
{
    objc_setAssociatedObject(self, &PartCorner_NeedCorner_Key, @(needPartCorner), OBJC_ASSOCIATION_ASSIGN);
}

- (bool)needPartCorner
{
    return ((NSNumber *)objc_getAssociatedObject(self, &PartCorner_NeedCorner_Key)).boolValue;
}

@end
