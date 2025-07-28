//
//  UIFont+ACAutoCode.m
//  ACAutoCode
//
//  Created by Acery on 2024/10/15.
//

#import "UIFont+ACAutoCode.h"

@implementation UIFont (ACAutoCode)

+ (UIFont *)UltraLight_size:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightUltraLight];
}

+ (UIFont *)Thin_size:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightThin];
}

+ (UIFont *)Light_size:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightLight];
}

+ (UIFont *)Regular_size:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightRegular];
}

+ (UIFont *)Medium_size:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightMedium];
}

+ (UIFont *)Semibold_size:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightSemibold];
}

+ (UIFont *)Bold_size:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightBold];
}

+ (UIFont *)Heavy_size:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightHeavy];
}

+ (UIFont *)Black_size:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightBlack];
}

@end
