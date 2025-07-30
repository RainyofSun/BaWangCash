//
//  ContactModel.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "ContactModel.h"

@implementation ContactModel

+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    ContactModel *model = [ContactModel new];


    if ([dict[@"upType"] isKindOfClass:[NSNumber class]]) {
        model.pc_upType = ((NSNumber *)dict[@"upType"]).integerValue;
    }

    if ([dict[@"Xv60"] isKindOfClass:[NSString class]]) {
        model.pc_Xv60 = ((NSString *)dict[@"Xv60"]);
    }

    if ([dict[@"understand"] isKindOfClass:[NSArray class]]) {

        NSMutableArray *understand_modelArray = [NSMutableArray new];
        for (NSDictionary *sub_dict in (NSArray *)dict[@"understand"]) {
            if (![sub_dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            PC_ContactModel_Understand *sub_model = [PC_ContactModel_Understand ACModel_withDict:sub_dict];
            [understand_modelArray addObject:sub_model];
        }
        model.pc_understand = understand_modelArray;
    }
    if ([dict[@"K1l1N"] isKindOfClass:[NSString class]]) {
        model.pc_K1l1N = ((NSString *)dict[@"K1l1N"]);
    }

    if ([dict[@"counterclockwise"] isKindOfClass:[NSArray class]]) {

        model.pc_counterclockwise = [NSArray new];

    }

    
    return model;
}

@end

@interface PC_ContactModel_Understand ()

@end

@implementation PC_ContactModel_Understand


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_ContactModel_Understand *model = [PC_ContactModel_Understand new];


    if ([dict[@"viewer"] isKindOfClass:[NSString class]]) {
        model.pc_viewer = ((NSString *)dict[@"viewer"]);
    }

    if ([dict[@"junkies"] isKindOfClass:[NSString class]]) {
        model.pc_junkies = ((NSString *)dict[@"junkies"]);
    }

    if ([dict[@"shoot"] isKindOfClass:[NSString class]]) {
        model.pc_shoot = ((NSString *)dict[@"shoot"]);
    }

    if ([dict[@"darkstar"] isKindOfClass:[NSArray class]]) {

        NSMutableArray *darkstar_modelArray = [NSMutableArray new];
        for (NSDictionary *sub_dict in (NSArray *)dict[@"darkstar"]) {
            if (![sub_dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            PC_ContactModel_Understand_Darkstar *sub_model = [PC_ContactModel_Understand_Darkstar ACModel_withDict:sub_dict];
            [darkstar_modelArray addObject:sub_model];
        }
        model.pc_darkstar = darkstar_modelArray;
    }
    if ([dict[@"snarking"] isKindOfClass:[NSString class]]) {
        model.pc_snarking = ((NSString *)dict[@"snarking"]);
    }

    if ([dict[@"aim"] isKindOfClass:[NSString class]]) {
        model.pc_aim = ((NSString *)dict[@"aim"]);
    }

    if ([dict[@"beck"] isKindOfClass:[NSString class]]) {
        model.pc_beck = ((NSString *)dict[@"beck"]);
    }

    if ([dict[@"redlettermedia"] isKindOfClass:[NSString class]]) {
        model.pc_redlettermedia = ((NSString *)dict[@"redlettermedia"]);
    }

    if ([dict[@"approaches"] isKindOfClass:[NSString class]]) {
        model.pc_approaches = ((NSString *)dict[@"approaches"]);
    }

    
    return model;
}

@end

@interface PC_ContactModel_Understand_Darkstar ()

@end

@implementation PC_ContactModel_Understand_Darkstar


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_ContactModel_Understand_Darkstar *model = [PC_ContactModel_Understand_Darkstar new];


    if ([dict[@"shoot"] isKindOfClass:[NSString class]]) {
        model.pc_shoot = ((NSString *)dict[@"shoot"]);
    }

    if ([dict[@"disposing"] isKindOfClass:[NSString class]]) {
        model.pc_disposing = ((NSString *)dict[@"disposing"]);
    }

    
    return model;
}

@end
