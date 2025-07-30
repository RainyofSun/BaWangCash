//
//  HomePageCommentModel.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "HomePageCommentModel.h"

@implementation HomePageCommentModel

+ (instancetype)ACModel_withDict:(NSDictionary *)dict
{

    HomePageCommentModel *model = [HomePageCommentModel new];


    if ([dict[@"gYMxpe"] isKindOfClass:[NSString class]]) {
        model.pc_gYMxpe = ((NSString *)dict[@"gYMxpe"]);
    }

    if ([dict[@"jillette"] isKindOfClass:[NSNumber class]]) {
        model.pc_jillette = ((NSNumber *)dict[@"jillette"]).integerValue;
    }

    if ([dict[@"merely"] isKindOfClass:[NSString class]]) {
        model.pc_merely = ((NSString *)dict[@"merely"]);
    }

    if ([dict[@"penn"] isKindOfClass:[NSString class]]) {
        model.pc_penn = ((NSString *)dict[@"penn"]);
    }

    if ([dict[@"3ns3TzjT"] isKindOfClass:[NSString class]]) {
        model.pc_3ns3TzjT = ((NSString *)dict[@"3ns3TzjT"]);
    }

    if ([dict[@"disposing"] isKindOfClass:[NSNumber class]]) {
        model.pc_disposing = ((NSNumber *)dict[@"disposing"]).integerValue;
    }

    if ([dict[@"qtBrV2fwJ8"] isKindOfClass:[NSString class]]) {
        model.pc_qtBrV2fwJ8 = ((NSString *)dict[@"qtBrV2fwJ8"]);
    }

    if ([dict[@"dl1C7EP62V8"] isKindOfClass:[NSString class]]) {
        model.pc_dl1C7EP62V8 = ((NSString *)dict[@"dl1C7EP62V8"]);
    }

    if ([dict[@"K9qxfYdIVA"] isKindOfClass:[NSNull class]]) {
        model.pc_K9qxfYdIVA = ((NSNull *)dict[@"K9qxfYdIVA"]);
    }

    
    return model;
}

@end
