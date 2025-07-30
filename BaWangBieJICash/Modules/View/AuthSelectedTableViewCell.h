//
//  AuthSelectedTableViewCell.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "AC_BaseTableCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface AuthSelectedTableViewCell : AC_BaseTableCell

@property (nonatomic ,strong) UILabel *title;
@property (nonatomic, assign) BOOL isSelectedState;

@end

NS_ASSUME_NONNULL_END
