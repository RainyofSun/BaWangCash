//
//  AC_FinishOp.m
//  ACAutoCode
//
//  Created by Acery on 2024/9/4.
//

#import "AC_FinishOp.h"

@implementation AC_FinishOp

- (void)main
{
    if (self.finishBlock) self.finishBlock(self);
}

@end
