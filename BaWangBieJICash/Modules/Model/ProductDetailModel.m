//
//  ProductDetailModel.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "ProductDetailModel.h"

@implementation ProductDetailModel

+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    ProductDetailModel *model = [ProductDetailModel new];


    if ([dict[@"userInfo"] isKindOfClass:[NSDictionary class]]) {
        model.pc_userInfo = [PC_ProduceDetailModel_Userinfo ACModel_withDict:dict[@"userInfo"]];
    }
    
    if ([dict[@"options"] isKindOfClass:[NSDictionary class]]) {
        model.pc_options = [PC_ProduceDetailModel_Options ACModel_withDict:dict[@"options"]];
    }
    
    if ([dict[@"Nw5c9z"] isKindOfClass:[NSNull class]]) {
        model.pc_Nw5c9z = ((NSNull *)dict[@"Nw5c9z"]);
    }

    if ([dict[@"UCA8"] isKindOfClass:[NSString class]]) {
        model.pc_UCA8 = ((NSString *)dict[@"UCA8"]);
    }

    if ([dict[@"cKWFH9Ss"] isKindOfClass:[NSNumber class]]) {
        model.pc_cKWFH9Ss = ((NSNumber *)dict[@"cKWFH9Ss"]).integerValue;
    }

    if ([dict[@"jillette"] isKindOfClass:[NSNumber class]]) {
        model.pc_jillette = ((NSNumber *)dict[@"jillette"]).integerValue;
    }

    if ([dict[@"gore"] isKindOfClass:[NSDictionary class]]) {
        model.pc_gore = [PC_ProduceDetailModel_Gore ACModel_withDict:dict[@"gore"]];
    }

    if ([dict[@"V6a00TKu7E"] isKindOfClass:[NSString class]]) {
        model.pc_V6a00TKu7E = ((NSString *)dict[@"V6a00TKu7E"]);
    }

    if ([dict[@"kVcF"] isKindOfClass:[NSString class]]) {
        model.pc_kVcF = ((NSString *)dict[@"kVcF"]);
    }

    if ([dict[@"6FMAtit"] isKindOfClass:[NSString class]]) {
        model.pc_6FMAtit = ((NSString *)dict[@"6FMAtit"]);
    }

    if ([dict[@"postal"] isKindOfClass:[NSDictionary class]]) {
        model.pc_postal = [PC_ProduceDetailModel_Postal ACModel_withDict:dict[@"postal"]];
    }

    if ([dict[@"rec"] isKindOfClass:[NSArray class]]) {

        NSMutableArray *rec_modelArray = [NSMutableArray new];
        for (NSDictionary *sub_dict in (NSArray *)dict[@"rec"]) {
            if (![sub_dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            PC_ProduceDetailModel_Rec *sub_model = [PC_ProduceDetailModel_Rec ACModel_withDict:sub_dict];
            [rec_modelArray addObject:sub_model];
        }
        model.pc_rec = rec_modelArray;
    }
    if ([dict[@"5jDJ1goG9I"] isKindOfClass:[NSString class]]) {
        model.pc_5jDJ1goG9I = ((NSString *)dict[@"5jDJ1goG9I"]);
    }

    if ([dict[@"1ihqr"] isKindOfClass:[NSString class]]) {
        model.pc_1ihqr = ((NSString *)dict[@"1ihqr"]);
    }

    
    return model;
}

@end

@interface PC_ProduceDetailModel_Userinfo ()

@end

@implementation PC_ProduceDetailModel_Userinfo


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_ProduceDetailModel_Userinfo *model = [PC_ProduceDetailModel_Userinfo new];


    if ([dict[@"bender"] isKindOfClass:[NSString class]]) {
        model.pc_bender = ((NSString *)dict[@"bender"]);
    }

    if ([dict[@"shoot"] isKindOfClass:[NSNull class]]) {
        model.pc_shoot = ((NSNull *)dict[@"shoot"]);
    }

    if ([dict[@"idNumber"] isKindOfClass:[NSNull class]]) {
        model.pc_idNumber = ((NSNull *)dict[@"idNumber"]);
    }

    
    return model;
}

@end

@interface PC_ProduceDetailModel_Gore ()

@end

@implementation PC_ProduceDetailModel_Gore


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_ProduceDetailModel_Gore *model = [PC_ProduceDetailModel_Gore new];


    if ([dict[@"merely"] isKindOfClass:[NSString class]]) {
        model.pc_merely = ((NSString *)dict[@"merely"]);
    }

    if ([dict[@"instruct"] isKindOfClass:[NSString class]]) {
        model.pc_instruct = ((NSString *)dict[@"instruct"]);
    }

    if ([dict[@"consumers"] isKindOfClass:[NSString class]]) {
        model.pc_consumers = ((NSString *)dict[@"consumers"]);
    }

    if ([dict[@"conflicts"] isKindOfClass:[NSString class]]) {
        model.pc_conflicts = ((NSString *)dict[@"conflicts"]);
    }

    if ([dict[@"far"] isKindOfClass:[NSDictionary class]]) {
        model.pc_far = [PC_ProduceDetailModel_Gore_Far ACModel_withDict:dict[@"far"]];
    }

    if ([dict[@"electric"] isKindOfClass:[NSString class]]) {
        model.pc_electric = ((NSString *)dict[@"electric"]);
    }

    if ([dict[@"death"] isKindOfClass:[NSArray class]]) {
        model.pc_death = ((NSArray<NSString *>*)dict[@"death"]);
    }

    if ([dict[@"funniest"] isKindOfClass:[NSString class]]) {
        model.pc_funniest = ((NSString *)dict[@"funniest"]);
    }

    if ([dict[@"calling"] isKindOfClass:[NSNumber class]]) {
        model.pc_calling = ((NSNumber *)dict[@"calling"]).integerValue;
    }

    if ([dict[@"thing"] isKindOfClass:[NSString class]]) {
        model.pc_thing = ((NSString *)dict[@"thing"]);
    }

    if ([dict[@"computer"] isKindOfClass:[NSNumber class]]) {
        model.pc_computer = ((NSNumber *)dict[@"computer"]).integerValue;
    }

    if ([dict[@"culture"] isKindOfClass:[NSString class]]) {
        model.pc_culture = ((NSString *)dict[@"culture"]);
    }

    if ([dict[@"attempts"] isKindOfClass:[NSString class]]) {
        model.pc_attempts = ((NSString *)dict[@"attempts"]);
    }

    if ([dict[@"mistings"] isKindOfClass:[NSDictionary class]]) {
        model.pc_mistings = [PC_ProduceDetailModel_Gore_Mistings ACModel_withDict:dict[@"mistings"]];
    }

    if ([dict[@"track"] isKindOfClass:[NSNumber class]]) {
        model.pc_track = ((NSNumber *)dict[@"track"]).integerValue;
    }

    if ([dict[@"misc"] isKindOfClass:[NSString class]]) {
        model.pc_misc = ((NSString *)dict[@"misc"]);
    }

    if ([dict[@"al"] isKindOfClass:[NSArray class]]) {
        model.pc_al = ((NSArray<NSNumber *>*)dict[@"al"]);
    }

    if ([dict[@"fucking"] isKindOfClass:[NSString class]]) {
        model.pc_fucking = ((NSString *)dict[@"fucking"]);
    }

    if ([dict[@"seminar"] isKindOfClass:[NSString class]]) {
        model.pc_seminar = ((NSString *)dict[@"seminar"]);
    }

    
    return model;
}

@end

@interface PC_ProduceDetailModel_Gore_Far ()

@end

@implementation PC_ProduceDetailModel_Gore_Far


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_ProduceDetailModel_Gore_Far *model = [PC_ProduceDetailModel_Gore_Far new];


    if ([dict[@"zappa"] isKindOfClass:[NSDictionary class]]) {
        model.pc_zappa = [PC_ProduceDetailModel_Gore_Far_Zappa ACModel_withDict:dict[@"zappa"]];
    }

    if ([dict[@"expressed"] isKindOfClass:[NSDictionary class]]) {
        model.pc_expressed = [PC_ProduceDetailModel_Gore_Far_Expressed ACModel_withDict:dict[@"expressed"]];
    }

    
    return model;
}

@end

@interface PC_ProduceDetailModel_Gore_Far_Zappa ()

@end

@implementation PC_ProduceDetailModel_Gore_Far_Zappa


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_ProduceDetailModel_Gore_Far_Zappa *model = [PC_ProduceDetailModel_Gore_Far_Zappa new];


    if ([dict[@"beck"] isKindOfClass:[NSString class]]) {
        model.pc_beck = ((NSString *)dict[@"beck"]);
    }

    if ([dict[@"earliest"] isKindOfClass:[NSString class]]) {
        model.pc_earliest = ((NSString *)dict[@"earliest"]);
    }

    
    return model;
}

@end

@interface PC_ProduceDetailModel_Gore_Far_Expressed ()

@end

@implementation PC_ProduceDetailModel_Gore_Far_Expressed


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_ProduceDetailModel_Gore_Far_Expressed *model = [PC_ProduceDetailModel_Gore_Far_Expressed new];


    if ([dict[@"beck"] isKindOfClass:[NSString class]]) {
        model.pc_beck = ((NSString *)dict[@"beck"]);
    }

    if ([dict[@"earliest"] isKindOfClass:[NSString class]]) {
        model.pc_earliest = ((NSString *)dict[@"earliest"]);
    }

    
    return model;
}

@end

@interface PC_ProduceDetailModel_Gore_Mistings ()

@end

@implementation PC_ProduceDetailModel_Gore_Mistings


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_ProduceDetailModel_Gore_Mistings *model = [PC_ProduceDetailModel_Gore_Mistings new];


    if ([dict[@"announcements"] isKindOfClass:[NSString class]]) {
        model.pc_announcements = ((NSString *)dict[@"announcements"]);
    }

    
    return model;
}

@end

@interface PC_ProduceDetailModel_Postal ()

@end

@implementation PC_ProduceDetailModel_Postal


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_ProduceDetailModel_Postal *model = [PC_ProduceDetailModel_Postal new];


    if ([dict[@"beck"] isKindOfClass:[NSString class]]) {
        model.pc_beck = ((NSString *)dict[@"beck"]);
    }

    if ([dict[@"merely"] isKindOfClass:[NSString class]]) {
        model.pc_merely = ((NSString *)dict[@"merely"]);
    }

    if ([dict[@"receiving"] isKindOfClass:[NSString class]]) {
        model.pc_receiving = ((NSString *)dict[@"receiving"]);
    }

    if ([dict[@"disposing"] isKindOfClass:[NSNumber class]]) {
        model.pc_disposing = ((NSNumber *)dict[@"disposing"]).integerValue;
    }

    
    return model;
}

@end

@interface PC_ProduceDetailModel_Options ()

@end

@implementation PC_ProduceDetailModel_Options


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_ProduceDetailModel_Options *model = [PC_ProduceDetailModel_Options new];


    if ([dict[@"beck"] isKindOfClass:[NSString class]]) {
        model.pc_beck = ((NSString *)dict[@"beck"]);
    }

    if ([dict[@"thrive"] isKindOfClass:[NSString class]]) {
        model.pc_thrive = ((NSString *)dict[@"thrive"]);
    }

    return model;
}

@end

@interface PC_ProduceDetailModel_Rec ()

@end

@implementation PC_ProduceDetailModel_Rec


+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    PC_ProduceDetailModel_Rec *model = [PC_ProduceDetailModel_Rec new];


    if ([dict[@"merely"] isKindOfClass:[NSString class]]) {
        model.pc_merely = ((NSString *)dict[@"merely"]);
    }

    if ([dict[@"usenet"] isKindOfClass:[NSNumber class]]) {
        model.pc_usenet = ((NSNumber *)dict[@"usenet"]).integerValue;
    }

    if ([dict[@"newsgroups"] isKindOfClass:[NSString class]]) {
        model.pc_newsgroups = ((NSString *)dict[@"newsgroups"]);
    }

    if ([dict[@"peak"] isKindOfClass:[NSNumber class]]) {
        model.pc_peak = ((NSNumber *)dict[@"peak"]).integerValue;
    }

    if ([dict[@"encouraged"] isKindOfClass:[NSNumber class]]) {
        model.pc_encouraged = ((NSNumber *)dict[@"encouraged"]).integerValue;
    }

    if ([dict[@"disposing"] isKindOfClass:[NSNumber class]]) {
        model.pc_disposing = ((NSNumber *)dict[@"disposing"]).integerValue;
    }

    if ([dict[@"receiving"] isKindOfClass:[NSString class]]) {
        model.pc_receiving = ((NSString *)dict[@"receiving"]);
    }

    if ([dict[@"closed"] isKindOfClass:[NSString class]]) {
        model.pc_closed = ((NSString *)dict[@"closed"]);
    }

    if ([dict[@"drawings"] isKindOfClass:[NSString class]]) {
        model.pc_drawings = ((NSString *)dict[@"drawings"]);
    }

    if ([dict[@"beck"] isKindOfClass:[NSString class]]) {
        model.pc_beck = ((NSString *)dict[@"beck"]);
    }

    if ([dict[@"refer"] isKindOfClass:[NSString class]]) {
        model.pc_refer = ((NSString *)dict[@"refer"]);
    }

    
    return model;
}

@end
