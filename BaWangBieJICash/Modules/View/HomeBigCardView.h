//
//  HomeBigCardView.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/8/6.
//

#import <UIKit/UIKit.h>
#import "HomeApplyView.h"
#import "HomeProductView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeBigCardView : UIView

@property (nonatomic ,strong) HomeApplyView *topSubImg;
@property (nonatomic ,strong) UIImageView *phoneApplyView;
@property (nonatomic, strong) HomeProductView *productView;

@end

NS_ASSUME_NONNULL_END
