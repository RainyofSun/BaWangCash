//
//  PersonalInfoModel.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PC_UserInfoModel_Counterclockwise;
@class PC_PersonInfoModel_Counterclockwise_Darkstar;

@interface PersonalInfoModel : NSObject

@property (nonatomic, copy) NSString * pc_TrtMc;

@property (nonatomic, copy) NSString * pc_fmHnv;

@property (nonatomic, strong) NSArray<PC_UserInfoModel_Counterclockwise *> *pc_counterclockwise;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_UserInfoModel_Counterclockwise : NSObject

@property (nonatomic, copy) NSString * pc_newsgroups;

@property (nonatomic, assign) NSInteger  pc_consumers;

@property (nonatomic, assign) NSInteger  pc_vancouver;

@property (nonatomic, assign) NSInteger  pc_recordings;

@property (nonatomic, assign) NSInteger  pc_usenet;

@property (nonatomic, copy) NSString * pc_beck;

@property (nonatomic, strong) NSArray <PC_PersonInfoModel_Counterclockwise_Darkstar *> * pc_darkstar;

@property (nonatomic, assign) NSInteger  pc_gentlemen;

@property (nonatomic, copy) NSString * pc_refer;

@property (nonatomic, copy) NSString * pc_bc;

@property (nonatomic, assign) bool  pc_hecklers;

@property (nonatomic, copy) NSString * pc_snob;

/// 选项编辑的值 和保存返回的值
@property (nonatomic, copy) NSString * pc_announcements;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end


@interface PC_PersonInfoModel_Counterclockwise_Darkstar : NSObject

@property (nonatomic, copy) NSString * pc_shoot;

@property (nonatomic, assign) NSInteger  pc_disposing;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
