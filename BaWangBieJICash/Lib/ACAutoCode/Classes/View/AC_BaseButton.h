//
//  AC_BaseButton.h
//  ACAuotCode
//
//  Created by Acery on 2022/7/15.
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

typedef NS_OPTIONS(NSUInteger, AC_LayoutButtonType) {
    AC_LayoutButtonTypeTop
};

@interface AC_BaseButton : UIButton

/// 自定义的数据
@property (nonatomic, strong) NSString *userInfo;

- (void)setWebImage:(NSString *)imageURL forState:(UIControlState)state;
- (void)setBackgroundWebImage:(NSString *)imageURL forState:(UIControlState)state;

@end

@interface AC_BaseGradientButton : AC_BaseButton

/// colos
@property(nonatomic, nullable, copy) NSArray *colors;

/// locations
@property(nonatomic, nullable, copy) NSArray<NSNumber *> *locations;

@property(nonatomic, assign) CGPoint startPoint;
@property(nonatomic, assign) CGPoint endPoint;

@end

@interface AC_LayoutButton : AC_BaseButton

/// layout type
@property(nonatomic, assign) AC_LayoutButtonType layoutType;

@end

NS_ASSUME_NONNULL_END
