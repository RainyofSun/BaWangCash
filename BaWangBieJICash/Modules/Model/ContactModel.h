//
//  ContactModel.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PC_ContactModel_Understand,PC_ContactModel_Understand_Darkstar;

@interface ContactModel : NSIndexPath

@property (nonatomic, assign) NSInteger  pc_upType;

@property (nonatomic, copy) NSString * pc_Xv60;

@property (nonatomic, strong) NSArray<PC_ContactModel_Understand *> *pc_understand;

@property (nonatomic, copy) NSString * pc_K1l1N;

@property (nonatomic, strong) NSArray * pc_counterclockwise;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_ContactModel_Understand : NSObject

/// 联系人关键键  为空表示未填写
@property (nonatomic, copy) NSString * pc_viewer;

@property (nonatomic, copy) NSString * pc_junkies;
///【重要】联系人姓名   为空表示未填写
@property (nonatomic, copy) NSString * pc_shoot;

@property (nonatomic, strong) NSArray<PC_ContactModel_Understand_Darkstar *> *pc_darkstar;

@property (nonatomic, copy) NSString * pc_snarking;

///【重要】联系人电话  为空表示未填写
@property (nonatomic, copy) NSString * pc_aim;

@property (nonatomic, copy) NSString * pc_beck;

@property (nonatomic, copy) NSString * pc_redlettermedia;

@property (nonatomic, copy) NSString * pc_approaches;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_ContactModel_Understand_Darkstar : NSObject

@property (nonatomic, copy) NSString * pc_shoot;

@property (nonatomic, copy) NSString * pc_disposing;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
