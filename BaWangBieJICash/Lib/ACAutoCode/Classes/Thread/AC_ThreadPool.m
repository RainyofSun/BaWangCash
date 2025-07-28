//
//  ACThreadPool.m
//  ACAESvgaTool
//
//  Created by Acery on 2024/8/30.
//

#import "AC_ThreadPool.h"
#import "AC_ThreadOp.h"
#import "AC_FinishOp.h"

#include <unistd.h>


@interface AC_ThreadPool ()

@property (nonatomic, strong) NSMutableArray <AC_ThreadTask *> *tasks;

@property (nonatomic, strong) NSOperationQueue *que;

@end

@implementation AC_ThreadPool

+ (instancetype)pool
{
    return [self new];
}

- (void)run
{
    [self addFinishOpt];
}

- (void)addFinishOpt
{
    AC_FinishOp *finishOpt = [AC_FinishOp new];
    __weakSelf;
    finishOpt.finishBlock = ^(__kindof AC_ThreadOp * _Nonnull opt) {
        __strongSelf;
        if (self.allTaskFinishBlock) self.allTaskFinishBlock();
        [self.tasks removeAllObjects];
    };
    
    for (__kindof AC_ThreadOp *opt in self.que.operations) {
        [finishOpt addDependency:opt];
    }
    
    [self.que addOperation:finishOpt];
}

- (void)addTask:(AC_ThreadTask *)task
{
    [self.tasks addObject:task];
    
    AC_ThreadOp *opt = [AC_ThreadOp new];
    opt.task = task;
    opt.pool = self;
    [self.que addOperation:opt];
}

#pragma mark - init

- (NSMutableArray<AC_ThreadTask *> *)tasks
{
    if (_tasks == nil){
        _tasks = [NSMutableArray new];
    }
    return _tasks;
}

- (NSOperationQueue *)que
{
    if (_que == nil) {
        _que = [NSOperationQueue new];
        _que.name = [self.label isExist]?self.label:@"com.aceryThreadPool.queue";
        
        long cpuCoreCount = sysconf(_SC_NPROCESSORS_ONLN);
        if (self.cpuCoreCount <= cpuCoreCount && self.cpuCoreCount != 0) cpuCoreCount = self.cpuCoreCount;
        _que.maxConcurrentOperationCount = cpuCoreCount;
        
    }
    return _que;
}

@end
