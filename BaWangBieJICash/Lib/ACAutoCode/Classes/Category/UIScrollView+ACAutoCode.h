//
//  UIScrollView+ACAutoCode.h
//  ACAutoCode
//
//  Created by Acery on 2025/3/28.
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


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ACAutoCodeHeadRefreshBlock)(void);
typedef void(^ACAutoCodeFootRefreshBlock)(void);

@interface UIScrollView (ACAutoCode)


/// 快速添加下拉刷新
/// - Parameter headRefreshBlock: 刷新回调
- (void)addHeadRefreshWithBlock:(ACAutoCodeHeadRefreshBlock)headRefreshBlock;

/// 快速添加上拉加载更多
/// - Parameter footRefreshBlock: 刷新回调
- (void)addFootRefreshWithBlock:(ACAutoCodeFootRefreshBlock)footRefreshBlock;

@end

NS_ASSUME_NONNULL_END
