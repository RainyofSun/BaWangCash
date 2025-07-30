//
//  UIView+FirstResponder.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "UIView+FirstResponder.h"

@implementation UIView (FirstResponder)

- (UIView *)getFristResponder
{
    if (self.isFirstResponder) return self;
    
    for (UIView *subView in self.subviews) {
        UIView *fristResponder = subView.getFristResponder;
        if (fristResponder != nil) return fristResponder;
    }
    return nil;
}

@end
