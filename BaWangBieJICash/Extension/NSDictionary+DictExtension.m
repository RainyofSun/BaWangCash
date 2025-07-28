//
//  NSDictionary+DictExtension.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "NSDictionary+DictExtension.h"

@implementation NSDictionary (DictExtension)

- (NSString *)getJsonStr
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    if (error != nil)
        return @"";
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
