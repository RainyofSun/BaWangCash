//
//  ACThreadPool.h
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


#import <Foundation/Foundation.h>

#import "AC_ThreadTask.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ACThreadPool_AllTaskFinishBlock)(void);

@interface AC_ThreadPool : NSObject

@property (nonatomic, strong) ACThreadPool_AllTaskFinishBlock allTaskFinishBlock;

@property (nonatomic, copy) NSString *label;

@property (nonatomic, assign) NSInteger cpuCoreCount;

+ (instancetype)pool;

- (void)addTask:(AC_ThreadTask *)task;

- (void)run;


@end

NS_ASSUME_NONNULL_END
