//
//  PickerCellModel.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PickerCellModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) __kindof NSObject *model;

@end

NS_ASSUME_NONNULL_END
