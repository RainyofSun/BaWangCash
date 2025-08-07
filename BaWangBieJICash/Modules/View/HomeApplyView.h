//
//  HomeApplyView.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/8/6.
//

#import <UIKit/UIKit.h>
#import "HomeApplyButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeApplyView : UIImageView

@property (nonatomic, strong) UILabel *LoanLab;
@property (nonatomic ,strong) UILabel *termLab;
@property (nonatomic ,strong) UILabel *rateLab;
@property (nonatomic ,strong) HomeApplyButton *applyBtn;
@property (nonatomic ,strong) UILabel *priceLab;

@end

NS_ASSUME_NONNULL_END
