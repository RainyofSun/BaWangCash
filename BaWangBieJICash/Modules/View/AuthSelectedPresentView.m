//
//  AuthSelectedPresentView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "AuthSelectedPresentView.h"
#import "AuthSelectedTableViewCell.h"
#import "UserIdentifiInfoModel.h"
#import "AppAuthTool.h"
#import "AppAuthTool+ID.h"

// 新增行高定义
#define DEFAULT_ROW_HEIGHT 42
#define SELECTED_ROW_HEIGHT 50

@interface AuthSelectedPresentView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,strong) UserIdentifiInfoModel *userInfoModel;

@property (copy, nonatomic) NSString *selectedTitle; // 存储选中的标题

@end

@implementation AuthSelectedPresentView

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28);
        make.right.equalTo(@-28);
        make.top.equalTo(@153);
    }];
    [self.stackView removeFromSuperview];
    
    ImgViewWithName(contentbk, @"auth_present_bk");
    contentbk.userInteractionEnabled = YES;
    [self.contentView addSubview:contentbk];
    [contentbk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    UILabel *lab = [UILabel LabelWithFont:Semibold(17) TextColor:@"#000000" Text:@"Authentication"];
    [contentbk addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@17);
        make.centerX.equalTo(@0);
        make.top.equalTo(@24);
    }];
    
    UILabel *detaillab = [UILabel LabelWithFont:Semibold(13) TextColor:@"#41DE18" Text:@"Select an id to verify your identity"];
    detaillab.numberOfLines = 0;
    detaillab.textAlignment = NSTextAlignmentCenter;
    [contentbk addSubview:detaillab];
    [detaillab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@17);
        make.centerX.equalTo(@0);
        make.top.equalTo(lab.mas_bottom).offset(10);
    }];
    
    [contentbk addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@296);
        make.left.right.equalTo(@0);
        make.top.equalTo(detaillab.mas_bottom).offset(16);
    }];
    
    [self.tableView registerClass:[AuthSelectedTableViewCell class] forCellReuseIdentifier:AuthSelectedTableViewCell.className];
    
    [contentbk addSubview:self.comfirmBtn];
    [self.comfirmBtn setTitle:@"Next" forState:UIControlStateNormal];
    [self.comfirmBtn addTarget:self action:@selector(comfirmCilck) forControlEvents:UIControlEventTouchUpInside];
    [self.comfirmBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.height.equalTo(@52);
        make.top.equalTo(self.tableView.mas_bottom).offset(20);
        make.right.equalTo(@-24);
        make.bottom.equalTo(@-16);
    }];
    
    
    [PositionTool.tool startReportWithType:RiskPointType_IDCard];
    
    // 获取用户身份信息 认证
    __weakSelf;
    [AppAuthTool.tool getUserIDModelWithBlock:^(UserIdentifiInfoModel * _Nullable model) {
        __strongSelf;
        if (model == nil) return;
        self.userInfoModel = model;
    }];
}

- (void)comfirmCilck
{
    if (self.items.count == 0) return;
    [self disMiss];
    
    if (self.selectedIndex < self.items.count) {
        self.selectedTitle = self.items[self.selectedIndex];
    }
    if (self.disMissBlock) self.disMissBlock(self.selectedTitle);
    [PositionTool.tool endReportWithType:RiskPointType_IDCard];
}

- (void)disMiss
{
    [super disMiss];
    
}

- (void)setUserInfoModel:(UserIdentifiInfoModel *)userInfoModel
{
    _userInfoModel = userInfoModel;
    NSArray *type = [userInfoModel.pc_edmonton arrayByAddingObjectsFromArray:userInfoModel.pc_garneau];
    self.items = type;
    [self.tableView reloadData];
}


#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AuthSelectedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AuthSelectedTableViewCell.className];
    if (!cell) {
        cell = [[AuthSelectedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AuthSelectedTableViewCell.className];
        cell.backgroundColor = UIColor.clearColor;
        cell.contentView.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = self.items[indexPath.row];
    cell.textLabel.textColor = HEXCOLOR(@"#13253B");
    cell.textLabel.font = Regular(14);
    cell.layer.cornerRadius = 0;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
    
    // 选中状态样式
    if (indexPath.row == self.selectedIndex) {
        cell.backgroundColor = HEXCOLOR(@"#4497F5");
        cell.textLabel.textColor = HEXCOLOR(@"#FFFFFF");
        cell.textLabel.font = Semibold(16);
    } else {
        cell.backgroundColor = UIColor.clearColor;
        cell.textLabel.textColor = HEXCOLOR(@"#13253B");
        cell.textLabel.font = Regular(14);
    }
    
    return cell;
}


#pragma mark - 新增行高控制方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.row == self.selectedIndex) ? SELECTED_ROW_HEIGHT : DEFAULT_ROW_HEIGHT;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger previousIndex = self.selectedIndex;
   
    self.selectedIndex = indexPath.row;
    
    // 创建需要刷新的indexPaths数组
    NSMutableArray *indexPaths = [NSMutableArray array];
    if (previousIndex != NSNotFound) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:previousIndex inSection:0]];
    }
    [indexPaths addObject:indexPath];
    
    // 带有动画的局部刷新
    [tableView beginUpdates];
    [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView endUpdates];
    
    // 自动滚动到选中位置（可选）
    [tableView scrollToRowAtIndexPath:indexPath
                     atScrollPosition:UITableViewScrollPositionMiddle
                             animated:YES];

}

#pragma mark - init

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView new];
        _tableView.autoresizingMask = UIViewAutoresizingNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSArray *)items
{
    if (_items == nil) {
        _items = [NSArray new];
    }
    return _items;
}

- (NSString *)selectedTitle
{
    if (_selectedTitle == nil) {
        _selectedTitle = [[NSString alloc]init];
    }
    return _selectedTitle;
}

@end
