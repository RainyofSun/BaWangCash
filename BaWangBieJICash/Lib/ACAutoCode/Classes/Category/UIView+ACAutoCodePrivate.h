//
//  UIView+ACAutoCodePrivate.h
//  ACAutoCode
//
//  Created by Acery on 2024/10/20.
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

@interface UIView (ACAutoCodePrivate)

- (void)makeCornerRadius:(CGFloat)cornerRadius rectCorner:(UIRectCorner)rectCorner;

- (void)setPartCornerRadius:(CGFloat)partCornerRadius;
- (CGFloat)partCornerRadius;

- (void)setPartCornerType:(UIRectCorner)partCornerType;
- (UIRectCorner)partCornerType;

- (void)setNeedPartCorner:(bool)needPartCorner;
- (bool)needPartCorner;
@end

NS_ASSUME_NONNULL_END
