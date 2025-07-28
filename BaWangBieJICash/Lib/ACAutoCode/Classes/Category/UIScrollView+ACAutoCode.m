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
    self.mj_header = header;
}

- (void)addFootRefreshWithBlock:(ACAutoCodeFootRefreshBlock)footRefreshBlock
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (footRefreshBlock != nil) footRefreshBlock();
    }];
    self.mj_footer = footer;
}

@end
