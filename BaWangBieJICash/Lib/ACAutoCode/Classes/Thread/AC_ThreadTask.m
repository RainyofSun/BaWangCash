//
//  ACThreadTask.m
//  ACAESvgaTool
//
//  Created by Acery on 2024/8/30.
//

#import "AC_ThreadTask.h"

@implementation AC_ThreadTask

- (void)addTrget:(NSObject *)target Action:(SEL)action
{
    self.target = target;
    self.action = action;
}

@end
