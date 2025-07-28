//
//  BaseNetResponseModel.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "BaseNetResponseModel.h"

@implementation BaseNetResponseModel

+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    BaseNetResponseModel *model = [BaseNetResponseModel new];


    if ([dict[@"snob"] isKindOfClass:[NSString class]]) {
        model.pc_snob = ((NSString *)dict[@"snob"]);
    }

    if ([dict[@"flag"] isKindOfClass:[NSString class]]) {
        model.pc_flag = ((NSString *)dict[@"flag"]);
    }
    
    if (![dict[@"portal"] isKindOfClass:[NSNull class]]) {
        model.pc_portal = dict[@"portal"];
    }
    
    model.modelDict = dict;
    
    return model;
}

- (bool)success
{
    if ([self.pc_snob isEqualToString:@"0"]) return true;
    return false;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\n提示\t:%@\n状态\t:%@\n数据\t:\n%@", self.pc_flag,self.pc_snob,[((NSDictionary *)self.pc_portal) getJsonStr]];
}

@end
