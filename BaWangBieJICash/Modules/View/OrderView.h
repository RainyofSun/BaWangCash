//
//  OrderView.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/30.
//

#import "AC_BaseView.h"
#import "OrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderView : AC_BaseView

@property (nonatomic, copy) NSString *orderStatusType;

- (void)refreshData;

@end

NS_ASSUME_NONNULL_END
