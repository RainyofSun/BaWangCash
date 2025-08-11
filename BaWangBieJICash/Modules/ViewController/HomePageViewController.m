//
//  HomePageViewController.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "HomePageViewController.h"
#import "HomePageModel.h"
#import "HomePageCommentModel.h"
#import "LoginLogic.h"
#import "CertificationListViewController.h"
#import "HomeBigCardView.h"
#import "HomeSmallCardView.h"

@interface HomePageViewController ()

@property (nonatomic ,strong) HomePageModel *homeModel;

@property (nonatomic, strong) HomePageCommentModel *commentModel;

@property (nonatomic ,assign) NSInteger productID;

@property (nonatomic, strong) HomeBigCardView *largeView;
@property (nonatomic, strong) HomeSmallCardView *smallView;

@property (nonatomic, assign) bool isLargeCard;

@property (nonatomic, strong) UIImageView *bottomImgView;

@end

@implementation HomePageViewController

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.navBar.hidden = YES;
    
    self.bottomImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bottom_bg"]];
    [self.view addSubview:self.bottomImgView];
    
    [self.bottomImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.largeView.topSubImg addTarget:self action:@selector(applyClick)];
    [self.largeView.phoneApplyView addTarget:self action:@selector(phoneApplyCall)];
    [self.smallView.applyView addTarget:self action:@selector(applyClick)];
    
    [Noti_Center addObserver:self selector:@selector(requestHomeData) name:PC_DidLoginSucc_NotiKey object:nil];
    [Noti_Center addObserver:self selector:@selector(getHomeData) name:PC_DidLogoutSucc_NotiKey object:nil];
    
    self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestHomeData)];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.scrollView.mj_header beginRefreshing];
}

- (void)requestHomeData
{
    // 首页数据刷新时上报
    [PositionTool.tool checkLocationPermission];
    [APPLogTool.tool reportDeviceIDsWithCompletion:^(BOOL success) {
        
    }];
    
    [APPLogTool.tool reportDeviceWithCompletion:^(BOOL success) {
        
    }];
    
    [self getHomeData];
}

- (void)setHomeModel:(HomePageModel *)homeModel
{
    _homeModel = homeModel;
    
    [self.largeView removeFromSuperview];
    [self.smallView removeFromSuperview];
    
    for (PC_HomeModel_Inserting *type in homeModel.pc_inserting) {
        NSString *title = type.pc_disposing;
        self.isLargeCard = [title isEqualToString:@"crowyesb"];
        
        if ([title isEqualToString:@"crowyesb"] ||
            [title isEqualToString:@"crowyesc"]) {
            self.isLargeCard ? [self updateLargeTopView:type] : [self updateSmallTopView:type];
        }
    }
    
    if (self.isLargeCard) {
        [self.scrollContentView addSubview:self.largeView];
        [self.largeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.scrollContentView).offset(kScreenHeight >= 812 ? 30 : 0);
            make.left.right.bottom.mas_equalTo(self.scrollContentView);
        }];
    }else {
        [self.scrollContentView addSubview:self.smallView];
        [self.smallView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.scrollContentView);
        }];
    }
}


- (void)updateLargeTopView:(PC_HomeModel_Inserting *)insertingModel
{
    for (PC_HomeModel_Inserting_Consists *consists in insertingModel.pc_consists) {
        self.largeView.topSubImg.priceLab.text = consists.pc_longer;
        self.largeView.topSubImg.termLab.text = consists.pc_godzilla;
        self.largeView.topSubImg.rateLab.text = consists.pc_collection;
        self.productID = consists.pc_consumers;
        [self.largeView.productView refreshProductTitle:consists.pc_instruct titleSize:23];
        self.largeView.topSubImg.LoanLab.text = consists.pc_megalon;
        [self.largeView.topSubImg.applyBtn refreshApplyButtonTitle:consists.pc_conflicts];
    }
}

- (void)updateSmallTopView:(PC_HomeModel_Inserting *)insertingModel
{
    for (PC_HomeModel_Inserting_Consists *consists in insertingModel.pc_consists) {
        self.smallView.applyView.priceLab.text = consists.pc_longer;
        self.smallView.applyView.termLab.text = consists.pc_godzilla;
        self.smallView.applyView.rateLab.text = consists.pc_collection;
        self.productID = consists.pc_consumers;
        
        [self.smallView.productView refreshProductTitle:consists.pc_instruct titleSize:23];
        self.smallView.applyView.LoanLab.text = consists.pc_megalon;
        [self.smallView.applyView.applyBtn refreshApplyButtonTitle:consists.pc_conflicts];
    }
}


#pragma mark - func

- (void)getHomeData
{
    __weakSelf;
    [NetMonitorTool.tool getWithPath:@"/before/allers" Parameters:@{} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        if (!responseModel.success) {
            [ProgressHud showMessage:responseModel.pc_flag];
            return;
        }
        __strongSelf;
        HomePageModel *model = [HomePageModel ACModel_withDict:responseModel.pc_portal];
        self.homeModel = model;
        
        if (!self.isLargeCard) {
            self.smallView.smallView.homeModel = [HomePageSmallModel ACModel_withDict:responseModel.pc_portal];
        }
        
        [self.scrollView.mj_header endRefreshing];
    } FailBlock:^(NSError * _Nonnull error) {
        [self.scrollView.mj_header endRefreshing];
    }];
}

// ApplyNow点击事件
- (void)applyClick
{
    [ProgressHud showLoading];
    if (LoginLogic.tool.isLogin) {
        // 准入接口(首页点击产品 必须先调用此接口)
        [NetMonitorTool.tool postWithPath:@"/before/commenting" Parameters:@{@"filmmaker":@(self.productID)} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
            [ProgressHud hiddenLoading];
            if (!responseModel.success) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [ProgressHud showMessage:responseModel.pc_flag];
                });
                return;
            }
            self.commentModel = [HomePageCommentModel ACModel_withDict:responseModel.pc_portal];
            NSString *url = self.commentModel.pc_merely;
            [JumpTool.tool jumpWithStr:url];
        } FailBlock:^(NSError * _Nonnull error) {
            [ProgressHud hiddenLoading];
        }];
    } else {
        [ProgressHud hiddenLoading];
        LoginPresent *view = [LoginPresent new];
        [view show];
    }
    
}


- (void)phoneApplyCall
{
//    NSString *applyUrl = @"http://47.236.240.3:8150/keepThe?calling=4&influenced=1";
//    [PC_JumpTool.tool jumpWithStr:applyUrl];
    if (LoginLogic.tool.isLogin) {
        CertificationListViewController *vc = [CertificationListViewController new];
        vc.productID = self.productID;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        LoginPresent *view = [LoginPresent new];
        [view show];
    }
}

#pragma mark - init
- (HomeBigCardView *)largeView {
    if (!_largeView) {
        _largeView = [[HomeBigCardView alloc] initWithFrame:CGRectZero];
    }
    
    return _largeView;
}

- (HomeSmallCardView *)smallView {
    if (!_smallView) {
        _smallView = [[HomeSmallCardView alloc] initWithFrame:CGRectZero];
    }
    
    return _smallView;
}

@end
