//
//  UIScrollView+ACAutoCode.m
//  ACAutoCode
//
//  Created by Acery on 2025/3/28.
//

#import "UIScrollView+ACAutoCode.h"

@implementation UIScrollView (ACAutoCode)

- (void)addHeadRefreshWithBlock:(ACAutoCodeHeadRefreshBlock)headRefreshBlock
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (headRefreshBlock != nil) headRefreshBlock();
    }];
    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    self.mj_header = header;
}

- (void)addFootRefreshWithBlock:(ACAutoCodeFootRefreshBlock)footRefreshBlock
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (footRefreshBlock != nil) footRefreshBlock();
    }];

    [footer setTitle:@"Pull up to load more" forState:MJRefreshStateIdle];
    [footer setTitle:@"Release to load more" forState:MJRefreshStatePulling];
    [footer setTitle:@"Loading..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
    self.mj_footer = footer;
}

@end
