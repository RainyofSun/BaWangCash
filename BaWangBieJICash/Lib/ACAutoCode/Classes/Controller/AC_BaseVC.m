//
//  AC_BaseVC.m
//  ACAutoCode
//
//  Created by Acery on 2022/7/15.
//

#import "AC_BaseVC.h"
#import "AC_Tool.h"

@interface AC_BaseVC ()

@property (nonatomic, strong) NSDictionary<NSAttributedStringKey, id> * navTitleAttr;

@property(nonatomic, strong) __kindof UITableView *tableView;

@property(nonatomic, strong) __kindof UICollectionView *collectionView;
@property(nonatomic, strong) __kindof UICollectionViewLayout *collectionLayout;

@property (nonatomic, strong) LYEmptyView *emptyView;

@end

@implementation AC_BaseVC

- (instancetype)init
{
    self = [super init];
    if (self != nil){
        self.hidesBottomBarWhenPushed = true;
    }
    return self;
}


#pragma mark - super call

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.whiteColor;
    self.fd_prefersNavigationBarHidden = YES;
    _navStyle = AC_BaseVC_NAVStyle_Other;

    self.currentPage = 1;
    
    [self setUpSubView];
    [self setUpNavView];
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if (![UIViewController.nowWindow.rootViewController isKindOfClass:[UITabBarController class]])return;
    
    // 判断是否显示tabbar
    if (self.tabBarController && self.navigationController.viewControllers.count == 1)
    {
        CGRect new_frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabbarHeight);
        self.view.frame = new_frame;
    }
}

- (void)setUpNavView
{
    [self navBar];
}

- (void)setUpSubView
{
    self.navStyle = AC_BaseVC_NAVStyle_White;
    self.navBar.backgroundColor = UIColor.clearColor;
    self.view.backgroundColor = UIColor.clearColor;
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    self.vcTitleLabel.attributedText = [[NSAttributedString alloc]initWithString:title attributes:self.navTitleAttr];
}

- (NSDictionary<NSAttributedStringKey, id> *)getNavBarTitleAttributWithNavStyle:(AC_BaseVC_NAVStyle)navStyle
{
    
    switch (navStyle) {
        case AC_BaseVC_NAVStyle_White:
            return @{NSForegroundColorAttributeName:UIColor.whiteColor,
                     NSFontAttributeName:[UIFont systemFontOfSize:18]};
            break;
            
        default:
            return @{NSForegroundColorAttributeName:UIColor.blackColor,
                     NSFontAttributeName:[UIFont systemFontOfSize:18]};
            break;
    }
}

- (NSString *)getBackBtnIconWithNavStyle:(AC_BaseVC_NAVStyle)navStyle
{
    switch (navStyle) {
        case AC_BaseVC_NAVStyle_White:
            return @"";
            break;
            
        default:
            return @"";
            break;
    }
}

- (void)dealloc{}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)needsRefreshHeader
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
}

- (void)needsRefreshFooter
{
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}

- (NSDictionary<NSAttributedStringKey,id> *)navTitleAttr
{
    _navTitleAttr = [self getNavBarTitleAttributWithNavStyle:self.navStyle];
    return _navTitleAttr;
}

- (void)setNavStyle:(AC_BaseVC_NAVStyle)navStyle
{
    _navStyle = navStyle;
    
    !self.title?:[self setTitle:self.title];
    [self.backBtn setImage:[UIImage imageNamed:[self getBackBtnIconWithNavStyle:self.navStyle]] forState:UIControlStateNormal];
}

- (__kindof UICollectionView *)makeCollectionView
{
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.collectionLayout];
    collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = false;
    collectionView.backgroundColor = [UIColor clearColor];
    return collectionView;
}

- (__kindof UICollectionViewLayout *)makeCollectionLayout
{
    return [UICollectionViewFlowLayout new];
}

- (__kindof UITableView *)makeTableView
{
    UITableView *tbView = [UITableView new];
    tbView.autoresizingMask = UIViewAutoresizingNone;
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.rowHeight = UITableViewAutomaticDimension;
    tbView.estimatedRowHeight = 50;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tbView;
}

- (__kindof LYEmptyView *)makeEmptyView
{
    LYEmptyView *emptyView = [LYEmptyView emptyViewWithImage:IMAGE(@"") titleStr:@"空空如也~" detailStr:@""];
    emptyView.titleLabTextColor = HEXCOLOR(@"#666666");
    
    return emptyView;
}

#pragma mark - event handel

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)headerRefresh
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)footerRefresh
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - init

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [UIScrollView new];
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _scrollView.showsVerticalScrollIndicator = false;
        _scrollView.showsHorizontalScrollIndicator = false;
        [self.view addSubview:_scrollView];
    }
    
    return _scrollView;
}

- (UIView *)scrollContentView
{
    if (_scrollContentView == nil) {
        _scrollContentView = [UIView new];
        
        [self.scrollView addSubview:_scrollContentView];
        [_scrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
            make.width.equalTo(@(kScreenWidth));
        }];
    }
    
    return _scrollContentView;
}

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

- (__kindof UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [self makeTableView];
        _tableView.ly_emptyView = self.emptyView;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (__kindof UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        _collectionView = [self makeCollectionView];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (__kindof UICollectionViewLayout *)collectionLayout
{
    if(_collectionLayout == nil){
        _collectionLayout = [self makeCollectionLayout];
    }
    
    return _collectionLayout;
}

- (UIButton *)backBtn
{
    if(_backBtn == nil)
    {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:[self getBackBtnIconWithNavStyle:self.navStyle]] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _backBtn;
}

- (UILabel *)vcTitleLabel
{
    if (_vcTitleLabel == nil) {
        _vcTitleLabel = [UILabel new];
        _vcTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _vcTitleLabel;
}

- (UIView *)navBarContent
{
    if (_navBarContent == nil) {
        _navBarContent = [UIView new];
    }
    
    return _navBarContent;
}

- (UIView *)navBar
{
    if (_navBar == nil) {
        _navBar = [UIView new];
        _navBar.hidden = false;
        _navBar.backgroundColor = UIColor.whiteColor;
        [self.view addSubview:_navBar];
        self.fd_prefersNavigationBarHidden = YES;
        [_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(@0);
            make.height.equalTo(@(kNavigationBarHeight));
        }];
        
        [_navBar addSubview:self.navBarContent];
        [self.navBarContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(kStatusBarHeight));
            make.left.right.bottom.equalTo(@0);
        }];
        
        // add back btn
        [self.navBarContent addSubview:self.backBtn];
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@9);
            make.top.equalTo(@8);
            make.bottom.equalTo(@-8);
            make.width.equalTo(self.backBtn.mas_height);
        }];
        
        // add title
        [self.navBarContent addSubview:self.vcTitleLabel];
        [self.vcTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.bottom.equalTo(@0);
        }];
        
        // right item
        UIStackView *stack = [UIStackView new];
        stack.axis = UILayoutConstraintAxisHorizontal;
        stack.distribution = UIStackViewDistributionFillProportionally;
        stack.spacing = 0;
        [self.navBarContent addSubview:stack];
        [stack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-7);
            make.top.bottom.equalTo(@0);
        }];
        _rightItemsView = stack;
    }
    
    return _navBar;
}

- (LYEmptyView *)emptyView
{
    if (_emptyView == nil){
        _emptyView = [self makeEmptyView];
    }
    return _emptyView;
}

@end
