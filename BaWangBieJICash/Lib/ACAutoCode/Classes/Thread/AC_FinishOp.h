//
//  AC_FinishOp.h
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
 * 线程池结束的队列在这个队列执行完毕的时候意味着线程池中的任务都执行完成了
 */

#import "AC_ThreadOp.h"

NS_ASSUME_NONNULL_BEGIN

@class AC_FinishOp;

typedef void(^ACThreadOperation_FinishBlock)(__kindof AC_FinishOp *opt);

@interface AC_FinishOp : AC_ThreadOp

@property (nonatomic, copy) ACThreadOperation_FinishBlock finishBlock;

@end

NS_ASSUME_NONNULL_END
