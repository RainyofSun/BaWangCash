//
//  AC_BaseTableHeadView.m
//  ACAuotCode
//
//  Created by Acery on 2024/2/19.
//

#import "AC_BaseTableHeadView.h"

@implementation AC_BaseTableHeadView

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        ((UITableView *)self.superview).tableHeaderView = self;
    });
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kScreenWidth));
    }];
}

@end
