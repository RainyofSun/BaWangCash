//
//  JobInfoTableViewCell.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "AC_BaseTableCell.h"
#import "JobInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobInfoTableViewCell : AC_BaseTableCell

@property (nonatomic ,strong) PC_JobInfoModel_Counterclockwise *jobModel;

@end

NS_ASSUME_NONNULL_END
