//
//  CustomGradientLabel.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/8/7.
//

#import "CustomGradientLabel.h"

@interface CustomGradientLabel ()

@property (nonatomic, strong) CAGradientLayer *clayer;

@end

@implementation CustomGradientLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.clayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
//                                 (__bridge id)[UIColor orangeColor].CGColor,
//                                 (__bridge id)[UIColor purpleColor].CGColor];
//        self.clayer.startPoint = CGPointMake(0, 0.5);
//        self.clayer.endPoint = CGPointMake(1, 0.5);
//        [self.layer insertSublayer:self.clayer atIndex:0];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    if (CGRectEqualToRect(self.bounds, CGRectZero)) {
//        return;
//    }
//    
//    self.clayer.frame = self.bounds;
//}
//
//- (CAGradientLayer *)clayer {
//    if (!_clayer) {
//        _clayer = [CAGradientLayer layer];
//    }
//    
//    return _clayer;
//}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 获取文字mask
    [self.text drawInRect:self.bounds withAttributes:@{NSFontAttributeName : self.font}];
    CGImageRef textMask = CGBitmapContextCreateImage(context);
    
    // 清空画布
    CGContextClearRect(context, rect);
    
    // 设置蒙层
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, rect, textMask);
    /*
     (CGFloat[8]) colors = ([0] = 0.67450980392156867, [1] = 0.34901960784313724, [2] = 1, [3] = 1, [4] = 0.63529411764705879, [5] = 0.56862745098039214, [6] = 1, [7] = 1)
     */
    // 绘制渐变
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0, 1};
//    CGFloat colors[] = {172/255.0, 89/255.0, 1.0, 1.0,
//                        162/255.0, 145/255.0, 1.0, 1.0};
//    CGGradientRef gradient=CGGradientCreateWithColorComponents(colorSpace, colors, locations, 3);
    NSArray *colors = @[(__bridge id)[UIColor colorWithHexString:@"#AC59FF"].CGColor,
                        (__bridge id)[UIColor colorWithHexString:@"#A291FF"].CGColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    CGPoint start = CGPointMake(self.bounds.size.width / 2.0, 0);
    CGPoint end = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height);
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation);
    
    // 释放
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    CGImageRelease(textMask);
}

@end
