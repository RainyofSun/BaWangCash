//
//  LoginConfig.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import <Foundation/Foundation.h>

@class PC_LoginConfig_Commenting, PC_LoginConfig_Disney;

NS_ASSUME_NONNULL_BEGIN

@interface LoginConfig : NSObject

@property (nonatomic, assign) NSInteger  pc_allers;

@property (nonatomic, assign) NSInteger  pc_king;

@property (nonatomic, copy) NSString * pc_AAv7ndpIU;

@property (nonatomic, copy) NSString * pc_2LQW;

@property (nonatomic, strong) PC_LoginConfig_Commenting * pc_commenting;

@property (nonatomic, copy) NSString * pc_4oh8Hy0CgJ;

@property (nonatomic, copy) NSString * pc_zxText;

@property (nonatomic, strong) PC_LoginConfig_Disney * pc_disney;

@property (nonatomic, copy) NSString * pc_lion;

@property (nonatomic, copy) NSString * pc_rfMNjHB;

@property (nonatomic, assign) NSInteger  pc_70IbTwIJW9Q;

@property (nonatomic, copy) NSString * pc_5zvevtLeqEh;

@property (nonatomic, strong) NSNull * pc_BhgOa3YtW;

@property (nonatomic, copy) NSString * pc_16zdJdKkh;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_LoginConfig_Commenting : NSObject

@property (nonatomic, copy) NSString * pc_pumbaa;

@property (nonatomic, copy) NSString * pc_timon;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_LoginConfig_Disney : NSObject

@property (nonatomic, copy) NSString * pc_happy;

@property (nonatomic, copy) NSString * pc_virgin;

@property (nonatomic, copy) NSString * pc_yeared;

@property (nonatomic, copy) NSString * pc_poster;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
