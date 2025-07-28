//
//  ACThreadOperation.m
//  ThreadPool
//
//  Created by Acery on 2024/8/30.
//

#import "AC_ThreadOp.h"

@implementation AC_ThreadOp

- (void)main
{
    if ([self.task.target respondsToSelector:self.task.action]) {
        [self.task.target performSelector:self.task.action withObject:self.task];
    }
    
}

@end
