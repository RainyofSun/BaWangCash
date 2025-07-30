//
//  BasePickerView.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "BasePresentView.h"
#import "PickerCellModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PC_PickerView_DidSelectRow)(PickerCellModel *rowModel);

@interface BasePickerView : BasePresentView

@property (nonatomic, strong) NSArray <PickerCellModel *> *models;

@property (nonatomic, copy) PC_PickerView_DidSelectRow didSelctRowBlock;

@end

NS_ASSUME_NONNULL_END
