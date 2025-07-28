//
//  AC_BaseTabBar.h
//  ACAuotCode
//
//  Created by Acery on 2023/4/26.
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

/*
 * 2023.1.24 更新，加入item数量和控制器数量不匹配的需求，在点击item 询问外界是否存在控制器'ATD_IsItemWithAnControllerAtIndex'，
 * 如果不存在直接将点击事件外抛'ATD_ClickAtNoControllerItemAtIndex'
 *+----------------------------
 *|---TabBar
 *|-----|ShadowView
 *|-----------|ContentView
 *|----------------|TabItem1
 *|----------------|TabItem2
 *+----------------------------
 */


@class AC_BaseTabBar;

@protocol AC_BaseTabBarDelegate <NSObject>

@required

/// 返回 item 的个数
/// @param tabBar tabBar
- (NSInteger)ATD_IndexofTabBar:(AC_BaseTabBar *)tabBar;

/// 返回 item 的内容视图
/// @param index 当前 item 的索引
/// @param tabBar tabBar
- (__kindof UIView *)ATD_ItemContentOfIndex:(NSInteger)index TabBar:(AC_BaseTabBar *)tabBar;

// -------- 异形 item 代理
// 在需要使用异形 item 时需要实现部分代理，否则完全不用实现，且只允许同时存在一个异形 item
@optional

/// 指定异形 item 的索引
/// @param index 当前 item 的索引
/// @param tabBar tabBar
- (bool)ATD_IsNormalItemWithIndex:(NSInteger)index TabBar:(AC_BaseTabBar *)tabBar;

/// 指定异形 item 超出普通 item 的距离
/// 判断点击事件
/// @param tabBar tabBar
- (CGFloat)ATD_SpecialItemTopSpacingWithTabBar:(AC_BaseTabBar *)tabBar;

/// 返回特殊 item 的宽度
/// @param index 当前的 item 索引
/// @param tabBar tabBar
- (CGFloat)ATD_ItemContentWidthOfIndex:(NSInteger)index TabBar:(AC_BaseTabBar *)tabBar;

/// 为所有的 item 内容视图添加约束或者布局
/// @param contentView item 内容视图
/// @param index 当前的 item 索引
/// @param tabBar tabBar
- (void)ATD_LayoutItemContent:(__kindof UIView *)contentView Index:(NSInteger)index TabBar:(AC_BaseTabBar *)tabBar;

/// 布局 tabbar 的占位视图
/// @param contentView tabbar 的占位视图
/// @param tabBar tabBar
- (void)ATD_LayoutContent:(__kindof UIView *)contentView TabBar:(AC_BaseTabBar *)tabBar;

/// 布局 tabbar 的占位视图
/// @param shadowView tabbar 的阴影视图
/// @param tabBar tabBar
- (void)ATD_LayoutShadow:(__kindof UIView *)shadowView TabBar:(AC_BaseTabBar *)tabBar;

/// 当点击了一个不含有控制器的item
/// @param index 当前的索引
/// @param tabBar tabBar
- (void)ATD_ClickAtItemAtIndex:(NSInteger)index TabBar:(AC_BaseTabBar *)tabBar;

@end

@interface AC_BaseTabBar : UITabBar

- (instancetype)initWithCoder NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithFrame NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithTabbarController:(__kindof UITabBarController *)tabbarController;

/// delegate
@property(nonatomic, weak) id <AC_BaseTabBarDelegate> ATdelegate;

- (UIView *)contentView;
- (UIView *)shadowView;

- (void)setUpSubView;

- (void)setCuurentIndex:(NSInteger)cuurentIndex;

@end

NS_ASSUME_NONNULL_END
