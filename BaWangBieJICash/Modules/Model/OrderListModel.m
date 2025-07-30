//
//  OrderListModel.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/30.
//

#import "OrderListModel.h"

@implementation OrderListModel

+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    OrderListModel *model = [OrderListModel new];


    if ([dict[@"nH8rfYX2OCD"] isKindOfClass:[NSString class]]) {
        model.pc_nH8rfYX2OCD = ((NSString *)dict[@"nH8rfYX2OCD"]);
    }

    if ([dict[@"inserting"] isKindOfClass:[NSArray class]]) {

        NSMutableArray *inserting_modelArray = [NSMutableArray new];
        for (NSDictionary *sub_dict in (NSArray *)dict[@"inserting"]) {
            if (![sub_dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            PC_OrderListModel_Inserting *sub_model = [PC_OrderListModel_Inserting ACModel_withDict:sub_dict];
            [inserting_modelArray addObject:sub_model];
        }
        model.pc_inserting = inserting_modelArray;
    }
    if ([dict[@"feherty"] isKindOfClass:[NSNumber class]]) {
        model.pc_feherty = ((NSNumber *)dict[@"feherty"]).integerValue;
    }

    if ([dict[@"Y2B44nF"] isKindOfClass:[NSNull class]]) {
        model.pc_Y2B44nF = ((NSNull *)dict[@"Y2B44nF"]);
    }

    
    return model;
}

@end

@interface PC_OrderListModel_Inserting ()

@end

@implementation PC_OrderListModel_Inserting


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_OrderListModel_Inserting *model = [PC_OrderListModel_Inserting new];


    if ([dict[@"culture"] isKindOfClass:[NSString class]]) {
        model.pc_culture = ((NSString *)dict[@"culture"]);
    }

    if ([dict[@"rooster"] isKindOfClass:[NSString class]]) {
        model.pc_rooster = ((NSString *)dict[@"rooster"]);
    }

    if ([dict[@"instruct"] isKindOfClass:[NSString class]]) {
        model.pc_instruct = ((NSString *)dict[@"instruct"]);
    }

    if ([dict[@"vision"] isKindOfClass:[NSString class]]) {
        model.pc_vision = ((NSString *)dict[@"vision"]);
    }

    if ([dict[@"viewing"] isKindOfClass:[NSString class]]) {
        model.pc_viewing = ((NSString *)dict[@"viewing"]);
    }

    if ([dict[@"rightData"] isKindOfClass:[NSDictionary class]]) {
        model.pc_rightData = [PC_OrderListModel_Inserting_Rightdata ACModel_withDict:dict[@"rightData"]];
    }

    if ([dict[@"commentators"] isKindOfClass:[NSString class]]) {
        model.pc_commentators = ((NSString *)dict[@"commentators"]);
    }

    if ([dict[@"calling"] isKindOfClass:[NSNumber class]]) {
        model.pc_calling = ((NSNumber *)dict[@"calling"]).integerValue;
    }

    if ([dict[@"respective"] isKindOfClass:[NSNumber class]]) {
        model.pc_respective = ((NSNumber *)dict[@"respective"]).integerValue;
    }

    if ([dict[@"golfer"] isKindOfClass:[NSString class]]) {
        model.pc_golfer = ((NSString *)dict[@"golfer"]);
    }

    if ([dict[@"stuffed"] isKindOfClass:[NSArray class]]) {

        NSMutableArray *stuffed_modelArray = [NSMutableArray new];
        for (NSDictionary *sub_dict in (NSArray *)dict[@"stuffed"]) {
            if (![sub_dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            PC_OrderListModel_Inserting_Stuffed *sub_model = [PC_OrderListModel_Inserting_Stuffed ACModel_withDict:sub_dict];
            [stuffed_modelArray addObject:sub_model];
        }
        model.pc_stuffed = stuffed_modelArray;
    }
    if ([dict[@"significantly"] isKindOfClass:[NSNumber class]]) {
        model.pc_significantly = ((NSNumber *)dict[@"significantly"]).integerValue;
    }

    if ([dict[@"integrated"] isKindOfClass:[NSString class]]) {
        model.pc_integrated = ((NSString *)dict[@"integrated"]);
    }

    if ([dict[@"commentaries"] isKindOfClass:[NSString class]]) {
        model.pc_commentaries = ((NSString *)dict[@"commentaries"]);
    }

    if ([dict[@"gnome"] isKindOfClass:[NSString class]]) {
        model.pc_gnome = ((NSString *)dict[@"gnome"]);
    }

    if ([dict[@"attempts"] isKindOfClass:[NSString class]]) {
        model.pc_attempts = ((NSString *)dict[@"attempts"]);
    }

    if ([dict[@"men"] isKindOfClass:[NSString class]]) {
        model.pc_men = ((NSString *)dict[@"men"]);
    }

    if ([dict[@"costas"] isKindOfClass:[NSNumber class]]) {
        model.pc_costas = ((NSNumber *)dict[@"costas"]).integerValue;
    }

    if ([dict[@"reviewers"] isKindOfClass:[NSString class]]) {
        model.pc_reviewers = ((NSString *)dict[@"reviewers"]);
    }

    if ([dict[@"seminar"] isKindOfClass:[NSString class]]) {
        model.pc_seminar = ((NSString *)dict[@"seminar"]);
    }

    if ([dict[@"conflicts"] isKindOfClass:[NSString class]]) {
        model.pc_conflicts = ((NSString *)dict[@"conflicts"]);
    }

    if ([dict[@"ghostbusters"] isKindOfClass:[NSString class]]) {
        model.pc_ghostbusters = ((NSString *)dict[@"ghostbusters"]);
    }

    if ([dict[@"statue"] isKindOfClass:[NSNumber class]]) {
        model.pc_statue = ((NSNumber *)dict[@"statue"]).integerValue;
    }

    if ([dict[@"animation"] isKindOfClass:[NSString class]]) {
        model.pc_animation = ((NSString *)dict[@"animation"]);
    }

    if ([dict[@"influenced"] isKindOfClass:[NSNumber class]]) {
        model.pc_influenced = ((NSNumber *)dict[@"influenced"]).integerValue;
    }

    
    return model;
}

@end

@interface PC_OrderListModel_Inserting_Rightdata ()

@end

@implementation PC_OrderListModel_Inserting_Rightdata


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_OrderListModel_Inserting_Rightdata *model = [PC_OrderListModel_Inserting_Rightdata new];


    if ([dict[@"attempts"] isKindOfClass:[NSString class]]) {
        model.pc_attempts = ((NSString *)dict[@"attempts"]);
    }

    if ([dict[@"inserting"] isKindOfClass:[NSArray class]]) {

        NSMutableArray *inserting_modelArray = [NSMutableArray new];
        for (NSDictionary *sub_dict in (NSArray *)dict[@"inserting"]) {
            if (![sub_dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            PC_OrderListModel_Inserting_Rightdata_Inserting *sub_model = [PC_OrderListModel_Inserting_Rightdata_Inserting ACModel_withDict:sub_dict];
            [inserting_modelArray addObject:sub_model];
        }
        model.pc_inserting = inserting_modelArray;
    }
    
    return model;
}

@end

@interface PC_OrderListModel_Inserting_Rightdata_Inserting ()

@end

@implementation PC_OrderListModel_Inserting_Rightdata_Inserting


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_OrderListModel_Inserting_Rightdata_Inserting *model = [PC_OrderListModel_Inserting_Rightdata_Inserting new];


    if ([dict[@"beck"] isKindOfClass:[NSString class]]) {
        model.pc_beck = ((NSString *)dict[@"beck"]);
    }

    if ([dict[@"johnny"] isKindOfClass:[NSString class]]) {
        model.pc_johnny = ((NSString *)dict[@"johnny"]);
    }

    
    return model;
}

@end

@interface PC_OrderListModel_Inserting_Stuffed ()

@end

@implementation PC_OrderListModel_Inserting_Stuffed


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_OrderListModel_Inserting_Stuffed *model = [PC_OrderListModel_Inserting_Stuffed new];


    if ([dict[@"beck"] isKindOfClass:[NSString class]]) {
        model.pc_beck = ((NSString *)dict[@"beck"]);
    }

    if ([dict[@"johnny"] isKindOfClass:[NSString class]]) {
        model.pc_johnny = ((NSString *)dict[@"johnny"]);
    }

    
    return model;
}

@end
