//
//  DateOfBirthdayConfirmView.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "BaseMsgComfirmView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PC_DateSelect_DidSelectRow)(NSString *selectText);

@interface DateOfBirthdayConfirmView : BaseMsgComfirmView

@property (nonatomic, copy) PC_DateSelect_DidSelectRow didSelctRowBlock;

@end

NS_ASSUME_NONNULL_END
