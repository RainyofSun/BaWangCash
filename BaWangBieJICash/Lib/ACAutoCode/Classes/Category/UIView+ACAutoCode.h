//
//  UIView+ACAutoCode.h
//  ACAutoCode
//
//  Created by Acery on 2024/10/15.
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

@interface UIView (ACAutoCode)

/// 设置圆角
- (void)setCornerRadius:(CGFloat)cornerRadius;
- (void)setCornerRadius:(CGFloat)cornerRadius rectCorner:(UIRectCorner)rectCorner;

/// 添加触摸手势
- (UITapGestureRecognizer *)addTarget:(id)target action:(SEL)action;

#pragma mark - Shadow

/// 添加阴影
/// - Parameters:
///   - color: 阴影颜色
///   - opacity: 阴影透明度
///   - radius: 阴影半径
///   - offset: 阴影偏移
- (void)makeShadowWithColor:(UIColor *)color
                    opacity:(CGFloat)opacity
                     radius:(CGFloat)radius
                     offset:(CGSize)offset;

@end

NS_ASSUME_NONNULL_END
