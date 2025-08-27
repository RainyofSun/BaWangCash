//
//  CustomTextFiled.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/8/6.
//

#import "CustomTextFiled.h"

@implementation CustomTextFiled

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super leftViewRectForBounds: bounds];
    rect.origin.x += 8;
    return rect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super rightViewRectForBounds: bounds];
    rect.origin.x -= 15;
    rect.origin.y = (self.size.height - 42) * 0.5;
    rect.size = CGSizeMake(80, 42);
    return rect;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    if (self.leftView != nil) {
        return CGRectInset(bounds, 40, 0);
    }
    
    return CGRectInset(bounds, 8, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    if (self.leftView != nil) {
        return CGRectInset(bounds, 40, 0);
    }
    
    if (self.rightView != nil) {
        CGRect rect = [super editingRectForBounds:bounds];
        return CGRectMake(8, rect.origin.y, rect.size.width - 8 - 8 - 50, rect.size.height);
    }
    
    return CGRectInset(bounds, 8, 0);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(paste:)) {
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}

@end
