//
//  HomePageModel.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "HomePageModel.h"

@implementation HomePageModel

+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    HomePageModel *model = [HomePageModel new];


    if ([dict[@"DCkz"] isKindOfClass:[NSString class]]) {
        model.pc_DCkz = ((NSString *)dict[@"DCkz"]);
    }

    if ([dict[@"D8dU0w8lp32Q"] isKindOfClass:[NSNull class]]) {
        model.pc_D8dU0w8lp32Q = ((NSNull *)dict[@"D8dU0w8lp32Q"]);
    }

    if ([dict[@"gnSgfiR"] isKindOfClass:[NSString class]]) {
        model.pc_gnSgfiR = ((NSString *)dict[@"gnSgfiR"]);
    }

    if ([dict[@"isPopLw"] isKindOfClass:[NSNumber class]]) {
        model.pc_isPopLw = ((NSNumber *)dict[@"isPopLw"]).integerValue;
    }

    if ([dict[@"arrested"] isKindOfClass:[NSArray class]]) {
        model.pc_arrested = ((NSArray<NSString *>*)dict[@"arrested"]);
    }

    if ([dict[@"isReyNotice"] isKindOfClass:[NSNumber class]]) {
        model.pc_isReyNotice = ((NSNumber *)dict[@"isReyNotice"]).integerValue;
    }

    if ([dict[@"isReyNoticeMsg"] isKindOfClass:[NSString class]]) {
        model.pc_isReyNoticeMsg = ((NSString *)dict[@"isReyNoticeMsg"]);
    }

    if ([dict[@"inserting"] isKindOfClass:[NSArray class]]) {

        NSMutableArray *inserting_modelArray = [NSMutableArray new];
        for (NSDictionary *sub_dict in (NSArray *)dict[@"inserting"]) {
            if (![sub_dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            PC_HomeModel_Inserting *sub_model = [PC_HomeModel_Inserting ACModel_withDict:sub_dict];
            [inserting_modelArray addObject:sub_model];
        }
        model.pc_inserting = inserting_modelArray;
    }
    if ([dict[@"isAuh"] isKindOfClass:[NSNumber class]]) {
        model.pc_isAuh = ((NSNumber *)dict[@"isAuh"]).integerValue;
    }

    if ([dict[@"privacyAgreement"] isKindOfClass:[NSString class]]) {
        model.pc_privacyAgreement = ((NSString *)dict[@"privacyAgreement"]);
    }

    if ([dict[@"gathered"] isKindOfClass:[NSDictionary class]]) {
        model.pc_gathered = [PC_HomeModel_Gathered ACModel_withDict:dict[@"gathered"]];
    }

    
    return model;
}

@end

@interface PC_HomeModel_Inserting ()

@end

@implementation PC_HomeModel_Inserting


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_HomeModel_Inserting *model = [PC_HomeModel_Inserting new];


    if ([dict[@"disposing"] isKindOfClass:[NSString class]]) {
        model.pc_disposing = ((NSString *)dict[@"disposing"]);
    }

    if ([dict[@"consists"] isKindOfClass:[NSArray class]]) {

        NSMutableArray *consists_modelArray = [NSMutableArray new];
        for (NSDictionary *sub_dict in (NSArray *)dict[@"consists"]) {
            if (![sub_dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            PC_HomeModel_Inserting_Consists *sub_model = [PC_HomeModel_Inserting_Consists ACModel_withDict:sub_dict];
            [consists_modelArray addObject:sub_model];
        }
        model.pc_consists = consists_modelArray;
    }
    
    return model;
}

@end

@interface PC_HomeModel_Inserting_Consists ()

@end

@implementation PC_HomeModel_Inserting_Consists


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_HomeModel_Inserting_Consists *model = [PC_HomeModel_Inserting_Consists new];


    if ([dict[@"longer"] isKindOfClass:[NSString class]]) {
        model.pc_longer = ((NSString *)dict[@"longer"]);
    }

    if ([dict[@"consumers"] isKindOfClass:[NSNumber class]]) {
        model.pc_consumers = ((NSNumber *)dict[@"consumers"]).integerValue;
    }

    if ([dict[@"seminar"] isKindOfClass:[NSString class]]) {
        model.pc_seminar = ((NSString *)dict[@"seminar"]);
    }

    if ([dict[@"boxed"] isKindOfClass:[NSString class]]) {
        model.pc_boxed = ((NSString *)dict[@"boxed"]);
    }

    if ([dict[@"megalon"] isKindOfClass:[NSString class]]) {
        model.pc_megalon = ((NSString *)dict[@"megalon"]);
    }

    if ([dict[@"instruct"] isKindOfClass:[NSString class]]) {
        model.pc_instruct = ((NSString *)dict[@"instruct"]);
    }

    if ([dict[@"conflicts"] isKindOfClass:[NSString class]]) {
        model.pc_conflicts = ((NSString *)dict[@"conflicts"]);
    }

    if ([dict[@"godzilla"] isKindOfClass:[NSString class]]) {
        model.pc_godzilla = ((NSString *)dict[@"godzilla"]);
    }

    if ([dict[@"collection"] isKindOfClass:[NSString class]]) {
        model.pc_collection = ((NSString *)dict[@"collection"]);
    }

    if ([dict[@"threeDes"] isKindOfClass:[NSString class]]) {
        model.pc_threeDes = ((NSString *)dict[@"threeDes"]);
    }

    if ([dict[@"gila"] isKindOfClass:[NSString class]]) {
        model.pc_gila = ((NSString *)dict[@"gila"]);
    }

    
    return model;
}

@end

@interface PC_HomeModel_Gathered ()

@end

@implementation PC_HomeModel_Gathered


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_HomeModel_Gathered *model = [PC_HomeModel_Gathered new];


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
