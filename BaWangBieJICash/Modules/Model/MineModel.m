//
//  MineModel.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "MineModel.h"

@implementation MineModel

+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    MineModel *model = [MineModel new];


    if ([dict[@"YTPM8twD3rX"] isKindOfClass:[NSNumber class]]) {
        model.pc_YTPM8twD3rX = ((NSNumber *)dict[@"YTPM8twD3rX"]).integerValue;
    }

    if ([dict[@"inserting"] isKindOfClass:[NSArray class]]) {

        NSMutableArray *inserting_modelArray = [NSMutableArray new];
        for (NSDictionary *sub_dict in (NSArray *)dict[@"inserting"]) {
            if (![sub_dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            PC_MeModel_Inserting *sub_model = [PC_MeModel_Inserting ACModel_withDict:sub_dict];
            [inserting_modelArray addObject:sub_model];
        }
        model.pc_inserting = inserting_modelArray;
    }
    if ([dict[@"JAWxIq"] isKindOfClass:[NSNull class]]) {
        model.pc_JAWxIq = ((NSNull *)dict[@"JAWxIq"]);
    }

    if ([dict[@"FK72UBDa"] isKindOfClass:[NSString class]]) {
        model.pc_FK72UBDa = ((NSString *)dict[@"FK72UBDa"]);
    }

    if ([dict[@"DCtcXdC1"] isKindOfClass:[NSString class]]) {
        model.pc_DCtcXdC1 = ((NSString *)dict[@"DCtcXdC1"]);
    }

    if ([dict[@"customerService"] isKindOfClass:[NSArray class]]) {

        NSMutableArray *customerService_modelArray = [NSMutableArray new];
        for (NSDictionary *sub_dict in (NSArray *)dict[@"customerService"]) {
            if (![sub_dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            PC_MeModel_Customerservice *sub_model = [PC_MeModel_Customerservice ACModel_withDict:sub_dict];
            [customerService_modelArray addObject:sub_model];
        }
        model.pc_customerService = customerService_modelArray;
    }
    if ([dict[@"ZLVHbVD"] isKindOfClass:[NSString class]]) {
        model.pc_ZLVHbVD = ((NSString *)dict[@"ZLVHbVD"]);
    }

    if ([dict[@"Ea7V"] isKindOfClass:[NSString class]]) {
        model.pc_Ea7V = ((NSString *)dict[@"Ea7V"]);
    }

    if ([dict[@"ikL2mVwgF"] isKindOfClass:[NSNull class]]) {
        model.pc_ikL2mVwgF = ((NSNull *)dict[@"ikL2mVwgF"]);
    }

    if ([dict[@"certStatus"] isKindOfClass:[NSNumber class]]) {
        model.pc_certStatus = ((NSNumber *)dict[@"certStatus"]).integerValue;
    }

    if ([dict[@"TUofoo7"] isKindOfClass:[NSString class]]) {
        model.pc_TUofoo7 = ((NSString *)dict[@"TUofoo7"]);
    }

    if ([dict[@"userInfo"] isKindOfClass:[NSDictionary class]]) {
        model.pc_userInfo = [PC_MeModel_Userinfo ACModel_withDict:dict[@"userInfo"]];
    }

    
    return model;
}

@end

@interface PC_MeModel_Inserting ()

@end

@implementation PC_MeModel_Inserting


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_MeModel_Inserting *model = [PC_MeModel_Inserting new];


    if ([dict[@"gathered"] isKindOfClass:[NSString class]]) {
        model.pc_gathered = ((NSString *)dict[@"gathered"]);
    }

    if ([dict[@"beck"] isKindOfClass:[NSString class]]) {
        model.pc_beck = ((NSString *)dict[@"beck"]);
    }

    if ([dict[@"merely"] isKindOfClass:[NSString class]]) {
        model.pc_merely = ((NSString *)dict[@"merely"]);
    }

    
    return model;
}

@end

@interface PC_MeModel_Customerservice ()

@end

@implementation PC_MeModel_Customerservice


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_MeModel_Customerservice *model = [PC_MeModel_Customerservice new];


    if ([dict[@"merely"] isKindOfClass:[NSString class]]) {
        model.pc_merely = ((NSString *)dict[@"merely"]);
    }

    
    return model;
}

@end

@interface PC_MeModel_Userinfo ()

@end

@implementation PC_MeModel_Userinfo


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_MeModel_Userinfo *model = [PC_MeModel_Userinfo new];


    if ([dict[@"userphone"] isKindOfClass:[NSString class]]) {
        model.pc_userphone = ((NSString *)dict[@"userphone"]);
    }

    if ([dict[@"raging"] isKindOfClass:[NSString class]]) {
        model.pc_raging = ((NSString *)dict[@"raging"]);
    }

    if ([dict[@"isReal"] isKindOfClass:[NSNumber class]]) {
        model.pc_isReal = ((NSNumber *)dict[@"isReal"]).integerValue;
    }

    
    return model;
}

@end
