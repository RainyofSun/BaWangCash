//
//  AuthSelectedPresentView.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "BaseMsgComfirmView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PC_AuthSelectDidDismissBlock)(NSString *selectType);

@interface AuthSelectedPresentView : BaseMsgComfirmView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) PC_AuthSelectDidDismissBlock disMissBlock;

@end

NS_ASSUME_NONNULL_END
