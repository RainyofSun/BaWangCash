//
//  JobViewController.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "JobViewController.h"
#import "JobInfoModel.h"
#import "JobInfoTableViewCell.h"

@interface JobViewController ()

@property (nonatomic ,strong) JobInfoModel *jobModel;

@property (nonatomic ,strong) AC_BaseButton *nextBtn;

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation JobViewController

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
    
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.tableView registerClass:JobInfoTableViewCell.class forCellReuseIdentifier:JobInfoTableViewCell.className];
    self.tableView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(4);
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
    [PositionTool.tool startReportWithType:RiskPointType_WorkInfo];
    [ProgressHud showLoading];
    [NetMonitorTool.tool postWithPath:@"/before/classically" Parameters:@{@"filmmaker":@(self.productID)} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        [ProgressHud hiddenLoading];
        if (!responseModel.success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHud showMessage:responseModel.pc_flag];
            });
            return;
        }
        self.jobModel = [JobInfoModel ACModel_withDict:responseModel.pc_portal];
        
        [self.tableView reloadData];
    } FailBlock:^(NSError * _Nonnull error) {
        [ProgressHud hiddenLoading];
    }];
    
}

- (void)setJobModel:(JobInfoModel *)jobModel
{
    _jobModel = jobModel;
    
}


- (void)nextPage
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    // 遍历数组中的每个对象
    for (PC_JobInfoModel_Counterclockwise *model in self.jobModel.pc_counterclockwise) {
        // 直接访问属性 pc_snob
        NSString *key = model.pc_snob;
        NSString *value = model.pc_announcements;
        [dict setValue:value forKey:key];
    }
    [dict setValue:@(self.productID) forKey:@"filmmaker"];
    
    
//    NSDictionary *dict = @{
//            @"georgia":@"Company Name",
//            @"company_city":@"Company Address",
//            @"atlanta":@"9123456789",
//            @"profession":@(1),
//            @"working_years":@(1),
//            @"performances":@"400",//Monthly Income
//            @"austin":@"Address Details",
//            @"public":@(1),
//            @"groups":@(1),
//            @"techniques":@(1),
//            @"filmmaker":@(self.productID)
//        };
    
    [ProgressHud showLoading];
    // 保存用户信息
    [NetMonitorTool.tool postWithPath:@"/before/dump" Parameters:dict SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        
        [ProgressHud hiddenLoading];
        if (!responseModel.success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHud showMessage:responseModel.pc_flag];
            });
            return;
        }
        
        [PositionTool.tool endReportWithType:RiskPointType_WorkInfo];
        [AppAuthTool.tool jumpToNextStepVC];
        } FailBlock:^(NSError * _Nonnull error) {
            [ProgressHud hiddenLoading];
        }];
    
    
}


#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.jobModel.pc_counterclockwise.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JobInfoTableViewCell.className forIndexPath:indexPath];
    cell.jobModel = self.jobModel.pc_counterclockwise[indexPath.row];
    self.selectedIndex = indexPath.row;
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
