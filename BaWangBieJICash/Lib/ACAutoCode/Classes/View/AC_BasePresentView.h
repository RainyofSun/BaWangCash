//
//  AC_BasePresentView.h
//  ACAuotCode
//
//  Created by Acery on 2022/8/4.
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


#import "AC_BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AC_BasePresentView : AC_BaseView

/// content view
@property(nonatomic, strong ,readonly) __kindof AC_BaseView *contentView;

/// 是否被弹出
@property (nonatomic, assign, readonly) bool isShow;

/// 是否支持点击弹窗外关闭
@property (nonatomic, assign) bool canOutsideClose;

/// 重写这个函数来自定义 ``contentView``
- (__kindof AC_BaseView *)makeContentView;

- (void)showInView:(__kindof UIView *)showInView;
- (void)show;

- (void)disMiss;

@end

NS_ASSUME_NONNULL_END
