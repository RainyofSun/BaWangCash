//
//  AC_BaseTabVC.m
//  ACAutoCode
//
//  Created by Acery on 2024/10/16.
//

#import "AC_BaseTabVC.h"

@interface AC_BaseTabVC ()

/// tabbar
@property(nonatomic, strong) AC_BaseTabBar *tabbar;
@property (nonatomic, strong) NSMutableArray <__kindof UIView *> *barItems;

@end

@implementation AC_BaseTabVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpSubView];
    
    [self setValue:self.tabbar forKeyPath:@"tabBar"];
}

- (void)setUpSubView
{
    [self setUpTabItems];
    [self setUpNavcs];
}

- (void)setUpTabItems{}
- (void)setUpNavcs{}

#pragma mark - AC_BaseTabBarDelegate

- (NSInteger)ATD_IndexofTabBar:(AC_BaseTabBar *)tabBar
{
    return self.barItems.count;
}

- (__kindof UIView *)ATD_ItemContentOfIndex:(NSInteger)index TabBar:(AC_BaseTabBar *)tabBar
{
    return self.barItems[index];
}

- (void)ATD_ClickAtItemAtIndex:(NSInteger)index TabBar:(AC_BaseTabBar *)tabBar
{
    if (index >= self.viewControllers.count) return;
    
    UIViewController *vc = self.viewControllers[index];
    if (vc != nil)self.selectedViewController = vc;
}

#pragma mark - Init

- (AC_BaseTabBar *)tabbar
{
    if (_tabbar == nil) {
        _tabbar = [[AC_BaseTabBar alloc]initWithTabbarController:self];
        _tabbar.ATdelegate = self;
    }
    return _tabbar;
}

- (NSMutableArray<__kindof UIView *> *)barItems
{
    if (_barItems == nil){
        _barItems = [NSMutableArray new];
    }
    return _barItems;
}

@end
