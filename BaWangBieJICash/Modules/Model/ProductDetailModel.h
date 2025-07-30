//
//  ProductDetailModel.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PC_ProduceDetailModel_Userinfo,PC_ProduceDetailModel_Gore,PC_ProduceDetailModel_Gore_Far,PC_ProduceDetailModel_Gore_Far_Zappa,PC_ProduceDetailModel_Gore_Far_Expressed,PC_ProduceDetailModel_Gore_Mistings,PC_ProduceDetailModel_Postal,PC_ProduceDetailModel_Options,PC_ProduceDetailModel_Rec;

@interface ProductDetailModel : NSObject

@property (nonatomic, strong) PC_ProduceDetailModel_Userinfo * pc_userInfo;

@property (nonatomic, strong) NSNull * pc_Nw5c9z;

@property (nonatomic, copy) NSString * pc_UCA8;

@property (nonatomic, assign) NSInteger  pc_cKWFH9Ss;

@property (nonatomic, assign) NSInteger  pc_jillette;

@property (nonatomic, strong) PC_ProduceDetailModel_Gore * pc_gore;

@property (nonatomic, copy) NSString * pc_V6a00TKu7E;

@property (nonatomic, copy) NSString * pc_kVcF;

@property (nonatomic, copy) NSString * pc_6FMAtit;

@property (nonatomic, strong) PC_ProduceDetailModel_Postal * pc_postal;

///【重要】借款协议
@property (nonatomic, strong) PC_ProduceDetailModel_Options * pc_options;

@property (nonatomic, strong) NSArray<PC_ProduceDetailModel_Rec *> *pc_rec;

@property (nonatomic, copy) NSString * pc_5jDJ1goG9I;

@property (nonatomic, copy) NSString * pc_1ihqr;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_ProduceDetailModel_Userinfo : NSObject

@property (nonatomic, copy) NSString * pc_bender;

@property (nonatomic, strong) NSNull * pc_shoot;

@property (nonatomic, strong) NSNull * pc_idNumber;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_ProduceDetailModel_Gore : NSObject

@property (nonatomic, copy) NSString * pc_merely;

@property (nonatomic, copy) NSString * pc_instruct;

@property (nonatomic, copy) NSString * pc_consumers;

@property (nonatomic, copy) NSString * pc_conflicts;

@property (nonatomic, strong) PC_ProduceDetailModel_Gore_Far * pc_far;

@property (nonatomic, copy) NSString * pc_electric;

@property (nonatomic, strong) NSArray<NSString *> *pc_death;

@property (nonatomic, copy) NSString * pc_funniest;

@property (nonatomic, assign) NSInteger  pc_calling;

@property (nonatomic, copy) NSString * pc_thing;

@property (nonatomic, assign) NSInteger  pc_computer;

@property (nonatomic, copy) NSString * pc_culture;

@property (nonatomic, copy) NSString * pc_attempts;

@property (nonatomic, strong) PC_ProduceDetailModel_Gore_Mistings * pc_mistings;

@property (nonatomic, assign) NSInteger  pc_track;

@property (nonatomic, copy) NSString * pc_misc;

@property (nonatomic, strong) NSArray<NSNumber *> *pc_al;

@property (nonatomic, copy) NSString * pc_fucking;

@property (nonatomic, copy) NSString * pc_seminar;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_ProduceDetailModel_Gore_Far : NSObject

@property (nonatomic, strong) PC_ProduceDetailModel_Gore_Far_Zappa * pc_zappa;

@property (nonatomic, strong) PC_ProduceDetailModel_Gore_Far_Expressed * pc_expressed;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_ProduceDetailModel_Gore_Far_Zappa : NSObject

@property (nonatomic, copy) NSString * pc_beck;

@property (nonatomic, copy) NSString * pc_earliest;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_ProduceDetailModel_Gore_Far_Expressed : NSObject

@property (nonatomic, copy) NSString * pc_beck;

@property (nonatomic, copy) NSString * pc_earliest;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_ProduceDetailModel_Gore_Mistings : NSObject

@property (nonatomic, copy) NSString * pc_announcements;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_ProduceDetailModel_Postal : NSObject

@property (nonatomic, copy) NSString * pc_beck;

@property (nonatomic, copy) NSString * pc_merely;

@property (nonatomic, copy) NSString * pc_receiving;

@property (nonatomic, assign) NSInteger  pc_disposing;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_ProduceDetailModel_Options : NSObject

@property (nonatomic, copy) NSString * pc_beck;

@property (nonatomic, copy) NSString * pc_thrive;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_ProduceDetailModel_Rec : NSObject

@property (nonatomic, copy) NSString * pc_merely;

@property (nonatomic, assign) NSInteger  pc_usenet;

@property (nonatomic, copy) NSString * pc_newsgroups;

@property (nonatomic, assign) NSInteger  pc_peak;

@property (nonatomic, assign) NSInteger  pc_encouraged;

@property (nonatomic, assign) NSInteger  pc_disposing;

@property (nonatomic, copy) NSString * pc_receiving;

@property (nonatomic, copy) NSString * pc_closed;

@property (nonatomic, copy) NSString * pc_drawings;

@property (nonatomic, copy) NSString * pc_beck;

@property (nonatomic, copy) NSString * pc_refer;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
