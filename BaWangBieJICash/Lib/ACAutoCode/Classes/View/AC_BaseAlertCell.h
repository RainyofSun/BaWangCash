//
//  AC_BaseAlertCell.h
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


#import "AC_BaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AC_AlertCell_DidClick)(NSString *title);

@interface AC_BaseAlertCell : AC_BaseView

+ (instancetype)alertCellWithTitle:(NSString *)title CliclBlock:(AC_AlertCell_DidClick)clickBlock;

- (UILabel *)titleLabel;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, copy) AC_AlertCell_DidClick clickBlock;

@end

NS_ASSUME_NONNULL_END
