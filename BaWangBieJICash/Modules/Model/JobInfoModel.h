//
//  JobInfoModel.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PC_JobInfoModel_Counterclockwise,PC_JobInfoModel_Counterclockwise_Darkstar;

@interface JobInfoModel : NSObject

@property (nonatomic, copy) NSString * pc_2O0R7N1qX4;

@property (nonatomic, copy) NSString * pc_78XX;

@property (nonatomic, strong) NSArray<PC_JobInfoModel_Counterclockwise *> *pc_counterclockwise;

@property (nonatomic, strong) NSNull * pc_4Lcfu4ZJoxw;

@property (nonatomic, copy) NSString * pc_rhjEsHzA;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_JobInfoModel_Counterclockwise : NSObject

@property (nonatomic, copy) NSString * pc_newsgroups;

@property (nonatomic, assign) NSInteger  pc_consumers;

@property (nonatomic, assign) NSInteger  pc_vancouver;

@property (nonatomic, assign) NSInteger  pc_recordings;

@property (nonatomic, assign) NSInteger  pc_usenet;

@property (nonatomic, copy) NSString * pc_beck;

@property (nonatomic, strong) NSArray<PC_JobInfoModel_Counterclockwise_Darkstar *> *pc_darkstar;

@property (nonatomic, assign) NSInteger  pc_gentlemen;

@property (nonatomic, copy) NSString * pc_refer;

@property (nonatomic, copy) NSString * pc_bc;

@property (nonatomic, assign) bool  pc_hecklers;

@property (nonatomic, copy) NSString * pc_snob;

@property (nonatomic, copy) NSString * pc_announcements;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_JobInfoModel_Counterclockwise_Darkstar : NSObject

@property (nonatomic, copy) NSString * pc_shoot;

@property (nonatomic, assign) NSInteger  pc_disposing;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
