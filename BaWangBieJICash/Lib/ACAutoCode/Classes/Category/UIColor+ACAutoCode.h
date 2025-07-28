//
//  UIColor+ACAutoCode.h
//  ACAutoCode
//
//  Created by Acery on 2025/3/17.
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

@interface UIColor (ACAutoCode)


/// 从16进制字符串构建颜色
/// @param hexStr 16进制字符串
/// @param alpha 透明度 [ 0 - 1 ]
+ (UIColor *)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

/// 从16进制字符串构建颜色
/// @param hexStr 16进制字符串
+ (UIColor *)colorWithHexString:(NSString *)hexStr;

@end

NS_ASSUME_NONNULL_END
