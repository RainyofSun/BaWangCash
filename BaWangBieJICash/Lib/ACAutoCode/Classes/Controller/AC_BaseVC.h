//
//  NT_BaseVC.h
//  ACAutoCode
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
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>

@class LYEmptyView;

typedef void(^AC_BaseVC_CallBack)(NSDictionary * _Nonnull info);

typedef NS_OPTIONS(NSUInteger, AC_BaseVC_NAVStyle) {
    AC_BaseVC_NAVStyle_White             = 1 << 0,   // 白色的样式
    AC_BaseVC_NAVStyle_Black             = 1 << 1,   // 黑色的样式
    AC_BaseVC_NAVStyle_Other             = 1 << 2,   // 自定义的样式
};

NS_ASSUME_NONNULL_BEGIN

@interface AC_BaseVC : UIViewController
<UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDataSource,
UICollectionViewDelegate>

#pragma mark - content view

/// scroll view
@property(nonatomic, strong) UIScrollView *scrollView;

/// scroll content view
@property(nonatomic, strong) UIView *scrollContentView;

// table view
- (__kindof UITableView *)tableView;
- (__kindof UITableView *)makeTableView;

/// collection view
- (__kindof UICollectionView *)collectionView;

/// 子类重写自定义 ``UICollectionView`` 类型
- (__kindof UICollectionView *)makeCollectionView;

/// collection flowLayout
- (__kindof UICollectionViewLayout *)collectionLayout;
- (__kindof UICollectionViewLayout *)makeCollectionLayout;

/// tableView 或者 collectionView 在没数据时显示的提示视图
- (__kindof LYEmptyView *)makeEmptyView;

/// 初始化子视图 子类实现
- (void)setUpSubView;

#pragma mark - nav bar

/// 导航栏类型
@property (nonatomic, assign) AC_BaseVC_NAVStyle navStyle;

/// nav bar
@property(nonatomic, strong) UIView *navBar;

/// vc title
@property(nonatomic, strong) UILabel *vcTitleLabel;

/// nav bar content
@property(nonatomic, strong) UIView *navBarContent;

/// back-btn
@property(nonatomic, strong) UIButton *backBtn;

/// 右边按钮的父视图,所有的按钮需要添加到这个视图中
@property(nonatomic, strong, readonly) UIStackView *rightItemsView;

/// 自定义导航栏标题样式 子类可以继承
/// - Parameter navStyle: 导航栏样式
- (NSDictionary<NSAttributedStringKey, id> *)getNavBarTitleAttributWithNavStyle:(AC_BaseVC_NAVStyle)navStyle;

/// 自定义返回图标 子类可以继承
/// - Parameter navStyle: 导航栏样式
- (NSString *)getBackBtnIconWithNavStyle:(AC_BaseVC_NAVStyle)navStyle;

/// 为导航栏添加其他视图的方法,需要调用 super
- (void)setUpNavView;

/// 退出控制器
- (void)backBtnClick;

#pragma mark - refresh

// 数据模型数组
@property (nonatomic, strong) NSMutableArray *dataArr;

// 当前分页页数
@property (nonatomic, assign) NSInteger currentPage;

// 注册刷新
- (void)needsRefreshHeader;
- (void)needsRefreshFooter;

// 调用父类方法以结束刷新动画
- (void)headerRefresh;
- (void)footerRefresh;

#pragma mark - callback

/// 逆传回调
@property(nonatomic, copy) AC_BaseVC_CallBack vcCallBack;

@end

NS_ASSUME_NONNULL_END
