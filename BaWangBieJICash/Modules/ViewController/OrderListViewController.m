//
//  OrderListViewController.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "OrderListViewController.h"
#import "CategoryView.h"
#import "OrderView.h"

@interface OrderListViewController ()<JXCategoryViewDelegate>

@property (nonatomic ,strong) UIImageView *bkImg;
@property (nonatomic, strong) CategoryView *categoryView;

@property (nonatomic, assign) NSInteger curListViewIdx;
@property (nonatomic, strong) NSMutableArray <OrderView *> *orderViews;

@end

@implementation OrderListViewController

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.title = @"Order";
    self.vcTitleLabel.font = Regular(18);
    self.vcTitleLabel.textColor = HEXCOLOR(@"#FFFFFF");
    [self.backBtn setBackgroundImage:nil forState:UIControlStateNormal];
    
    [self.view insertSubview:self.bkImg atIndex:0];
    [self.bkImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.view addSubview:self.categoryView];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
        make.top.equalTo(self.navBar.mas_bottom).offset(8);
        make.height.equalTo(@75);
    }];
    
    self.scrollView.pagingEnabled = true;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(@0);
        make.top.equalTo(self.categoryView.mas_bottom).offset(14);
    }];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    OrderView *curOrderView = self.orderViews[self.curListViewIdx];
    [curOrderView refreshData];
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    self.curListViewIdx = index;
    OrderView *curOrderView = self.orderViews[index];
    [curOrderView refreshData];
}


#pragma mark - init

- (CategoryView *)categoryView
{
    if (_categoryView == nil){
        _categoryView = [CategoryView new];
        
        _categoryView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
        _categoryView.titles = @[@"Apply",@"Repayment",@"Finished"];
        _categoryView.delegate = self;
        _categoryView.contentEdgeInsetLeft = 0;
        _categoryView.contentEdgeInsetRight = 0;
        _categoryView.cellWidth = 73;
        
        _categoryView.titleColor = HEXCOLOR(@"#FFFFFF");
        _categoryView.titleSelectedColor = HEXCOLOR(@"#FFFFFF");
        _categoryView.titleFont = Regular(14);
        _categoryView.titleSelectedFont = Medium(14);
        
        _categoryView.contentScrollView = self.scrollView;
        
        JXCategoryIndicatorLineView *indicaView = [[JXCategoryIndicatorLineView alloc] init];
        indicaView.indicatorColor  = HEXCOLOR(@"#FFFFFF");
        indicaView.indicatorHeight = 4.0;
        indicaView.indicatorWidth  = 41.0;
        indicaView.verticalMargin  = 0;
        [indicaView setCornerRadius:2];

        _categoryView.indicators = @[indicaView];
    
        //"tweeting":状态 4=全部订单 7=进行中订单 6=待还款订单 5=已结清订单
        NSArray *types = @[@"7",@"6",@"5"];
        
        __kindof OrderView *lastView = nil;
        for (NSString *title in _categoryView.titles) {
            NSInteger idx = [_categoryView.titles indexOfObject:title];
            
            OrderView *view = [OrderView new];
            view.orderStatusType = types[idx];
            [self.scrollView addSubview:view];
            [self.orderViews addObject:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
               
                if (lastView == nil){
                    make.left.equalTo(@0);
                }else{
                    make.left.equalTo(lastView.mas_right);
                }
                
                make.top.equalTo(@0);
                make.bottom.equalTo(@0);
                make.width.height.equalTo(self.scrollView);
                
                if (idx == _categoryView.titles.count - 1) make.right.equalTo(@0);
                
            }];
            
            lastView = view;
        }
        
    }
    return _categoryView;
}


- (UIImageView *)bkImg
{
    if (_bkImg == nil) {
        _bkImg = [[UIImageView alloc]initWithImage:IMAGE(@"order_bk")];
        _bkImg.userInteractionEnabled = YES;
    }
    return _bkImg;
}

- (NSMutableArray<OrderView *> *)orderViews
{
    if (_orderViews == nil) {
        _orderViews = [NSMutableArray new];
    }
    return _orderViews;
}

@end
