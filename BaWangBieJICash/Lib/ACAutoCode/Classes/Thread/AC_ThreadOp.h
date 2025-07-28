//
//  ACThreadOperation.h
//  ACAutoCode
//
//  Created by Acery on 2024/7/11.
//
//
//       ,---,
//      '  .' \
//     /  ;    '.                          __  ,-.
//    :  :       \                       ,' ,'/ /|
//    :  |   /\   \     ,---.     ,---.  '  | |' |   .--,
//    |  :  ' ;.   :   /     \   /     \ |  |   ,' /_ ./|
//    |  |  ;/  \   \ /    / '  /    /  |'  :  /, ' , ' :
//    '  :  | \  \ ,'.    ' /  .    ' / ||  | '/___/ \: |
//    |  |  '  '--'  '   ; :__ '   ;   /|;  : | .  \  ' |
//    |  :  :        '   | '.'|'   |  / ||  , ;  \  ;   :
//    |  | ,'        |   :    :|   :    | ---'    \  \  ;
//    `--''           \   \  /  \   \  /           :  \  \
//                     `----'    `----'             \  ' ;
//                                                   `--`


/**
 * 线程池任务队列的基类
 */

#import <Foundation/Foundation.h>
#import "AC_ThreadTask.h"

NS_ASSUME_NONNULL_BEGIN

@class AC_ThreadPool;

@interface AC_ThreadOp : NSOperation

/// 对应的任务模型
@property (nonatomic, strong) AC_ThreadTask *task;

/// 对应的线程池
@property (nonatomic, weak) AC_ThreadPool *pool;

@end

NS_ASSUME_NONNULL_END
