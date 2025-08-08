//
//  HomeProductView.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/8/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeProductView : UIView

- (instancetype)initWithFrame:(CGRect)frame iconSize:(CGSize)size;

- (void)refreshProductTitle:(NSString *)title titleSize:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
