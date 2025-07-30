//
//  InfoPresentView.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "BasePresentView.h"
#import "IDCardModel.h"

NS_ASSUME_NONNULL_BEGIN

@class InfoPresentView;
typedef void(^PC_InfoDismissBlock)(NSString *name,NSString *birth,NSString *number,InfoPresentView *infoView);

@interface InfoPresentView : BasePresentView

@property (nonatomic, strong) IDCardModel *model;
@property (nonatomic, copy) PC_InfoDismissBlock nextSaveBlock;

@end

NS_ASSUME_NONNULL_END
