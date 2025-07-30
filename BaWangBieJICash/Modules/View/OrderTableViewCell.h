//
//  OrderTableViewCell.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/30.
//

#import "AC_BaseTableCell.h"
#import "OrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderTableViewCell : AC_BaseTableCell

@property (nonatomic, strong) PC_OrderListModel_Inserting *orderModel;

@end

NS_ASSUME_NONNULL_END
