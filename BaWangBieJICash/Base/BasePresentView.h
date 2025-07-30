//
//  BasePresentView.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "AC_BasePresentView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PresentViewDidDismissBlock)(void);

@interface BasePresentView : AC_BasePresentView

@property (nonatomic , copy) PresentViewDidDismissBlock didDismissBlock;

- (void)addKeyboardAutoOffset;

@end

NS_ASSUME_NONNULL_END
