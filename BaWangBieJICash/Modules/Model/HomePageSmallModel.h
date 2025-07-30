//
//  HomePageSmallModel.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import <Foundation/Foundation.h>

@class PC_HomeSmallModel_Inserting,PC_HomeSmallModel_Inserting_Consists,PC_HomeSmallModel_Gathered;

NS_ASSUME_NONNULL_BEGIN

@interface HomePageSmallModel : NSObject

@property (nonatomic, copy) NSString * pc_jE2yNL;

@property (nonatomic, assign) NSInteger  pc_isReyNotice;

@property (nonatomic, strong) NSArray<NSString *> *pc_arrested;

@property (nonatomic, assign) NSInteger  pc_isPopLw;

@property (nonatomic, copy) NSString * pc_isReyNoticeMsg;

@property (nonatomic, assign) NSInteger  pc_isAuh;

@property (nonatomic, strong) NSArray<PC_HomeSmallModel_Inserting *> *pc_inserting;

@property (nonatomic, copy) NSString * pc_privacyAgreement;

@property (nonatomic, strong) PC_HomeSmallModel_Gathered * pc_gathered;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_HomeSmallModel_Inserting : NSObject

@property (nonatomic, copy) NSString * pc_disposing;

@property (nonatomic, strong) NSArray<PC_HomeSmallModel_Inserting_Consists *> *pc_consists;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_HomeSmallModel_Inserting_Consists : NSObject

@property (nonatomic, copy) NSString * pc_instruct;

@property (nonatomic, assign) NSInteger  pc_commemorate;

@property (nonatomic, copy) NSString * pc_longer;

@property (nonatomic, copy) NSString * pc_reunited;

@property (nonatomic, copy) NSString * pc_godzilla;

@property (nonatomic, strong) NSArray<NSString *> *pc_san;

@property (nonatomic, assign) NSInteger  pc_respective;

@property (nonatomic, copy) NSString * pc_wonderfully;

@property (nonatomic, copy) NSString * pc_gila;

@property (nonatomic, assign) NSInteger  pc_classically;

@property (nonatomic, copy) NSString * pc_engineer;

@property (nonatomic, copy) NSString * pc_megalon;

@property (nonatomic, copy) NSString * pc_reunions;

@property (nonatomic, copy) NSString * pc_merely;

@property (nonatomic, assign) NSInteger  pc_feig;

@property (nonatomic, strong) NSArray<NSString *> *pc_cartoons;

@property (nonatomic, assign) NSInteger  pc_dump;

@property (nonatomic, copy) NSString * pc_boxed;

@property (nonatomic, copy) NSString * pc_yahoo;

@property (nonatomic, assign) NSInteger  pc_consumers;

@property (nonatomic, copy) NSString * pc_seminar;

@property (nonatomic, copy) NSString * pc_discussion;

@property (nonatomic, copy) NSString * pc_conflicts;

@property (nonatomic, copy) NSString * pc_burned;

@property (nonatomic, assign) NSInteger  pc_expect;

@property (nonatomic, strong) NSArray * pc_companion;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_HomeSmallModel_Gathered : NSObject

@property (nonatomic, copy) NSString * pc_regulars;

@property (nonatomic, copy) NSString * pc_fqUrl;

@property (nonatomic, copy) NSString * pc_customUrl;

@property (nonatomic, copy) NSString * pc_reunion;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
