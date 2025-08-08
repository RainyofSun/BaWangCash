//
//  MineViewController.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"

@interface MineViewController ()

@property (nonatomic ,strong) UIImageView *bkImg;

@property (nonatomic ,strong) UILabel *accountNumLab;
@property (nonatomic ,strong) UILabel *topDetailLab;

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UILabel *leftLab;
@property (nonatomic, strong) UILabel *rightLab;
@property (nonatomic, strong) UIImageView *bannerImgView;

@property (nonatomic ,strong) AC_BaseView *aboutView;
@property (nonatomic ,strong) AC_BaseView *onlineView;
@property (nonatomic ,strong) AC_BaseView *feeedBackView;
@property (nonatomic ,strong) AC_BaseView *privacyView;
@property (nonatomic ,strong) AC_BaseView *settingsView;

@property (nonatomic ,strong) MineModel *meModel;
@property (nonatomic, strong) NSMutableArray<PC_MeModel_Inserting *> *mineData;
@property (nonatomic, copy) NSString *leftUrl;
@property (nonatomic, copy) NSString *rightUrl;

@end

@implementation MineViewController

- (void)setUpSubView
{
    [super setUpSubView];

    [self.view addSubview:self.bkImg];
    [self.bkImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    ImgViewWithName(icon, @"me_head");
    icon.userInteractionEnabled = YES;
    [self.bkImg addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28);
        make.top.mas_equalTo(self.bkImg).mas_offset(kNavigationBarHeight);
        make.height.width.equalTo(@90);
    }];
    
    
    [self.bkImg addSubview:self.accountNumLab];
    [self.accountNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(10);
        make.top.equalTo(icon.mas_top).offset(19);
        make.height.equalTo(@28);
    }];
    
    UILabel *detailLab = [UILabel LabelWithFont:Regular(14) TextColor:@"#000000" Text:@"Welcome to my small world"];
    [self.bkImg addSubview:detailLab];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accountNumLab.mas_left);
        make.top.equalTo(self.accountNumLab.mas_bottom).offset(4);
        make.height.equalTo(@20);
    }];
    
    self.leftImageView.hidden = YES;
    self.leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_service"]];
    self.leftLab = [[UILabel alloc] initWithFrame:CGRectZero];
    self.leftLab.textColor = [UIColor colorWithHexString:@"#212121"];
    self.leftLab.font = ShuHeiTi(16);
    self.leftLab.numberOfLines = 2;
    [self.leftImageView addTarget:self action:@selector(leftJump)];
    
    self.rightImageView.hidden = YES;
    self.rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_about"]];
    self.rightLab = [[UILabel alloc] initWithFrame:CGRectZero];
    self.rightLab.textColor = [UIColor colorWithHexString:@"#333333"];
    self.rightLab.font = ShuHeiTi(16);
    self.rightLab.numberOfLines = 2;
    [self.rightImageView addTarget:self action:@selector(rightJump)];
    
    [self.bkImg addSubview:self.leftImageView];
    [self.leftImageView addSubview:self.leftLab];
    [self.bkImg addSubview:self.rightImageView];
    [self.rightImageView addSubview:self.rightLab];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bkImg).offset(13);
        make.top.mas_equalTo(icon.mas_bottom).offset(55);
        make.height.mas_equalTo((kScreenWidth - 36) * 0.23);
    }];
    
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftImageView);
        make.left.mas_equalTo(self.leftImageView).offset(20);
        make.width.mas_lessThanOrEqualTo(70);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.centerY.mas_equalTo(self.leftImageView);
        make.left.mas_equalTo(self.leftImageView.mas_right).offset(10);
        make.right.mas_equalTo(self.bkImg).offset(-13);
    }];
    
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftLab);
        make.left.mas_equalTo(self.rightImageView).offset(20);
        make.width.mas_lessThanOrEqualTo(70);
    }];
    
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.tableView registerClass:MineTableViewCell.class forCellReuseIdentifier:MineTableViewCell.className];
    self.tableView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    self.bannerImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_banner"]];
    [self.bkImg addSubview:self.bannerImgView];
    self.bannerImgView.userInteractionEnabled = self.leftImageView.userInteractionEnabled = self.rightImageView.userInteractionEnabled = YES;
    
    [self.bannerImgView addTarget:self action:@selector(goHomePage)];
    
    [self.bannerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bkImg).offset(13);
        make.right.mas_equalTo(self.bkImg).offset(-13);
        make.bottom.mas_greaterThanOrEqualTo(self.bkImg).offset(-20 - kTabbarHeight);
        make.height.mas_equalTo((kScreenWidth - 26) * 0.28);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftImageView.mas_bottom).offset(18);
        make.left.equalTo(@13);
        make.right.equalTo(@-13);
        make.bottom.mas_equalTo(self.bannerImgView.mas_top).offset(-20);
    }];
}

- (void)goHomePage {
    self.tabBarController.selectedIndex = 0;
}

- (void)leftJump {
    [JumpTool.tool jumpWithStr:self.leftUrl];
}

- (void)rightJump {
    [JumpTool.tool jumpWithStr:self.rightUrl];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)reloadData
{
    [self.mineData removeAllObjects];
    [NetMonitorTool.tool getWithPath:@"/before/gathered" Parameters:@{} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
            
        if (!responseModel.success) {
            [ProgressHud showMessage:responseModel.pc_flag];
            return;
        }
        self.meModel = [MineModel ACModel_withDict:responseModel.pc_portal];
        
        if (self.meModel.pc_inserting.count <= 0) {
            return;
        }
        
        [self.mineData addObjectsFromArray:self.meModel.pc_inserting];
        if (self.mineData.count >= 2) {
            NSArray <PC_MeModel_Inserting *>* tempData = [self.mineData subarrayWithRange:NSMakeRange(0, 2)];
            self.leftLab.text = tempData.firstObject.pc_beck;
            self.rightLab.text = tempData.lastObject.pc_beck;
            self.leftUrl = tempData.firstObject.pc_merely;
            self.rightUrl = tempData.lastObject.pc_merely;
            
            self.leftImageView.hidden = self.rightImageView.hidden = NO;
            
            [self.mineData removeObjectsInRange:NSMakeRange(0, 2)];
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } FailBlock:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)setMeModel:(MineModel *)meModel
{
    _meModel = meModel;
    self.accountNumLab.text = meModel.pc_userInfo.pc_userphone;
    
}


#pragma mark - func



#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mineData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MineTableViewCell.className forIndexPath:indexPath];
    cell.meModel = self.mineData[indexPath.row];
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PC_MeModel_Inserting *cellModel = self.mineData[indexPath.row];
    [JumpTool.tool jumpWithStr:cellModel.pc_merely];
}

#pragma mark - init

- (UIImageView *)bkImg
{
    if (_bkImg == nil) {
        _bkImg = [[UIImageView alloc]initWithImage:IMAGE(@"me_bg")];
        _bkImg.userInteractionEnabled = YES;
    }
    return _bkImg;
}

- (UILabel *)accountNumLab
{
    if (_accountNumLab == nil) {
        _accountNumLab = [UILabel LabelWithFont:Semibold(24) TextColor:@"#000000" Text:@""];
    }
    return _accountNumLab;
}

- (NSMutableArray<PC_MeModel_Inserting *> *)mineData {
    if (!_mineData) {
        _mineData = [NSMutableArray array];
    }
    
    return _mineData;
}

@end
