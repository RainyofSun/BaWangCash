//
//  NT_BaseAlertView.h
//  ACAuotCode
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
 * 未制定``AlertView``的位置，如果需要使用在底部的``AlertView``，可以使用``AC_BaseBottomAlertView``
 */

#import "AC_BasePresentView.h"
#import "AC_BaseAlertCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface AC_BaseAlertView : AC_BasePresentView

/// `alertCell`的栈视图容器
- (UIStackView *)alertStackView;

/// 添加 `alertCell`
/// - Parameter alertCell: alertCell
- (void)addAlertCell:(__kindof AC_BaseAlertCell *)alertCell;

@end

NS_ASSUME_NONNULL_END
