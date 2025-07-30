//
//  OrderView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/30.
//

#import "OrderView.h"
#import "OrderTableViewCell.h"

@interface OrderView ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) OrderListModel *orderModel;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic ,strong) AC_BaseView *cellView;

// 右侧按钮
@property (nonatomic ,strong) AC_BaseButton *applyBtn;

// 中间信息标签
@property (nonatomic, strong) UILabel *loanAmountSubLabel;
@property (nonatomic, strong) UILabel *applicationSubLabel;
@property (nonatomic, strong) UILabel *dateTimeSubLabel;

// 底部协议链接
@property (nonatomic, strong) AC_BaseButton *loanAgreementButton;

@property (nonatomic, strong) AC_BaseView *emptyView;

@end

@implementation OrderView

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
        make.top.equalTo(@0);
        make.bottom.equalTo(@-20);
    }];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestOrderData)];
}

#pragma mark - func

- (void)setOrderStatusType:(NSString *)orderStatusType
{
    _orderStatusType = orderStatusType;
    [self requestOrderData];
}


- (void)setOrderModel:(OrderListModel *)orderModel
{
    _orderModel = orderModel;
    [self.tableView reloadData];
}

- (void)refreshData
{
    [self.tableView.mj_header beginRefreshing];
}

- (void)requestOrderData
{
    __weakSelf;
    [NetMonitorTool.tool postWithPath:@"/before/silhouetted" Parameters:@{@"tweeting":self.orderStatusType} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        __strongSelf;
        if (!responseModel.success) {
            [ProgressHud showMessage:responseModel.pc_flag];
            return;
        }
        self.orderModel = [OrderListModel ACModel_withDict:responseModel.pc_portal];
        self.emptyView.hidden = self.orderModel.pc_inserting.count != 0;
        
        [self.tableView.mj_header endRefreshing];
    } FailBlock:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderModel.pc_inserting.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderTableViewCell.className];
    cell.orderModel = self.orderModel.pc_inserting[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *url = self.orderModel.pc_inserting[indexPath.row].pc_ghostbusters;
    [JumpTool.tool jumpWithStr:url];
    
}

#pragma mark - init

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView new];
        _tableView.autoresizingMask = UIViewAutoresizingNone;
        [_tableView registerClass:OrderTableViewCell.class forCellReuseIdentifier:OrderTableViewCell.className];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (AC_BaseView *)emptyView
{
    if (_emptyView == nil) {
        _emptyView = [AC_BaseView new];
        _emptyView.hidden = true;
        _emptyView.backgroundColor = HEXCOLOR(@"#FFFFFF");
        [_emptyView makeShadowWithColor:[HEXCOLOR(@"#595959") colorWithAlphaComponent:0.09] opacity:8 radius:2 offset:CGSizeZero];
        [_emptyView setCornerRadius :14];
        
        
        ImgViewWithName(order_null, @"order_null");
        [_emptyView addSubview:order_null];
        [order_null mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@149);
            make.centerX.equalTo(@0);
            make.width.equalTo(@102);
            make.height.equalTo(@93);
        }];
        
        UILabel *detaillab = [UILabel LabelWithFont:Regular(16) TextColor:@"#727272" Text:@"There are currently no orders available"];
        detaillab.numberOfLines = 0;
        detaillab.textAlignment = NSTextAlignmentCenter;
        [_emptyView addSubview:detaillab];
        [detaillab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.width.equalTo(@179);
            make.top.equalTo(order_null.mas_bottom).offset(10);
        }];
        
    }
    return _emptyView;
}

@end
