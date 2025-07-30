//
//  ContactViewController.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "ContactViewController.h"
#import "ContactModel.h"
#import "ContactTableViewCell.h"

@interface ContactViewController ()

@property (nonatomic ,strong) ContactModel *contactModel;
@property (nonatomic ,strong) AC_BaseButton *nextBtn;

@end

@implementation ContactViewController

- (void)setUpSubView
{
    [super setUpSubView];
   
    ImgViewWithName(topView, @"bj_img");
    topView.userInteractionEnabled = YES;
    [self.view insertSubview:topView atIndex:0];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.equalTo(@98);
    }];
    
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.tableView registerClass:ContactTableViewCell.class forCellReuseIdentifier:ContactTableViewCell.className];
    self.tableView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.equalTo(@18);
        make.right.equalTo(@-18);
    }];
    
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom).offset(24);
        make.left.equalTo(@32);
        make.right.equalTo(@-32);
        make.height.equalTo(@54);
        make.bottom.equalTo(@-26);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
    [PositionTool.tool startReportWithType:RiskPointType_Contacts];
}

- (void)requestData
{
    [ProgressHud showLoading];
    [NetMonitorTool.tool postWithPath:@"/before/virgin" Parameters:@{@"filmmaker":@(self.productID)} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        [ProgressHud hiddenLoading];
        if (!responseModel.success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHud showMessage:responseModel.pc_flag];
            });
            return;
        }
        self.contactModel = [ContactModel ACModel_withDict:responseModel.pc_portal];
        [self.tableView reloadData];
    } FailBlock:^(NSError * _Nonnull error) {
        [ProgressHud hiddenLoading];
    }];
}


- (void)nextPage
{
   
    NSMutableArray *conItems = [NSMutableArray new];
    for (PC_ContactModel_Understand *conItem in self.contactModel.pc_understand) {
        NSDictionary *dict = @{
            @"shoot":conItem.pc_shoot,
            @"viewer":conItem.pc_viewer,
            @"aim":conItem.pc_aim
        };
        [conItems appendObject:dict];
    }
    
    NSString *json =[conItems getJsonStr];
    
    NSDictionary *dict = @{
        @"filmmaker":@(self.productID),
        @"portal":json
    };
    [ProgressHud showLoading];
    // 保存联系人
    [NetMonitorTool.tool postWithPath:@"/before/poster" Parameters:dict SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        [ProgressHud hiddenLoading];
        if (!responseModel.success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHud showMessage:responseModel.pc_flag];
            });
            return;
        }
        [AppAuthTool.tool jumpToNextStepVC];
        [PositionTool.tool endReportWithType:RiskPointType_Contacts];
    } FailBlock:^(NSError * _Nonnull error) {
        [ProgressHud hiddenLoading];
    }];
    
}


#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactModel.pc_understand.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ContactTableViewCell.className forIndexPath:indexPath];
    cell.conModel = self.contactModel.pc_understand[indexPath.row];
    
    return cell;
}

#pragma mark - init

- (AC_BaseButton *)nextBtn
{
    if (_nextBtn == nil) {
        _nextBtn = [AC_BaseButton TextBtnWithTitle:@"Next" titleColor:@"#FFFFFF" font:Semibold(18)];
        [_nextBtn setBackgroundImage:IMAGE(@"next_btn") forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

@end
