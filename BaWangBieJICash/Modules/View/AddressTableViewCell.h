//
//  AddressTableViewCell.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "AC_BaseTableCell.h"
#import "AddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressTableViewCell : AC_BaseTableCell

@property (nonatomic ,strong) UILabel *addressTitle;
@property (nonatomic ,strong) AC_BaseButton *selectBtn;

@property (nonatomic ,strong) PC_AdressModel_Inserting * addressModel;

@end

NS_ASSUME_NONNULL_END
