//
//  AC_BaseMsgComfirmView.h
//  ACAutoCode
//
//  Created by Acery on 2024/7/2.
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


#import "AC_BasePresentView.h"
#import "AC_BaseButton.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AC_ComfirmView_DidCancel)(void);
typedef void(^AC_ComfirmView_DidComfirm)(void);

@interface AC_BaseMsgComfirmView : AC_BasePresentView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, copy) AC_ComfirmView_DidComfirm comfirmBlock;

- (UILabel *)titleLabel;
- (UILabel *)contentLabel;
- (UIStackView *)stackView;
- (AC_BaseButton *)comfirmBtn;

@end

NS_ASSUME_NONNULL_END
