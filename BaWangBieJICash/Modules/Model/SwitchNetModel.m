//
//  SwitchNetModel.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "SwitchNetModel.h"

@implementation SwitchNetModel

+ (instancetype)ModelWithDict:(NSDictionary *)dict
{

    SwitchNetModel *model = [SwitchNetModel new];


   if ([dict[@"pc"] isKindOfClass:[NSString class]]) {
       model.pc = ((NSString *)dict[@"pc"]);
   }

   
   return model;
}

@end
