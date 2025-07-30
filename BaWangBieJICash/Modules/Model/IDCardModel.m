//
//  IDCardModel.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "IDCardModel.h"

@implementation IDCardModel

+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    IDCardModel *model = [IDCardModel new];


    if ([dict[@"YEhy3kx"] isKindOfClass:[NSString class]]) {
        model.pc_YEhy3kx = ((NSString *)dict[@"YEhy3kx"]);
    }

    if ([dict[@"DC0eZY"] isKindOfClass:[NSString class]]) {
        model.pc_DC0eZY = ((NSString *)dict[@"DC0eZY"]);
    }

    if ([dict[@"merely"] isKindOfClass:[NSString class]]) {
        model.pc_merely = ((NSString *)dict[@"merely"]);
    }

    if ([dict[@"skinny"] isKindOfClass:[NSString class]]) {
        model.pc_skinny = ((NSString *)dict[@"skinny"]);
    }

    if ([dict[@"raff"] isKindOfClass:[NSString class]]) {
        model.pc_raff = ((NSString *)dict[@"raff"]);
    }

    if ([dict[@"springfield"] isKindOfClass:[NSString class]]) {
        model.pc_springfield = ((NSString *)dict[@"springfield"]);
    }

    if ([dict[@"ZyP4lixc8"] isKindOfClass:[NSString class]]) {
        model.pc_ZyP4lixc8 = ((NSString *)dict[@"ZyP4lixc8"]);
    }

    if ([dict[@"shoot"] isKindOfClass:[NSString class]]) {
        model.pc_shoot = ((NSString *)dict[@"shoot"]);
    }

    if ([dict[@"washington"] isKindOfClass:[NSString class]]) {
        model.pc_washington = ((NSString *)dict[@"washington"]);
    }

    if ([dict[@"flicks"] isKindOfClass:[NSString class]]) {
        model.pc_flicks = ((NSString *)dict[@"flicks"]);
    }

    if ([dict[@"twisted"] isKindOfClass:[NSString class]]) {
        model.pc_twisted = ((NSString *)dict[@"twisted"]);
    }

    if ([dict[@"iowa"] isKindOfClass:[NSString class]]) {
        model.pc_iowa = ((NSString *)dict[@"iowa"]);
    }

    if ([dict[@"theatre"] isKindOfClass:[NSArray class]]) {

        NSMutableArray *theatre_modelArray = [NSMutableArray new];
        for (NSDictionary *sub_dict in (NSArray *)dict[@"theatre"]) {
            if (![sub_dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            PC_IdCardModel_Theatre *sub_model = [PC_IdCardModel_Theatre ACModel_withDict:sub_dict];
            [theatre_modelArray addObject:sub_model];
        }
        model.pc_theatre = theatre_modelArray;
    }
    if ([dict[@"seattle"] isKindOfClass:[NSString class]]) {
        model.pc_seattle = ((NSString *)dict[@"seattle"]);
    }

    if ([dict[@"p1nWGLwZ"] isKindOfClass:[NSNumber class]]) {
        model.pc_p1nWGLwZ = ((NSNumber *)dict[@"p1nWGLwZ"]).integerValue;
    }

    
    return model;
}

@end

@interface PC_IdCardModel_Theatre ()

@end

@implementation PC_IdCardModel_Theatre


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_IdCardModel_Theatre *model = [PC_IdCardModel_Theatre new];


    if ([dict[@"moxie"] isKindOfClass:[NSString class]]) {
        model.pc_moxie = ((NSString *)dict[@"moxie"]);
    }

    if ([dict[@"skinny"] isKindOfClass:[NSString class]]) {
        model.pc_skinny = ((NSString *)dict[@"skinny"]);
    }

    if ([dict[@"snob"] isKindOfClass:[NSString class]]) {
        model.pc_snob = ((NSString *)dict[@"snob"]);
    }

    
    return model;
}

@end
