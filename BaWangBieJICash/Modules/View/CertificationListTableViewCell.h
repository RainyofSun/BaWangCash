//
//  CertificationListTableViewCell.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "AC_BaseTableCell.h"
#import "ProductDetailModel.h"
#import "AddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CertificationListTableViewCell : AC_BaseTableCell

@property (nonatomic, strong) PC_ProduceDetailModel_Rec *dislayModel;
@property (nonatomic ,strong) AddressModel *addressModel;

@property (nonatomic ,assign) NSInteger productID;

@end

NS_ASSUME_NONNULL_END
