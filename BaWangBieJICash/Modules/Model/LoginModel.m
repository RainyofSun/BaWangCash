//
//  LoginModel.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "LoginModel.h"

#define LoginModel_DiskSaveKey @"LoginModel_DiskSaveKey"

@implementation LoginModel

+  (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    LoginModel *model = [LoginModel new];


    if ([dict[@"wrCKuW"] isKindOfClass:[NSNumber class]]) {
        model.pc_wrCKuW = ((NSNumber *)dict[@"wrCKuW"]).integerValue;
    }

    if ([dict[@"cgU89"] isKindOfClass:[NSNull class]]) {
        model.pc_cgU89 = ((NSNull *)dict[@"cgU89"]);
    }

    if ([dict[@"a2geOPoGMGA"] isKindOfClass:[NSString class]]) {
        model.pc_a2geOPoGMGA = ((NSString *)dict[@"a2geOPoGMGA"]);
    }

    if ([dict[@"Ozkjc94QBfZc"] isKindOfClass:[NSString class]]) {
        model.pc_Ozkjc94QBfZc = ((NSString *)dict[@"Ozkjc94QBfZc"]);
    }

    if ([dict[@"uid"] isKindOfClass:[NSNumber class]]) {
        model.pc_uid = ((NSNumber *)dict[@"uid"]).integerValue;
    }

    if ([dict[@"isOld"] isKindOfClass:[NSNumber class]]) {
        model.pc_isOld = ((NSNumber *)dict[@"isOld"]).integerValue;
    }

    if ([dict[@"raging"] isKindOfClass:[NSString class]]) {
        model.pc_raging = ((NSString *)dict[@"raging"]);
    }

    if ([dict[@"silhouetted"] isKindOfClass:[NSString class]]) {
        model.pc_silhouetted = ((NSString *)dict[@"silhouetted"]);
    }

    if ([dict[@"jBzlJ"] isKindOfClass:[NSString class]]) {
        model.pc_jBzlJ = ((NSString *)dict[@"jBzlJ"]);
    }

    if ([dict[@"1FR8rAfxW6"] isKindOfClass:[NSNull class]]) {
        model.pc_1FR8rAfxW6 = ((NSNull *)dict[@"1FR8rAfxW6"]);
    }

    if ([dict[@"quite"] isKindOfClass:[NSString class]]) {
        model.pc_quite = ((NSString *)dict[@"quite"]);
    }

    model.modelDict = dict;
    
    return model;
}

- (void)saveToDisk
{
    [self.modelDict removeNullValue];
    [UserDefaultsObj setValue:self.modelDict forKey:LoginModel_DiskSaveKey];
    [UserDefaultsObj synchronize];
}

+ (void)removeFromDisk
{
    [UserDefaultsObj setValue:nil forKey:LoginModel_DiskSaveKey];
    [UserDefaultsObj synchronize];
}

+ (instancetype)readFromDisk
{
    NSDictionary *loginInfoDict = [UserDefaultsObj valueForKey:LoginModel_DiskSaveKey];
    if (loginInfoDict == nil) {
        return  nil;
    }else{
        return [self ACModel_withDict:loginInfoDict];
    }
}

@end
