//
//  AC_BaseEffectView.h
//  ACAuotCode
//
//  Created by Acery on 2022/10/28.
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

@interface AC_BaseEffectView : UIVisualEffectView

/// 模糊进度
@property (nonatomic, assign) CGFloat customIntensity;


/// 可调整模糊度的 ``UIVisualEffectView``
/// - Parameters:
///   - effect: 特效样式
///   - intensity: 进度
- (instancetype)initWithEffect:(UIVisualEffect *)effect intensity:(CGFloat)intensity;

/// 快速构造默认的毛玻璃
+ (instancetype)defaultEffectView;

- (void)setUpSubView;

@end

NS_ASSUME_NONNULL_END
