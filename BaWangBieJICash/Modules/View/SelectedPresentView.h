//
//  SelectedPresentView.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "BasePresentView.h"
#import "PickerCellModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PC_SelectPresent_DidSelectRow)(PickerCellModel *rowModel);

@interface SelectedPresentView : BasePresentView

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) NSArray <PickerCellModel *> *models;

@property (nonatomic, copy) PC_SelectPresent_DidSelectRow didSelctRowBlock;

@end

NS_ASSUME_NONNULL_END
