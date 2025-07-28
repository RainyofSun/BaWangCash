//
//  UILabel+ACAutoCode.m
//  ACAutoCode
//
//  Created by Acery on 2024/10/15.
//

#import "UILabel+ACAutoCode.h"

@implementation UILabel (ACAutoCode)

+ (instancetype)LabelWithFont:(UIFont *)font
                    TextColor:(NSString *)colorString
                         Text:(NSString *)text
{
    __kindof UILabel *label = [self new];
    
    label.font = font;
    label.textColor = HEXCOLOR(colorString);
    label.text = text;
    
    return label;
}

@end
