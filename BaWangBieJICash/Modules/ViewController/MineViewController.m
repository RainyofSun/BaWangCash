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
@property (nonatomic ,strong) UIImageView *topImg;

@property (nonatomic ,strong) UILabel *accountNumLab;
@property (nonatomic ,strong) UILabel *topDetailLab;

@property (nonatomic ,strong) AC_BaseView *aboutView;
@property (nonatomic ,strong) AC_BaseView *onlineView;
@property (nonatomic ,strong) AC_BaseView *feeedBackView;
@property (nonatomic ,strong) AC_BaseView *privacyView;
@property (nonatomic ,strong) AC_BaseView *settingsView;

@property (nonatomic ,strong) MineModel *meModel;

@end

@implementation MineViewController

- (void)setUpSubView
{
    [super setUpSubView];

    [self.view addSubview:self.bkImg];
    [self.bkImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.bkImg addSubview:self.topImg];
    [self.topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
    }];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.tableView registerClass:MineTableViewCell.class forCellReuseIdentifier:MineTableViewCell.className];
    self.tableView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImg.mas_bottom).offset(4);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.bottom.equalTo(@(kBottomHeight*-1));
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)reloadData
{
    [NetMonitorTool.tool getWithPath:@"/before/gathered" Parameters:@{} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
            
        if (!responseModel.success) {
            [ProgressHud showMessage:responseModel.pc_flag];
            return;
        }
        self.meModel = [MineModel ACModel_withDict:responseModel.pc_portal];
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
    return self.meModel.pc_inserting.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MineTableViewCell.className forIndexPath:indexPath];
    cell.meModel = self.meModel.pc_inserting[indexPath.row];
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PC_MeModel_Inserting *cellModel = self.meModel.pc_inserting[indexPath.row];
    [JumpTool.tool jumpWithStr:cellModel.pc_merely];
}

#pragma mark - init

- (UIImageView *)bkImg
{
    if (_bkImg == nil) {
        _bkImg = [[UIImageView alloc]initWithImage:IMAGE(@"home_bk")];
        _bkImg.userInteractionEnabled = YES;
    }
    return _bkImg;
}

- (UIImageView *)topImg
{
    if (_topImg == nil) {
        _topImg = [[UIImageView alloc]initWithImage:IMAGE(@"me_top")];
        _topImg.userInteractionEnabled = YES;
        
        
        ImgViewWithName(icon, @"me_head");
        icon.userInteractionEnabled = YES;
        [_topImg addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@28);
            make.top.equalTo(@140);
            make.height.width.equalTo(@90);
        }];
        
        
        [_topImg addSubview:self.accountNumLab];
        [self.accountNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(10);
            make.top.equalTo(icon.mas_top).offset(19);
            make.height.equalTo(@28);
        }];
        UILabel *detailLab = [UILabel LabelWithFont:Regular(14) TextColor:@"#000000" Text:@"Welcome to my small world"];
        [_topImg addSubview:detailLab];
        [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.accountNumLab.mas_left);
            make.top.equalTo(self.accountNumLab.mas_bottom).offset(4);
            make.height.equalTo(@20);
        }];
    }
    return _topImg;
}

- (UILabel *)accountNumLab
{
    if (_accountNumLab == nil) {
        _accountNumLab = [UILabel LabelWithFont:Semibold(24) TextColor:@"#000000" Text:@""];
    }
    return _accountNumLab;
}

@end
