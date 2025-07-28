//
//  AC_BaseTabVC.h
//  ACAutoCode
//
//  Created by Acery on 2024/10/16.
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

#import "AC_BaseTabBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface AC_BaseTabVC : UITabBarController <AC_BaseTabBarDelegate>

- (AC_BaseTabBar *)tabbar;
- (NSMutableArray<__kindof UIView *> *)barItems;

- (void)setUpSubView;

- (void)setUpTabItems;
- (void)setUpNavcs;

@end

NS_ASSUME_NONNULL_END
