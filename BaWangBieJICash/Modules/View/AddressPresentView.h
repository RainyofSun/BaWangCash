//
//  AddressPresentView.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "BasePresentView.h"
#import "AddressModel.h"

NS_ASSUME_NONNULL_BEGIN

///回调 省|市|区
typedef void(^PC_AddressPresentViewDidSelectFinish)(NSString *adressCode, NSString *cityName);

@interface AddressPresentView : BasePresentView

@property (nonatomic, copy) PC_AddressPresentViewDidSelectFinish didSelectFinish;

@end

NS_ASSUME_NONNULL_END
