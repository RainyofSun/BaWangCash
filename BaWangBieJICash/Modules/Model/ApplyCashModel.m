//
//  ApplyCashModel.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "ApplyCashModel.h"

@implementation ApplyCashModel

+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{
    
    ApplyCashModel *model = [ApplyCashModel new];
    
    if ([dict[@"merely"] isKindOfClass:[NSString class]]) {
        model.pc_merely = ((NSString *)dict[@"merely"]);
    }
    
    return model;
}

@end
