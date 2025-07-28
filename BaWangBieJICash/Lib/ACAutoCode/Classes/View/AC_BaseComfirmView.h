//
//  AC_BaseComfirmView.h
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
 * 基础的二次确认弹窗
 */

#import "AC_BaseMsgComfirmView.h"
#import "AC_BaseButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface AC_BaseComfirmView : AC_BaseMsgComfirmView

@property (nonatomic, copy) AC_ComfirmView_DidCancel cancelBlock;

- (AC_BaseButton *)cancelBtn;

+ (void)showWithTitle:(NSString *)title
              Content:(NSString *)content
         ComfirmBlock:(void(^)(void))comfirmBlock;

@end

NS_ASSUME_NONNULL_END
