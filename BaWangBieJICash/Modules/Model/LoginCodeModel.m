//
//  LoginCodeModel.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "LoginCodeModel.h"

@implementation LoginCodeModel

+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    LoginCodeModel *model = [LoginCodeModel new];


    if ([dict[@"qFFG2rUDMAaQ"] isKindOfClass:[NSString class]]) {
        model.pc_qFFG2rUDMAaQ = ((NSString *)dict[@"qFFG2rUDMAaQ"]);
    }

    if ([dict[@"NG8dKzUw1B"] isKindOfClass:[NSString class]]) {
        model.pc_NG8dKzUw1B = ((NSString *)dict[@"NG8dKzUw1B"]);
    }

    if ([dict[@"c3lvJoFeb"] isKindOfClass:[NSString class]]) {
        model.pc_c3lvJoFeb = ((NSString *)dict[@"c3lvJoFeb"]);
    }

    if ([dict[@"rEFy"] isKindOfClass:[NSString class]]) {
        model.pc_rEFy = ((NSString *)dict[@"rEFy"]);
    }

    if ([dict[@"mc5yMCj9Hr"] isKindOfClass:[NSNull class]]) {
        model.pc_mc5yMCj9Hr = ((NSNull *)dict[@"mc5yMCj9Hr"]);
    }

    if ([dict[@"QlVeG"] isKindOfClass:[NSNumber class]]) {
        model.pc_QlVeG = ((NSNumber *)dict[@"QlVeG"]).integerValue;
    }

    if ([dict[@"lkQUjvmy69"] isKindOfClass:[NSString class]]) {
        model.pc_lkQUjvmy69 = ((NSString *)dict[@"lkQUjvmy69"]);
    }

    if ([dict[@"consists"] isKindOfClass:[NSDictionary class]]) {
        model.pc_consists = [PC_LoginCodeModel_Consists ACModel_withDict:dict[@"consists"]];
    }

    if ([dict[@"0Nixf1TV"] isKindOfClass:[NSNull class]]) {
        model.pc_0Nixf1TV = ((NSNull *)dict[@"0Nixf1TV"]);
    }

    
    return model;
}

@end

@implementation PC_LoginCodeModel_Consists


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_LoginCodeModel_Consists *model = [PC_LoginCodeModel_Consists new];


    if ([dict[@"flag"] isKindOfClass:[NSString class]]) {
        model.pc_flag = ((NSString *)dict[@"flag"]);
    }

    if ([dict[@"RCaptchaKey"] isKindOfClass:[NSString class]]) {
        model.pc_RCaptchaKey = ((NSString *)dict[@"RCaptchaKey"]);
    }

    if ([dict[@"consists"] isKindOfClass:[NSString class]]) {
        model.pc_consists = ((NSString *)dict[@"consists"]);
    }

    if ([dict[@"snob"] isKindOfClass:[NSString class]]) {
        model.pc_snob = ((NSString *)dict[@"snob"]);
    }

    if ([dict[@"expecting"] isKindOfClass:[NSNumber class]]) {
        model.pc_expecting = ((NSNumber *)dict[@"expecting"]).integerValue;
    }

    
    return model;
}

@end
