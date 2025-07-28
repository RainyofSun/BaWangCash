//
//  NSArray+ACAutoCode.m
//  ACAutoCode
//
//  Created by Acery on 2025/2/25.
//

#import "NSArray+ACAutoCode.h"

@implementation NSArray (ACAutoCode)

- (NSString *)getJsonStr
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    if (error != nil)
        return @"";
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
