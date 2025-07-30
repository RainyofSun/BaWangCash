//
//  LogoutPresentView.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "BaseMsgComfirmView.h"

NS_ASSUME_NONNULL_BEGIN

@class LogoutPresentView;
typedef void(^PC_ComfireBlock)(LogoutPresentView *logoff);

@interface LogoutPresentView : BaseMsgComfirmView

@property (nonatomic, assign) bool isAgree;
@property (nonatomic, copy) PC_ComfireBlock disMissBlock;

@end

NS_ASSUME_NONNULL_END
