//
//  JobInfoModel.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "JobInfoModel.h"

@implementation JobInfoModel

+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    JobInfoModel *model = [JobInfoModel new];


    if ([dict[@"2O0R7N1qX4"] isKindOfClass:[NSString class]]) {
        model.pc_2O0R7N1qX4 = ((NSString *)dict[@"2O0R7N1qX4"]);
    }

    if ([dict[@"78XX"] isKindOfClass:[NSString class]]) {
        model.pc_78XX = ((NSString *)dict[@"78XX"]);
    }

    if ([dict[@"counterclockwise"] isKindOfClass:[NSArray class]]) {

        NSMutableArray *counterclockwise_modelArray = [NSMutableArray new];
        for (NSDictionary *sub_dict in (NSArray *)dict[@"counterclockwise"]) {
            if (![sub_dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            PC_JobInfoModel_Counterclockwise *sub_model = [PC_JobInfoModel_Counterclockwise ACModel_withDict:sub_dict];
            [counterclockwise_modelArray addObject:sub_model];
        }
        model.pc_counterclockwise = counterclockwise_modelArray;
    }
    if ([dict[@"4Lcfu4ZJoxw"] isKindOfClass:[NSNull class]]) {
        model.pc_4Lcfu4ZJoxw = ((NSNull *)dict[@"4Lcfu4ZJoxw"]);
    }

    if ([dict[@"rhjEsHzA"] isKindOfClass:[NSString class]]) {
        model.pc_rhjEsHzA = ((NSString *)dict[@"rhjEsHzA"]);
    }

    
    return model;
}

@end

@interface PC_JobInfoModel_Counterclockwise ()

@end

@implementation PC_JobInfoModel_Counterclockwise


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_JobInfoModel_Counterclockwise *model = [PC_JobInfoModel_Counterclockwise new];


    if ([dict[@"newsgroups"] isKindOfClass:[NSString class]]) {
        model.pc_newsgroups = ((NSString *)dict[@"newsgroups"]);
    }

    if ([dict[@"consumers"] isKindOfClass:[NSNumber class]]) {
        model.pc_consumers = ((NSNumber *)dict[@"consumers"]).integerValue;
    }

    if ([dict[@"vancouver"] isKindOfClass:[NSNumber class]]) {
        model.pc_vancouver = ((NSNumber *)dict[@"vancouver"]).integerValue;
    }

    if ([dict[@"recordings"] isKindOfClass:[NSNumber class]]) {
        model.pc_recordings = ((NSNumber *)dict[@"recordings"]).integerValue;
    }

    if ([dict[@"usenet"] isKindOfClass:[NSNumber class]]) {
        model.pc_usenet = ((NSNumber *)dict[@"usenet"]).integerValue;
    }

    if ([dict[@"beck"] isKindOfClass:[NSString class]]) {
        model.pc_beck = ((NSString *)dict[@"beck"]);
    }

    if ([dict[@"darkstar"] isKindOfClass:[NSArray class]]) {

        NSMutableArray *darkstar_modelArray = [NSMutableArray new];
        for (NSDictionary *sub_dict in (NSArray *)dict[@"darkstar"]) {
            if (![sub_dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            PC_JobInfoModel_Counterclockwise_Darkstar *sub_model = [PC_JobInfoModel_Counterclockwise_Darkstar ACModel_withDict:sub_dict];
            [darkstar_modelArray addObject:sub_model];
        }
        model.pc_darkstar = darkstar_modelArray;
    }
    if ([dict[@"gentlemen"] isKindOfClass:[NSNumber class]]) {
        model.pc_gentlemen = ((NSNumber *)dict[@"gentlemen"]).integerValue;
    }

    if ([dict[@"refer"] isKindOfClass:[NSString class]]) {
        model.pc_refer = ((NSString *)dict[@"refer"]);
    }

    if ([dict[@"bc"] isKindOfClass:[NSString class]]) {
        model.pc_bc = ((NSString *)dict[@"bc"]);
    }

    if ([dict[@"hecklers"] isKindOfClass:[NSNumber class]]) {
        model.pc_hecklers = ((NSNumber *)dict[@"hecklers"]).boolValue;
    }

    if ([dict[@"snob"] isKindOfClass:[NSString class]]) {
        model.pc_snob = ((NSString *)dict[@"snob"]);
    }

    if ([dict[@"announcements"] isKindOfClass:[NSString class]]) {
        model.pc_announcements = ((NSString *)dict[@"announcements"]);
    }

    
    return model;
}

@end

@interface PC_JobInfoModel_Counterclockwise_Darkstar ()

@end

@implementation PC_JobInfoModel_Counterclockwise_Darkstar


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_JobInfoModel_Counterclockwise_Darkstar *model = [PC_JobInfoModel_Counterclockwise_Darkstar new];


    if ([dict[@"shoot"] isKindOfClass:[NSString class]]) {
        model.pc_shoot = ((NSString *)dict[@"shoot"]);
    }

    if ([dict[@"disposing"] isKindOfClass:[NSNumber class]]) {
        model.pc_disposing = ((NSNumber *)dict[@"disposing"]).integerValue;
    }

    
    return model;
}

@end
