//
//  UserIdentifiInfoModel.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PC_UserIdentiInfoModel_Arts,PC_UserIdentiInfoModel_Acquired,PC_UserIdentiInfoModel_Acquired_Info;

@interface UserIdentifiInfoModel : NSObject

@property (nonatomic, copy) NSString * pc_id_front_msg;

@property (nonatomic, strong) PC_UserIdentiInfoModel_Arts * pc_arts;

@property (nonatomic, strong) NSArray<NSString *> *pc_garneau;

@property (nonatomic, assign) NSInteger  pc_alberta;

@property (nonatomic, strong) NSArray * pc_pan;

@property (nonatomic, strong) NSNull * pc_kdHwUIE;

@property (nonatomic, copy) NSString * pc_5oucXcm5sl;

@property (nonatomic, strong) NSArray<NSString *> *pc_edmonton;

@property (nonatomic, copy) NSString * pc_3bzcnQ;

@property (nonatomic, copy) NSString * pc_CfFABtIt;

@property (nonatomic, strong) NSNull * pc_KWvE4g;

@property (nonatomic, copy) NSString * pc_face_msg;

@property (nonatomic, strong) PC_UserIdentiInfoModel_Acquired * pc_acquired;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_UserIdentiInfoModel_Arts : NSObject

@property (nonatomic, copy) NSString * pc_merely;

@property (nonatomic, assign) NSInteger  pc_usenet;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_UserIdentiInfoModel_Acquired : NSObject

@property (nonatomic, copy) NSString * pc_merely;

@property (nonatomic, copy) NSString * pc_successfully;

@property (nonatomic, strong) PC_UserIdentiInfoModel_Acquired_Info * pc_info;

@property (nonatomic, assign) NSInteger  pc_usenet;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_UserIdentiInfoModel_Acquired_Info : NSObject

@property (nonatomic, copy) NSString * pc_shoot;

@property (nonatomic, copy) NSString * pc_washington;

@property (nonatomic, copy) NSString * pc_flicks;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
