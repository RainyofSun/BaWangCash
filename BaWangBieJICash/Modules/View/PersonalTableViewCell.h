//
//  PersonalTableViewCell.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "AC_BaseTableCell.h"
#import "PersonalInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalTableViewCell : AC_BaseTableCell

@property (nonatomic ,strong) PC_UserInfoModel_Counterclockwise *userModel;

@end

NS_ASSUME_NONNULL_END
