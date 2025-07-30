//
//  UpCardPersentView.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "BaseMsgComfirmView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PC_UpIdCardDidDismissBlock)(void);

@interface UpCardPersentView : BaseMsgComfirmView

@property (nonatomic, copy) PC_UpIdCardDidDismissBlock disMissBlock;

@end

NS_ASSUME_NONNULL_END
