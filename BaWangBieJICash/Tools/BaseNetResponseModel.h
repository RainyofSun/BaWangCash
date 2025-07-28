//
//  BaseNetResponseModel.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseNetResponseModel : NSObject

@property (nonatomic, copy) NSString * pc_snob;

@property (nonatomic, copy) NSString * pc_flag;

@property (nonatomic, strong) __kindof NSObject * pc_portal;

@property (nonatomic , strong) NSDictionary *modelDict;

+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@property (nonatomic, assign) bool success;

@end

NS_ASSUME_NONNULL_END
