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
#import "HomePageSmallView.h"

@interface HomePageViewController ()

@property (nonatomic ,strong) HomePageModel *homeModel;

@property (nonatomic, strong) HomePageCommentModel *commentModel;

@property (nonatomic ,strong) UIImageView *bkImg;
@property (nonatomic ,strong) UIImageView *topImg;

@property (nonatomic ,strong) UILabel *priceLab;

@property (nonatomic ,strong) AC_BaseView *whiteView;

@property (nonatomic ,strong) UILabel *loantermLab;
@property (nonatomic ,strong) UILabel *interLab;
@property (nonatomic ,strong) UILabel *termLab;
@property (nonatomic ,strong) UILabel *rateLab;

@property (nonatomic ,assign) NSInteger productID;

@property (nonatomic ,strong) AC_BaseButton *applyBtn;

@property (nonatomic ,strong) AC_BaseView *largeView;

@property (nonatomic ,strong) AC_BaseView *strengthView;

@property (nonatomic ,strong) AC_BaseView *phoneApplyView;

@property (nonatomic, strong) HomePageSmallView *homeSmallView;

@property (nonatomic, assign) bool isLargeCard;

@property (nonatomic, strong) UILabel *LoanLab;

@end

@implementation HomePageViewController

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.scrollContentView addSubview:self.bkImg];
    [self.bkImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.bkImg addSubview:self.topImg];
    [self.topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.right.equalTo(@0);
    }];
    
    [self.topImg addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@180);
        make.centerX.equalTo(@0);
        make.height.equalTo(@30);
    }];
    
    [self.topImg addSubview:self.whiteView];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLab.mas_bottom).offset(11);
        make.height.equalTo(@60);
        make.left.equalTo(@(kScreenWidth / 375.0 * 46.0));
        make.right.equalTo(@(kScreenWidth / 375.0 * 30.0 * -1));
    }];
    
    [self.whiteView addSubview:self.termLab];
    [self.termLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@21);
        make.bottom.equalTo(@-8);
        make.height.equalTo(@22);
    }];
    
    [self.whiteView addSubview:self.rateLab];
    [self.rateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-22);
        make.bottom.equalTo(@-8);
        make.height.equalTo(@22);
    }];
    
    [self.bkImg addSubview:self.applyBtn];
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteView.mas_bottom).offset(12);
        make.left.equalTo(@(kScreenWidth / 375.0 * 53.0));
        make.right.equalTo(@(kScreenWidth / 375.0 * 53.0 * -1));
        make.height.equalTo(@50);
    }];
    
    UIButton *btn = [UIButton new];
    [btn addTarget:self action:@selector(applyClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bkImg addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@125);
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
        make.bottom.equalTo(self.applyBtn.mas_bottom);
    }];
    
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
    [self.homeSmallView removeFromSuperview];
    
    for (PC_HomeModel_Inserting *type in homeModel.pc_inserting) {
        NSString *title = type.pc_disposing;
        self.isLargeCard = [title isEqualToString:@"crowyesb"];
        
        if ([title isEqualToString:@"crowyesb"] ||
            [title isEqualToString:@"crowyesc"]) {
            [self updateTopView:type];
        }
    }
    
    if (self.isLargeCard) {
        [self.bkImg addSubview:self.largeView];
        [self.largeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(self.applyBtn.mas_bottom).offset(14);
            make.height.equalTo(@476);
        }];
    }else {
        [self.bkImg addSubview:self.homeSmallView];
        [self.homeSmallView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(self.applyBtn.mas_bottom).offset(14);
            make.bottom.equalTo(@(kBottomHeight * -1));
        }];
    }
}


- (void)updateTopView:(PC_HomeModel_Inserting *)insertingModel
{
    for (PC_HomeModel_Inserting_Consists *consists in insertingModel.pc_consists) {
        self.priceLab.text = consists.pc_longer;
        self.termLab.text = consists.pc_godzilla;
        self.rateLab.text = consists.pc_collection;
        self.loantermLab.text = consists.pc_boxed;
        self.interLab.text = consists.pc_gila;
        self.productID = consists.pc_consumers;
        
        self.LoanLab.text = consists.pc_megalon;
        
        [self.applyBtn setTitle:consists.pc_conflicts forState:UIControlStateNormal];
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
            self.homeSmallView.homeModel = [HomePageSmallModel ACModel_withDict:responseModel.pc_portal];
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
        _topImg = [[UIImageView alloc]initWithImage:IMAGE(@"home_top")];
        _topImg.userInteractionEnabled = YES;
        
        UILabel *LoanLab = [UILabel LabelWithFont:Regular(16) TextColor:@"#5E5E5E" Text:@""];
        self.LoanLab = LoanLab;
        [_topImg addSubview:LoanLab];
        [LoanLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@151);
            make.centerX.equalTo(@0);
            make.height.equalTo(@22);
        }];
    }
    return _topImg;
}

- (UILabel *)priceLab
{
    if (_priceLab == nil) {
        _priceLab = [UILabel LabelWithFont:Regular(43) TextColor:@"#000000" Text:@""];
    }
    return _priceLab;
}

- (AC_BaseView *)whiteView
{
    if (_whiteView == nil) {
        _whiteView = [AC_BaseView new];
        _whiteView.backgroundColor = HEXCOLOR(@"#FFFFFF");
        _whiteView.layer.cornerRadius = 14;
        [_whiteView makeShadowWithColor:[HEXCOLOR(@"#000000") colorWithAlphaComponent:0.07] opacity:8 radius:0 offset:CGSizeMake(0, 2)];
        
        self.loantermLab = [UILabel LabelWithFont:Regular(14) TextColor:@"#727272" Text:@""];
        [_whiteView addSubview:self.loantermLab];
        [self.loantermLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@22);
            make.top.equalTo(@8);
            make.height.equalTo(@20);
        }];
        self.interLab = [UILabel LabelWithFont:Regular(14) TextColor:@"#727272" Text:@""];
        [_whiteView addSubview:self.interLab];
        [self.interLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-25);
            make.top.equalTo(@8);
            make.height.equalTo(@20);
        }];
        
    }
    return _whiteView;
}

- (UILabel *)termLab
{
    if (_termLab == nil) {
        _termLab = [UILabel LabelWithFont:Semibold(16) TextColor:@"#000000" Text:@""];
    }
    return _termLab;
}

- (UILabel *)rateLab
{
    if (_rateLab == nil) {
        _rateLab = [UILabel LabelWithFont:Semibold(16) TextColor:@"#000000" Text:@""];
    }
    return _rateLab;
}

- (AC_BaseButton *)applyBtn
{
    if (_applyBtn == nil) {
        _applyBtn = [AC_BaseButton TextBtnWithTitle:@"" titleColor:@"#000000" font:Bold(18)];
        [_applyBtn setBackgroundImage:IMAGE(@"home_apply_btn") forState:UIControlStateNormal];
    }
    return _applyBtn;
}


- (AC_BaseView *)strengthView
{
    if (_strengthView == nil) {
        _strengthView = [AC_BaseView new];
        _strengthView.backgroundColor = HEXCOLOR(@"FFFFFF");
        _strengthView.layer.cornerRadius = 18;
        
        
        AC_BaseView *greenView = [AC_BaseView new];
        greenView.backgroundColor = HEXCOLOR(@"#44E3AD");
        [greenView setCornerRadius:18 rectCorner:UIRectCornerTopLeft|UIRectCornerTopRight];
        [_strengthView addSubview:greenView];
        [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(@0);
            make.height.equalTo(@34);
        }];
        UILabel *title = [UILabel LabelWithFont:Bold(18) TextColor:@"#333333" Text:@"Our strengths"];
        [greenView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(@0);
            make.height.equalTo(@20);
        }];
        ImgViewWithName(home_bianzu_duoge, @"home_bianzu_duoge");
        
        [greenView addSubview:home_bianzu_duoge];
        [home_bianzu_duoge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(@0);
        }];
        // 灰色view
        AC_BaseView *garyView = [AC_BaseView new];
        garyView.backgroundColor = HEXCOLOR(@"#F6F6F6");
        [garyView setCornerRadius:14];
        [_strengthView addSubview:garyView];
        [garyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(greenView.mas_bottom).offset(11);
            make.left.equalTo(@12);
            make.right.equalTo(@-12);
            make.height.equalTo(@93);
        }];
        
        ImgViewWithName(oneImg, @"home_one");
        [garyView addSubview:oneImg];
        [oneImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@9);
            make.left.equalTo(@17);
            //make.height.equalTo(oneImg.mas_width).multipliedBy(36.0/41.0);
            make.height.equalTo(@36);
            make.width.equalTo(@41);
        }];
        
        UILabel *lowLab = [UILabel LabelWithFont:Medium(16) TextColor:@"#000000" Text:@"Low interest rates"];
        [garyView addSubview:lowLab];
        [lowLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneImg.mas_right).offset(7);
            make.top.equalTo(@15);
            make.height.equalTo(@22);
        }];
        UILabel *lowDetailLab = [UILabel LabelWithFont:Regular(13) TextColor:@"#727272" Text:@"We promise that all fees are open and transparent, with no hidden costs."];
        lowDetailLab.numberOfLines = 0;
        lowDetailLab.textAlignment = NSTextAlignmentLeft;
        [garyView addSubview:lowDetailLab];
        [lowDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@17);
            make.right.equalTo(@-17);
            make.top.equalTo(@53);
        }];
        
        AC_BaseView *garyTwoView = [AC_BaseView new];
        garyTwoView.backgroundColor = HEXCOLOR(@"#F6F6F6");
        [garyTwoView setCornerRadius:14];
        [_strengthView addSubview:garyTwoView];
        [garyTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(garyView.mas_bottom).offset(12);
            make.left.equalTo(@12);
            make.right.equalTo(@-12);
            make.height.equalTo(@93);
        }];
        
        ImgViewWithName(twoImg, @"home_two");
        [garyTwoView addSubview:twoImg];
        [twoImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@9);
            make.left.equalTo(@17);
            //make.height.equalTo(oneImg.mas_width).multipliedBy(36.0/41.0);
            make.height.equalTo(@36);
            make.width.equalTo(@41);
        }];
        
        UILabel *fastLab = [UILabel LabelWithFont:Medium(16) TextColor:@"#000000" Text:@"Fast Approval"];
        [garyTwoView addSubview:fastLab];
        [fastLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(twoImg.mas_right).offset(7);
            make.top.equalTo(@15);
            make.height.equalTo(@22);
        }];
        UILabel *fastDetailLab = [UILabel LabelWithFont:Regular(13) TextColor:@"#727272" Text:@"Intelligent review system, fast approval within 5 minutes."];
        fastDetailLab.numberOfLines = 0;
        fastDetailLab.textAlignment = NSTextAlignmentLeft;
        [garyTwoView addSubview:fastDetailLab];
        [fastDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@17);
            make.right.equalTo(@-17);
            make.top.equalTo(@53);
        }];
        
        // 灰色view
        AC_BaseView *garyThreeView = [AC_BaseView new];
        garyThreeView.backgroundColor = HEXCOLOR(@"#F6F6F6");
        [garyThreeView setCornerRadius:14];
        [_strengthView addSubview:garyThreeView];
        [garyThreeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(garyTwoView.mas_bottom).offset(12);
            make.left.equalTo(@12);
            make.right.equalTo(@-12);
            make.height.equalTo(@93);
        }];
        
        ImgViewWithName(threeImg, @"home_three");
        [garyThreeView addSubview:threeImg];
        [threeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@9);
            make.left.equalTo(@17);
            //make.height.equalTo(oneImg.mas_width).multipliedBy(36.0/41.0);
            make.height.equalTo(@36);
            make.width.equalTo(@41);
        }];
        
        UILabel *safeLab = [UILabel LabelWithFont:Medium(16) TextColor:@"#000000" Text:@"Safe and reliable"];
        [garyThreeView addSubview:safeLab];
        [safeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(threeImg.mas_right).offset(7);
            make.top.equalTo(@15);
            make.height.equalTo(@22);
        }];
        UILabel *safeDetailLab = [UILabel LabelWithFont:Regular(13) TextColor:@"#727272" Text:@"Advanced encryption technology protects your personal information."];
        safeDetailLab.numberOfLines = 0;
        safeDetailLab.textAlignment = NSTextAlignmentLeft;
        [garyThreeView addSubview:safeDetailLab];
        [safeDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@17);
            make.right.equalTo(@-17);
            make.top.equalTo(@53);
        }];
    }
    return _strengthView;
}

- (AC_BaseView *)phoneApplyView
{
    if (_phoneApplyView == nil) {
        _phoneApplyView  = [AC_BaseView new];
        _phoneApplyView.backgroundColor = UIColor.clearColor;
        
        ImgViewWithName(home_bainzu, @"home_bainzu");
        home_bainzu.userInteractionEnabled = YES;
        [home_bainzu addTarget:self action:@selector(phoneApplyCall)];
        [_phoneApplyView addSubview:home_bainzu];
        [home_bainzu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        
        
//        UIView *img = [UIView new];
//        img.backgroundColor = UIColor.redColor;
//        [_phoneApplyView addSubview:img];
//        [img mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@6);
//            make.left.equalTo(@9);
//            make.height.equalTo(@95);
//            make.width.equalTo(@96);
//        }];
//
//        UILabel *minuteLab = [UILabel LabelWithFont:Medium(20) TextColor:@"#000000" Text:@"3 minutes"];
//        [_phoneApplyView addSubview:minuteLab];
//        [minuteLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(img.mas_right).offset(44);
//            make.top.equalTo(@6);
//            make.height.equalTo(@20);
//        }];
//        UILabel *minuteDetailLab = [UILabel LabelWithFont:Regular(14) TextColor:@"#858585" Text:@"Apply for a loan online via your mobile phone"];
//        minuteDetailLab.numberOfLines = 0;
//        minuteDetailLab.textAlignment = NSTextAlignmentLeft;
//        [_phoneApplyView addSubview:minuteDetailLab];
//        [minuteDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(minuteLab.mas_left);
//            make.right.equalTo(@-12);
//            make.top.equalTo(minuteLab.mas_bottom).offset(5);
//        }];
        
    }
    return _phoneApplyView;
}


- (AC_BaseView *)largeView
{
    if (_largeView == nil) {
        _largeView  = [AC_BaseView new];
        _largeView.backgroundColor = UIColor.clearColor;
        
       [_largeView addSubview:self.strengthView];
       [self.strengthView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(@16);
           make.right.equalTo(@-16);
           make.top.equalTo(@0);
           make.height.equalTo(@363);
       }];
   
       [_largeView addSubview:self.phoneApplyView];
       [self.phoneApplyView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(@16);
           make.right.equalTo(@-16);
           make.top.equalTo(self.strengthView.mas_bottom).offset(12);
           make.height.equalTo(@101);
       }];

    }
    return _largeView;
}

- (HomePageSmallView *)homeSmallView
{
    if (_homeSmallView == nil) {
        _homeSmallView = [HomePageSmallView new];
    }
    return _homeSmallView;
}

@end
