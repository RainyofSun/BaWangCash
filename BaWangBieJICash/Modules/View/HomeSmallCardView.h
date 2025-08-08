//
//  HomeSmallCardView.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/8/6.
//

#import <UIKit/UIKit.h>
#import "HomeApplyView.h"
#import "HomePageSmallView.h"
#import "HomeProductView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeSmallCardView : UIView

@property (nonatomic, strong) HomeProductView *productView;
@property (nonatomic, strong) HomeApplyView *applyView;
@property (nonatomic, strong) HomePageSmallView *smallView;

@end

NS_ASSUME_NONNULL_END
