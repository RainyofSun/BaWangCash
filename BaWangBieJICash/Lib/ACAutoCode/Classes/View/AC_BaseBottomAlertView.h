//
//  AC_BaseBottomAlertView.h
//  ACAuotCode
//
//
//  Created by Acery on 2024/5/7.
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
 *  底部的 ``AC_BaseAlertView``
 */

#import "AC_BaseAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AC_BaseBottomAlertView : AC_BaseAlertView

- (AC_BaseButton *)cancelBtn;
- (AC_BaseView *)spacingView;

@end

NS_ASSUME_NONNULL_END
