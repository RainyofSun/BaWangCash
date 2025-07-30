//
//  HomePageSmallModel.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "HomePageSmallModel.h"

@implementation HomePageSmallModel

+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    HomePageSmallModel *model = [HomePageSmallModel new];


    if ([dict[@"jE2yNL"] isKindOfClass:[NSString class]]) {
        model.pc_jE2yNL = ((NSString *)dict[@"jE2yNL"]);
    }

    if ([dict[@"isReyNotice"] isKindOfClass:[NSNumber class]]) {
        model.pc_isReyNotice = ((NSNumber *)dict[@"isReyNotice"]).integerValue;
    }

    if ([dict[@"arrested"] isKindOfClass:[NSArray class]]) {
        model.pc_arrested = ((NSArray<NSString *>*)dict[@"arrested"]);
    }

    if ([dict[@"isPopLw"] isKindOfClass:[NSNumber class]]) {
        model.pc_isPopLw = ((NSNumber *)dict[@"isPopLw"]).integerValue;
    }

    if ([dict[@"isReyNoticeMsg"] isKindOfClass:[NSString class]]) {
        model.pc_isReyNoticeMsg = ((NSString *)dict[@"isReyNoticeMsg"]);
    }

    if ([dict[@"isAuh"] isKindOfClass:[NSNumber class]]) {
        model.pc_isAuh = ((NSNumber *)dict[@"isAuh"]).integerValue;
    }

    if ([dict[@"inserting"] isKindOfClass:[NSArray class]]) {

        NSMutableArray *inserting_modelArray = [NSMutableArray new];
        for (NSDictionary *sub_dict in (NSArray *)dict[@"inserting"]) {
            if (![sub_dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            PC_HomeSmallModel_Inserting *sub_model = [PC_HomeSmallModel_Inserting ACModel_withDict:sub_dict];
            [inserting_modelArray addObject:sub_model];
        }
        model.pc_inserting = inserting_modelArray;
    }
    if ([dict[@"privacyAgreement"] isKindOfClass:[NSString class]]) {
        model.pc_privacyAgreement = ((NSString *)dict[@"privacyAgreement"]);
    }

    if ([dict[@"gathered"] isKindOfClass:[NSDictionary class]]) {
        model.pc_gathered = [PC_HomeSmallModel_Gathered ACModel_withDict:dict[@"gathered"]];
    }

    
    return model;
}

@end

@interface PC_HomeSmallModel_Inserting ()

@end

@implementation PC_HomeSmallModel_Inserting


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_HomeSmallModel_Inserting *model = [PC_HomeSmallModel_Inserting new];


    if ([dict[@"disposing"] isKindOfClass:[NSString class]]) {
        model.pc_disposing = ((NSString *)dict[@"disposing"]);
    }

    if ([dict[@"consists"] isKindOfClass:[NSArray class]]) {

        NSMutableArray *consists_modelArray = [NSMutableArray new];
        for (NSDictionary *sub_dict in (NSArray *)dict[@"consists"]) {
            if (![sub_dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            PC_HomeSmallModel_Inserting_Consists *sub_model = [PC_HomeSmallModel_Inserting_Consists ACModel_withDict:sub_dict];
            [consists_modelArray addObject:sub_model];
        }
        model.pc_consists = consists_modelArray;
    }
    
    return model;
}

@end

@interface PC_HomeSmallModel_Inserting_Consists ()

@end

@implementation PC_HomeSmallModel_Inserting_Consists


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_HomeSmallModel_Inserting_Consists *model = [PC_HomeSmallModel_Inserting_Consists new];


    if ([dict[@"instruct"] isKindOfClass:[NSString class]]) {
        model.pc_instruct = ((NSString *)dict[@"instruct"]);
    }

    if ([dict[@"commemorate"] isKindOfClass:[NSNumber class]]) {
        model.pc_commemorate = ((NSNumber *)dict[@"commemorate"]).integerValue;
    }

    if ([dict[@"longer"] isKindOfClass:[NSString class]]) {
        model.pc_longer = ((NSString *)dict[@"longer"]);
    }

    if ([dict[@"reunited"] isKindOfClass:[NSString class]]) {
        model.pc_reunited = ((NSString *)dict[@"reunited"]);
    }

    if ([dict[@"godzilla"] isKindOfClass:[NSString class]]) {
        model.pc_godzilla = ((NSString *)dict[@"godzilla"]);
    }

    if ([dict[@"san"] isKindOfClass:[NSArray class]]) {
        model.pc_san = ((NSArray<NSString *>*)dict[@"san"]);
    }

    if ([dict[@"respective"] isKindOfClass:[NSNumber class]]) {
        model.pc_respective = ((NSNumber *)dict[@"respective"]).integerValue;
    }

    if ([dict[@"wonderfully"] isKindOfClass:[NSString class]]) {
        model.pc_wonderfully = ((NSString *)dict[@"wonderfully"]);
    }

    if ([dict[@"gila"] isKindOfClass:[NSString class]]) {
        model.pc_gila = ((NSString *)dict[@"gila"]);
    }

    if ([dict[@"classically"] isKindOfClass:[NSNumber class]]) {
        model.pc_classically = ((NSNumber *)dict[@"classically"]).integerValue;
    }

    if ([dict[@"engineer"] isKindOfClass:[NSString class]]) {
        model.pc_engineer = ((NSString *)dict[@"engineer"]);
    }

    if ([dict[@"megalon"] isKindOfClass:[NSString class]]) {
        model.pc_megalon = ((NSString *)dict[@"megalon"]);
    }

    if ([dict[@"reunions"] isKindOfClass:[NSString class]]) {
        model.pc_reunions = ((NSString *)dict[@"reunions"]);
    }

    if ([dict[@"merely"] isKindOfClass:[NSString class]]) {
        model.pc_merely = ((NSString *)dict[@"merely"]);
    }

    if ([dict[@"feig"] isKindOfClass:[NSNumber class]]) {
        model.pc_feig = ((NSNumber *)dict[@"feig"]).integerValue;
    }

    if ([dict[@"cartoons"] isKindOfClass:[NSArray class]]) {
        model.pc_cartoons = ((NSArray<NSString *>*)dict[@"cartoons"]);
    }

    if ([dict[@"dump"] isKindOfClass:[NSNumber class]]) {
        model.pc_dump = ((NSNumber *)dict[@"dump"]).integerValue;
    }

    if ([dict[@"boxed"] isKindOfClass:[NSString class]]) {
        model.pc_boxed = ((NSString *)dict[@"boxed"]);
    }

    if ([dict[@"yahoo"] isKindOfClass:[NSString class]]) {
        model.pc_yahoo = ((NSString *)dict[@"yahoo"]);
    }

    if ([dict[@"consumers"] isKindOfClass:[NSNumber class]]) {
        model.pc_consumers = ((NSNumber *)dict[@"consumers"]).integerValue;
    }

    if ([dict[@"seminar"] isKindOfClass:[NSString class]]) {
        model.pc_seminar = ((NSString *)dict[@"seminar"]);
    }

    if ([dict[@"discussion"] isKindOfClass:[NSString class]]) {
        model.pc_discussion = ((NSString *)dict[@"discussion"]);
    }

    if ([dict[@"conflicts"] isKindOfClass:[NSString class]]) {
        model.pc_conflicts = ((NSString *)dict[@"conflicts"]);
    }

    if ([dict[@"burned"] isKindOfClass:[NSString class]]) {
        model.pc_burned = ((NSString *)dict[@"burned"]);
    }

    if ([dict[@"expect"] isKindOfClass:[NSNumber class]]) {
        model.pc_expect = ((NSNumber *)dict[@"expect"]).integerValue;
    }

    if ([dict[@"companion"] isKindOfClass:[NSArray class]]) {

        model.pc_companion = [NSArray new];

    }

    
    return model;
}

@end

@interface PC_HomeSmallModel_Gathered ()

@end

@implementation PC_HomeSmallModel_Gathered


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_HomeSmallModel_Gathered *model = [PC_HomeSmallModel_Gathered new];


    if ([dict[@"regulars"] isKindOfClass:[NSString class]]) {
        model.pc_regulars = ((NSString *)dict[@"regulars"]);
    }

    if ([dict[@"fqUrl"] isKindOfClass:[NSString class]]) {
        model.pc_fqUrl = ((NSString *)dict[@"fqUrl"]);
    }

    if ([dict[@"customUrl"] isKindOfClass:[NSString class]]) {
        model.pc_customUrl = ((NSString *)dict[@"customUrl"]);
    }

    if ([dict[@"reunion"] isKindOfClass:[NSString class]]) {
        model.pc_reunion = ((NSString *)dict[@"reunion"]);
    }

    
    return model;
}

@end
