//
//  ACThreadTask.h
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
 * 线程池任务的基类
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AC_ThreadTask : NSObject

/// 任务的参数
@property (nonatomic, strong) NSObject *userInfo;

/// 执行任务的对象
@property (nonatomic, weak) NSObject *target;

/// 执行任务的方法，参数返回当前的任务`AC_ThreadTask`
@property (nonatomic, assign) SEL action;

- (void)addTrget:(NSObject *)target Action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
