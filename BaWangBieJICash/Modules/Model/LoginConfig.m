//
//  LoginConfig.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "LoginConfig.h"

@implementation LoginConfig

+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    LoginConfig *model = [LoginConfig new];


    if ([dict[@"allers"] isKindOfClass:[NSNumber class]]) {
        model.pc_allers = ((NSNumber *)dict[@"allers"]).integerValue;
    }

    if ([dict[@"king"] isKindOfClass:[NSNumber class]]) {
        model.pc_king = ((NSNumber *)dict[@"king"]).integerValue;
    }

    if ([dict[@"AAv7ndpIU"] isKindOfClass:[NSString class]]) {
        model.pc_AAv7ndpIU = ((NSString *)dict[@"AAv7ndpIU"]);
    }

    if ([dict[@"2LQW"] isKindOfClass:[NSString class]]) {
        model.pc_2LQW = ((NSString *)dict[@"2LQW"]);
    }

    if ([dict[@"commenting"] isKindOfClass:[NSDictionary class]]) {
        model.pc_commenting = [PC_LoginConfig_Commenting ACModel_withDict:dict[@"commenting"]];
    }

    if ([dict[@"4oh8Hy0CgJ"] isKindOfClass:[NSString class]]) {
        model.pc_4oh8Hy0CgJ = ((NSString *)dict[@"4oh8Hy0CgJ"]);
    }

    if ([dict[@"zxText"] isKindOfClass:[NSString class]]) {
        model.pc_zxText = ((NSString *)dict[@"zxText"]);
    }

    if ([dict[@"disney"] isKindOfClass:[NSDictionary class]]) {
        model.pc_disney = [PC_LoginConfig_Disney ACModel_withDict:dict[@"disney"]];
    }

    if ([dict[@"lion"] isKindOfClass:[NSString class]]) {
        model.pc_lion = ((NSString *)dict[@"lion"]);
    }

    if ([dict[@"rfMNjHB"] isKindOfClass:[NSString class]]) {
        model.pc_rfMNjHB = ((NSString *)dict[@"rfMNjHB"]);
    }

    if ([dict[@"70IbTwIJW9Q"] isKindOfClass:[NSNumber class]]) {
        model.pc_70IbTwIJW9Q = ((NSNumber *)dict[@"70IbTwIJW9Q"]).integerValue;
    }

    if ([dict[@"5zvevtLeqEh"] isKindOfClass:[NSString class]]) {
        model.pc_5zvevtLeqEh = ((NSString *)dict[@"5zvevtLeqEh"]);
    }

    if ([dict[@"BhgOa3YtW"] isKindOfClass:[NSNull class]]) {
        model.pc_BhgOa3YtW = ((NSNull *)dict[@"BhgOa3YtW"]);
    }

    if ([dict[@"16zdJdKkh"] isKindOfClass:[NSString class]]) {
        model.pc_16zdJdKkh = ((NSString *)dict[@"16zdJdKkh"]);
    }

    
    return model;
}

@end

@implementation PC_LoginConfig_Commenting


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_LoginConfig_Commenting *model = [PC_LoginConfig_Commenting new];


    if ([dict[@"pumbaa"] isKindOfClass:[NSString class]]) {
        model.pc_pumbaa = ((NSString *)dict[@"pumbaa"]);
    }

    if ([dict[@"timon"] isKindOfClass:[NSString class]]) {
        model.pc_timon = ((NSString *)dict[@"timon"]);
    }

    
    return model;
}

@end

@implementation PC_LoginConfig_Disney


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_LoginConfig_Disney *model = [PC_LoginConfig_Disney new];


    if ([dict[@"happy"] isKindOfClass:[NSString class]]) {
        model.pc_happy = ((NSString *)dict[@"happy"]);
    }

    if ([dict[@"virgin"] isKindOfClass:[NSString class]]) {
        model.pc_virgin = ((NSString *)dict[@"virgin"]);
    }

    if ([dict[@"yeared"] isKindOfClass:[NSString class]]) {
        model.pc_yeared = ((NSString *)dict[@"yeared"]);
    }

    if ([dict[@"poster"] isKindOfClass:[NSString class]]) {
        model.pc_poster = ((NSString *)dict[@"poster"]);
    }

    
    return model;
}

@end
