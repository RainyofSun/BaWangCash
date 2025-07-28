//
//  AC_BaseButton.m
//  ACAuotCode
//
//  Created by Acery on 2022/7/15.
//

#import "AC_BaseButton.h"

@implementation AC_BaseButton

- (void)setHighlighted:(BOOL)highlighted{}

- (void)setBackgroundWebImage:(NSString *)imageURL forState:(UIControlState)state
{
    [self getImgWithURL:imageURL SuccessBlock:^(UIImage * _Nullable image) {
        [self setBackgroundImage:image forState:state];
    }];
}

- (void)setWebImage:(NSString *)imageURL forState:(UIControlState)state
{
    [self getImgWithURL:imageURL SuccessBlock:^(UIImage * _Nullable image) {
        [self setImage:image forState:state];
    }];
}

- (void)getImgWithURL:(NSString *)urlStr SuccessBlock:(void(^)(UIImage * _Nullable image))successBlock
{
    [SDWebImageManager.sharedManager loadImageWithURL:[NSURL URLWithString:urlStr] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (image != nil && successBlock != nil) {
            successBlock(image);
        }
    }];
}

@end

@interface AC_BaseGradientButton ()

/// gl
@property(nonatomic, strong) CAGradientLayer *gl;

@end

@implementation AC_BaseGradientButton

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
    self.gl.frame = self.bounds;
}

@end

@implementation AC_LayoutButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imgWidth = self.imageView.frame.size.width;
    CGFloat titleHeigh = self.titleLabel.frame.size.height;
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.imageView.frame = CGRectMake((width - imgWidth)*0.5, 0, imgWidth, imgWidth);
    self.titleLabel.frame = CGRectMake((width - 100)*0.5, height - titleHeigh, 100, titleHeigh);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
