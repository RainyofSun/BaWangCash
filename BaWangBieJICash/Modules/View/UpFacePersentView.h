//
//  UpFacePersentView.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "BaseMsgComfirmView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PC_UpFaceDismissBlock)(void);

@interface UpFacePersentView : BaseMsgComfirmView

@property (nonatomic, copy) PC_UpFaceDismissBlock disMissBlock;

@end

NS_ASSUME_NONNULL_END
