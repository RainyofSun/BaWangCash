//
//  AC_BaseView.m
//  ACAuotCode
//
//  Created by Acery on 2022/7/15.
//

#import "AC_BaseView.h"

@interface AC_BaseView ()

@property (nonatomic, assign) bool needPartCorner;
@property (nonatomic, assign) CGFloat partCornerRadius;
@property (nonatomic, assign) UIRectCorner partRectCorner;

@end

@implementation AC_BaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubView];
    }
    return self;
}

- (void)setUpSubView{}
- (void)dealloc{}

@end

#pragma mark - AC_BaseGradientView

@interface AC_BaseGradientView ()

/// gl
@property(nonatomic, strong) CAGradientLayer *gl;

@end

@implementation AC_BaseGradientView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CAGradientLayer *gl = [CAGradientLayer layer];
        [self.layer addSublayer:gl];
        self.gl = gl;
    }
    return self;
}

- (void)setColors:(NSArray *)colors
{
    _colors = colors;
    self.gl.colors = colors;
}

- (void)setLocations:(NSArray<NSNumber *> *)locations
{
    _locations = locations;
    self.gl.locations = locations;
}

- (void)setStartPoint:(CGPoint)startPoint
{
    _startPoint = startPoint;
    self.gl.startPoint = startPoint;
}

- (void)setEndPoint:(CGPoint)endPoint
{
    _endPoint = endPoint;
    self.gl.endPoint = endPoint;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    self.gl.frame = self.bounds;
    
    [CATransaction commit];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    self.gl.frame = self.bounds;
    
    [CATransaction commit];
}

@end

#pragma mark - AC_BaseGradientBorderView

@interface AC_BaseGradientBorderView ()

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation AC_BaseGradientBorderView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    self.maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rect.size.width, CGRectGetHeight(rect))
                                                byRoundingCorners:UIRectCornerAllCorners
                                                      cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)].CGPath;
    if (self.borderWidth == 0) {
        self.layer.mask = nil;
    }else{
        self.layer.mask = self.maskLayer;
    }
    [CATransaction commit];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    self.maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, CGRectGetHeight(self.bounds))
                                                byRoundingCorners:UIRectCornerAllCorners
                                                      cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)].CGPath;
    if (self.borderWidth == 0) {
        self.layer.mask = nil;
    }else{
        self.layer.mask = self.maskLayer;
    }

    [CATransaction commit];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.masksToBounds = true;
    [self setNeedsDisplay];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    self.maskLayer.lineWidth = self.borderWidth;
    [self setNeedsDisplay];
}

- (CAShapeLayer *)maskLayer
{
    if (_maskLayer == nil){
        _maskLayer = [[CAShapeLayer alloc] init];
        _maskLayer.fillColor = UIColor.clearColor.CGColor;
        _maskLayer.strokeColor = UIColor.redColor.CGColor;
    }
    return _maskLayer;
}

@end
