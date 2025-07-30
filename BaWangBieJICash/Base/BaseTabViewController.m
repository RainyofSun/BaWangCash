//
//  BaseTabViewController.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "BaseTabViewController.h"
#import "HomePageViewController.h"
#import "OrderListViewController.h"
#import "MineViewController.h"
#import "LoginPresent.h"
#import "LoginLogic.h"

@interface BaseTabViewController ()

@property (nonatomic, weak) TabBarItem *lastSelectBarItem;

@end

@implementation BaseTabViewController

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.tabBar.backgroundColor = [UIColor greenColor];
}

- (void)setUpTabItems
{
    NSArray *datas = @[@{@"normalImg":@"tab_home_n",@"selectImg":@"tab_home_select"},
                       @{@"normalImg":@"tab_order_n",@"selectImg":@"tab_order_select"},
                       @{@"normalImg":@"tab_me_n",@"selectImg":@"tab_me_select"}];
    
    for (NSDictionary *dict in datas) {
        
        PC_TabBarModel *model = [PC_TabBarModel new];
        model.normalImgName = dict[@"normalImg"];
        model.selectImgName = dict[@"selectImg"];
        
        TabBarItem *item = [TabBarItem new];
        item.model = model;
        [self.barItems addObject:item];
    }
}

- (void)setUpNavcs
{
    for (NSInteger idx = 0; idx < self.barItems.count; idx++) {
        switch (idx) {
            case 0:{
                HomePageViewController *vc = [HomePageViewController new];
                vc.hidesBottomBarWhenPushed = false;
                AC_BaseNaVC *navc = [[AC_BaseNaVC alloc]initWithRootViewController:vc];
                [self addChildViewController:navc];
            }
                break;
                
            case 1:{
                OrderListViewController *vc = [OrderListViewController new];
                vc.hidesBottomBarWhenPushed = false;
                AC_BaseNaVC *navc = [[AC_BaseNaVC alloc]initWithRootViewController:vc];
                [self addChildViewController:navc];
            }
                break;
                
            case 2:{
                MineViewController *vc = [MineViewController new];
                vc.hidesBottomBarWhenPushed = false;
                AC_BaseNaVC *navc = [[AC_BaseNaVC alloc]initWithRootViewController:vc];
                [self addChildViewController:navc];
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    
    __kindof UIViewController *vc = [self.childViewControllers objectAtIndex:selectedIndex];
    self.selectedViewController = vc;
}


- (void)setSelectedViewController:(__kindof UIViewController *)selectedViewController
{
    [super setSelectedViewController:selectedViewController];
    NSInteger idx = [self.childViewControllers indexOfObject:selectedViewController];
    
    self.lastSelectBarItem.model.select = false;
    self.lastSelectBarItem.model = self.lastSelectBarItem.model;
    
    TabBarItem *cuurentItem = (TabBarItem *)self.barItems[idx];
    cuurentItem.model.select = true;
    cuurentItem.model = cuurentItem.model;
    
    self.lastSelectBarItem = cuurentItem;
}

- (void)ATD_ClickAtItemAtIndex:(NSInteger)index TabBar:(AC_BaseTabBar *)tabBar
{
    if (index >= self.viewControllers.count) return;
    if (!LoginLogic.tool.isLogin) {
        LoginPresent *view = [LoginPresent new];
        [view show];
    }else {
        UIViewController *vc = self.viewControllers[index];
        if (vc != nil)self.selectedViewController = vc;
    }
   
}


@end

@implementation PC_TabBarModel

@end

@implementation TabBarItem

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@28);
        make.centerX.equalTo(@0);
        make.top.equalTo(@14);
    }];
    
}

- (void)setModel:(PC_TabBarModel *)model
{
    _model = model;
    
    if (model.select) {
        self.imgView.image = IMAGE(model.selectImgName);
    } else {
        self.imgView.image = IMAGE(model.normalImgName);
    }
}

- (UIImageView *)imgView
{
    if(_imgView == nil) {
        _imgView = [UIImageView new];
    }
    return _imgView;
}

@end
