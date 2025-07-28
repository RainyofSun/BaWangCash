//
//  SwitchNetModel.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwitchNetModel : NSObject

@property (nonatomic, copy) NSString * pc;

+ (instancetype)ModelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
