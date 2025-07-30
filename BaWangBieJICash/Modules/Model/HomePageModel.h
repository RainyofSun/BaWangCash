//
//  HomePageModel.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PC_HomeModel_Inserting,PC_HomeModel_Inserting_Consists,PC_HomeModel_Gathered;

@interface HomePageModel : NSObject

@property (nonatomic, copy) NSString * pc_DCkz;

@property (nonatomic, strong) NSNull * pc_D8dU0w8lp32Q;

@property (nonatomic, copy) NSString * pc_gnSgfiR;

@property (nonatomic, assign) NSInteger  pc_isPopLw;

@property (nonatomic, strong) NSArray<NSString *> *pc_arrested;

@property (nonatomic, assign) NSInteger  pc_isReyNotice;

@property (nonatomic, copy) NSString * pc_isReyNoticeMsg;

@property (nonatomic, strong) NSArray<PC_HomeModel_Inserting *> *pc_inserting;

@property (nonatomic, assign) NSInteger  pc_isAuh;

@property (nonatomic, copy) NSString * pc_privacyAgreement;

@property (nonatomic, strong) PC_HomeModel_Gathered * pc_gathered;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_HomeModel_Inserting : NSObject

@property (nonatomic, copy) NSString * pc_disposing;

@property (nonatomic, strong) NSArray<PC_HomeModel_Inserting_Consists *> *pc_consists;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_HomeModel_Inserting_Consists : NSObject

@property (nonatomic, copy) NSString * pc_longer;

@property (nonatomic, assign) NSInteger  pc_consumers;

@property (nonatomic, copy) NSString * pc_seminar;

@property (nonatomic, copy) NSString * pc_boxed;

@property (nonatomic, copy) NSString * pc_megalon;

@property (nonatomic, copy) NSString * pc_instruct;

@property (nonatomic, copy) NSString * pc_conflicts;

@property (nonatomic, copy) NSString * pc_godzilla;

@property (nonatomic, copy) NSString * pc_collection;

@property (nonatomic, copy) NSString * pc_threeDes;

@property (nonatomic, copy) NSString * pc_gila;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_HomeModel_Gathered : NSObject

@property (nonatomic, copy) NSString * pc_regulars;

@property (nonatomic, copy) NSString * pc_fqUrl;

@property (nonatomic, copy) NSString * pc_customUrl;

@property (nonatomic, copy) NSString * pc_reunion;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
