//
//  PersonalViewController.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "PersonalViewController.h"
#import "PersonalInfoModel.h"
#import "PersonalTableViewCell.h"

@interface PersonalViewController ()

@property (nonatomic ,strong) PersonalInfoModel *userInfoModel;
@property (nonatomic ,strong) AC_BaseButton *nextBtn;

@end

@implementation PersonalViewController

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
    [self.tableView registerClass:PersonalTableViewCell.class forCellReuseIdentifier:PersonalTableViewCell.className];
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
    /*
     '"bc":"enum"',
     '"bc":"txt"',
     '"bc":"citySelect"',
     混淆后
     '"bc":"similarlylikea"',
     '"bc":"similarlylikeb"',
     '"bc":"similarlylikec"',
     */

    [PositionTool.tool startReportWithType:RiskPointType_PersonalInfo];
    [ProgressHud showLoading];
    [NetMonitorTool.tool postWithPath:@"/before/disney" Parameters:@{@"filmmaker":@(self.productID)} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        [ProgressHud hiddenLoading];
        if (!responseModel.success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHud showMessage:responseModel.pc_flag];
            });
            return;
        }
        self.userInfoModel = [PersonalInfoModel ACModel_withDict:responseModel.pc_portal];
        [self.tableView reloadData];
    } FailBlock:^(NSError * _Nonnull error) {
        [ProgressHud hiddenLoading];
    }];
    
}

- (void)nextPage
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    // 遍历数组中的每个对象
    for (PC_UserInfoModel_Counterclockwise *model in self.userInfoModel.pc_counterclockwise) {
        // 直接访问属性 pc_snob
        NSString *key = model.pc_snob;
        NSString *value = model.pc_announcements;
        [dict setValue:value forKey:key];
    }
    [dict setValue:@(self.productID) forKey:@"filmmaker"];
    
//    NSDictionary *dict = @{
//            @"coleman":@(1),
//            @"reels":@(1),
//            @"vogt":@"example@gmail.com",
//            @"dare":@(1),
//            @"use_of_funds":@(1),
//            @"home_address":@"Address Details",
//            @"home_phone":@"Home Phone",
//            @"numerous":@(1),
//            @"popular":@(1),
//            @"filmmaker":@(self.productID)
//        };
    [ProgressHud showLoading];
    // 保存用户信息
    [NetMonitorTool.tool postWithPath:@"/before/happy" Parameters:dict SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        [ProgressHud hiddenLoading];
        if (!responseModel.success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHud showMessage:responseModel.pc_flag];
            });
            return;
        }
        [PositionTool.tool endReportWithType:RiskPointType_PersonalInfo];
        
        [AppAuthTool.tool jumpToNextStepVC];
    } FailBlock:^(NSError * _Nonnull error) {
        [ProgressHud hiddenLoading];
    }];

}

#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userInfoModel.pc_counterclockwise.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PersonalTableViewCell.className forIndexPath:indexPath];
    cell.userModel = self.userInfoModel.pc_counterclockwise[indexPath.row];
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
