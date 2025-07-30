//
//  ContactTableViewCell.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "AC_BaseTableCell.h"
#import "ContactModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ContactTableViewCell;
typedef void(^PC_ContactCell_DidEditBlock)(ContactTableViewCell *cell);

@interface ContactTableViewCell : AC_BaseTableCell

@property (nonatomic ,strong) PC_ContactModel_Understand *conModel;
@property (nonatomic, copy) PC_ContactCell_DidEditBlock didEditBlock;

@end

NS_ASSUME_NONNULL_END
