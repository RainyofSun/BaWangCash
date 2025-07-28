//
//  NSDictionary+ACAutoCode.m
//  ACAutoCode
//
//  Created by Acery on 2025/2/25.
//

#import "NSDictionary+ACAutoCode.h"

@implementation NSDictionary (ACAutoCode)

- (NSString *)getJsonStr
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    if (error != nil)
        return @"";
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
