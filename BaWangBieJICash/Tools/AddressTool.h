//
//  AddressTool.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressTool : NSObject

@property (nonatomic ,strong ,readonly) AddressModel * addressModel;

+ (instancetype)tool;

- (void)updateAdressInfo;

- (NSString *)getAdressWithCode:(NSString *)code;

@end

NS_ASSUME_NONNULL_END
