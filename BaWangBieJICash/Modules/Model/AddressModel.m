//
//  AddressModel.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "AddressModel.h"

@implementation AddressModel

+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    AddressModel *model = [AddressModel new];


    if ([dict[@"TfRqAduB"] isKindOfClass:[NSString class]]) {
        model.pc_TfRqAduB = ((NSString *)dict[@"TfRqAduB"]);
    }

    if ([dict[@"gic3dy"] isKindOfClass:[NSString class]]) {
        model.pc_gic3dy = ((NSString *)dict[@"gic3dy"]);
    }

    if ([dict[@"NYbS"] isKindOfClass:[NSString class]]) {
        model.pc_NYbS = ((NSString *)dict[@"NYbS"]);
    }

    if ([dict[@"XxtSuKJVH"] isKindOfClass:[NSNull class]]) {
        model.pc_XxtSuKJVH = ((NSNull *)dict[@"XxtSuKJVH"]);
    }

    if ([dict[@"pFkK"] isKindOfClass:[NSNumber class]]) {
        model.pc_pFkK = ((NSNumber *)dict[@"pFkK"]).integerValue;
    }

    if ([dict[@"Z0AZ"] isKindOfClass:[NSString class]]) {
        model.pc_Z0AZ = ((NSString *)dict[@"Z0AZ"]);
    }

    if ([dict[@"soujifLtbw"] isKindOfClass:[NSString class]]) {
        model.pc_soujifLtbw = ((NSString *)dict[@"soujifLtbw"]);
    }

    if ([dict[@"KQrK"] isKindOfClass:[NSString class]]) {
        model.pc_KQrK = ((NSString *)dict[@"KQrK"]);
    }

    if ([dict[@"7mueKTZJbUv"] isKindOfClass:[NSNull class]]) {
        model.pc_7mueKTZJbUv = ((NSNull *)dict[@"7mueKTZJbUv"]);
    }

    if ([dict[@"inserting"] isKindOfClass:[NSArray class]]) {

        NSMutableArray *inserting_modelArray = [NSMutableArray new];
        for (NSDictionary *sub_dict in (NSArray *)dict[@"inserting"]) {
            if (![sub_dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            PC_AdressModel_Inserting *sub_model = [PC_AdressModel_Inserting ACModel_withDict:sub_dict];
            [inserting_modelArray addObject:sub_model];
        }
        model.pc_inserting = inserting_modelArray;
    }
    
    return model;
}

@end

@interface PC_AdressModel_Inserting ()

@end

@implementation PC_AdressModel_Inserting


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_AdressModel_Inserting *model = [PC_AdressModel_Inserting new];


    if ([dict[@"consumers"] isKindOfClass:[NSNumber class]]) {
        model.pc_consumers = ((NSNumber *)dict[@"consumers"]).integerValue;
    }

    if ([dict[@"shoot"] isKindOfClass:[NSString class]]) {
        model.pc_shoot = ((NSString *)dict[@"shoot"]);
    }

    if ([dict[@"inserting"] isKindOfClass:[NSArray class]]) {

        NSMutableArray *inserting_modelArray = [NSMutableArray new];
        for (NSDictionary *sub_dict in (NSArray *)dict[@"inserting"]) {
            if (![sub_dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            PC_AdressModel_Inserting *sub_model = [PC_AdressModel_Inserting ACModel_withDict:sub_dict];
            [inserting_modelArray addObject:sub_model];
        }
        model.pc_inserting = inserting_modelArray;
    }
    
    return model;
}

@end
