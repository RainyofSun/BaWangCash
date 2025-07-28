//
//  NSObject+ACAutoCode.m
//  ACAutoCode
//
//  Created by Acery on 2025/3/13.
//

#import "NSObject+ACAutoCode.h"

@implementation NSObject (ACAutoCode)

- (NSString *)className
{
    return [self.class className];
}

+ (NSString *)className
{
    return NSStringFromClass(self);
}

@end
