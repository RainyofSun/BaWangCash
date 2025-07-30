//
//  UserIdentifiInfoModel.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "UserIdentifiInfoModel.h"

@implementation UserIdentifiInfoModel

+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    UserIdentifiInfoModel *model = [UserIdentifiInfoModel new];


    if ([dict[@"id_front_msg"] isKindOfClass:[NSString class]]) {
        model.pc_id_front_msg = ((NSString *)dict[@"id_front_msg"]);
    }

    if ([dict[@"arts"] isKindOfClass:[NSDictionary class]]) {
        model.pc_arts = [PC_UserIdentiInfoModel_Arts ACModel_withDict:dict[@"arts"]];
    }

    if ([dict[@"garneau"] isKindOfClass:[NSArray class]]) {
        model.pc_garneau = ((NSArray<NSString *>*)dict[@"garneau"]);
    }

    if ([dict[@"alberta"] isKindOfClass:[NSNumber class]]) {
        model.pc_alberta = ((NSNumber *)dict[@"alberta"]).integerValue;
    }

    if ([dict[@"pan"] isKindOfClass:[NSArray class]]) {

        model.pc_pan = [NSArray new];

    }

    if ([dict[@"kdHwUIE"] isKindOfClass:[NSNull class]]) {
        model.pc_kdHwUIE = ((NSNull *)dict[@"kdHwUIE"]);
    }

    if ([dict[@"5oucXcm5sl"] isKindOfClass:[NSString class]]) {
        model.pc_5oucXcm5sl = ((NSString *)dict[@"5oucXcm5sl"]);
    }

    if ([dict[@"edmonton"] isKindOfClass:[NSArray class]]) {
        model.pc_edmonton = ((NSArray<NSString *>*)dict[@"edmonton"]);
    }

    if ([dict[@"3bzcnQ"] isKindOfClass:[NSString class]]) {
        model.pc_3bzcnQ = ((NSString *)dict[@"3bzcnQ"]);
    }

    if ([dict[@"CfFABtIt"] isKindOfClass:[NSString class]]) {
        model.pc_CfFABtIt = ((NSString *)dict[@"CfFABtIt"]);
    }

    if ([dict[@"KWvE4g"] isKindOfClass:[NSNull class]]) {
        model.pc_KWvE4g = ((NSNull *)dict[@"KWvE4g"]);
    }

    if ([dict[@"face_msg"] isKindOfClass:[NSString class]]) {
        model.pc_face_msg = ((NSString *)dict[@"face_msg"]);
    }

    if ([dict[@"acquired"] isKindOfClass:[NSDictionary class]]) {
        model.pc_acquired = [PC_UserIdentiInfoModel_Acquired ACModel_withDict:dict[@"acquired"]];
    }

    
    return model;
}

@end

@interface PC_UserIdentiInfoModel_Arts ()

@end

@implementation PC_UserIdentiInfoModel_Arts


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_UserIdentiInfoModel_Arts *model = [PC_UserIdentiInfoModel_Arts new];


    if ([dict[@"merely"] isKindOfClass:[NSString class]]) {
        model.pc_merely = ((NSString *)dict[@"merely"]);
    }

    if ([dict[@"usenet"] isKindOfClass:[NSNumber class]]) {
        model.pc_usenet = ((NSNumber *)dict[@"usenet"]).integerValue;
    }

    
    return model;
}

@end

@interface PC_UserIdentiInfoModel_Acquired ()

@end

@implementation PC_UserIdentiInfoModel_Acquired


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_UserIdentiInfoModel_Acquired *model = [PC_UserIdentiInfoModel_Acquired new];


    if ([dict[@"merely"] isKindOfClass:[NSString class]]) {
        model.pc_merely = ((NSString *)dict[@"merely"]);
    }

    if ([dict[@"successfully"] isKindOfClass:[NSString class]]) {
        model.pc_successfully = ((NSString *)dict[@"successfully"]);
    }

    if ([dict[@"info"] isKindOfClass:[NSDictionary class]]) {
        model.pc_info = [PC_UserIdentiInfoModel_Acquired_Info ACModel_withDict:dict[@"info"]];
    }

    if ([dict[@"usenet"] isKindOfClass:[NSNumber class]]) {
        model.pc_usenet = ((NSNumber *)dict[@"usenet"]).integerValue;
    }

    
    return model;
}

@end

@interface PC_UserIdentiInfoModel_Acquired_Info ()

@end

@implementation PC_UserIdentiInfoModel_Acquired_Info


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_UserIdentiInfoModel_Acquired_Info *model = [PC_UserIdentiInfoModel_Acquired_Info new];


    if ([dict[@"shoot"] isKindOfClass:[NSString class]]) {
        model.pc_shoot = ((NSString *)dict[@"shoot"]);
    }

    if ([dict[@"washington"] isKindOfClass:[NSString class]]) {
        model.pc_washington = ((NSString *)dict[@"washington"]);
    }

    if ([dict[@"flicks"] isKindOfClass:[NSString class]]) {
        model.pc_flicks = ((NSString *)dict[@"flicks"]);
    }

    
    return model;
}

@end
