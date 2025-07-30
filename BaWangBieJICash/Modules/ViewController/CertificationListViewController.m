//
//  CertificationListViewController.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "CertificationListViewController.h"
#import "CertificationListTableViewCell.h"
#import "AppAuthTool.h"
#import "ApplyCashModel.h"

@interface CertificationListViewController ()

@property (nonatomic ,strong) ProductDetailModel *proDetailModel;

@property (nonatomic ,strong) AddressModel *addressModel;

@property (nonatomic ,strong) UIImageView *bkImg;
@property (nonatomic ,strong) UIImageView *topImg;
@property (nonatomic ,strong) UILabel *priceLab;

@property (nonatomic, strong) NSArray <NSDictionary *> *listDatas;
// List
@property (nonatomic ,strong) AC_BaseView *whiteView;
@property (nonatomic, strong) UILabel *loantermLab;
@property (nonatomic, strong) UILabel *interLab;
@property (nonatomic, strong) UILabel *daysLab;
@property (nonatomic, strong) UILabel *dayLab;

@property (nonatomic, strong) UILabel *readLab;
@property (nonatomic , strong) YYLabel *touchLab;
@property (nonatomic ,strong) UIImageView *agreeImg;

@property (nonatomic ,strong) AC_BaseButton *loanBtn;

@property (nonatomic ,assign) bool isAgree;

@property (nonatomic, strong) UILabel *LoanLab;

@end

@implementation CertificationListViewController

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.title = @"Product Detail";
    
    [self.view insertSubview:self.bkImg atIndex:0];
    [self.bkImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.bkImg addSubview:self.topImg];
    [self.topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.right.equalTo(@0);
        make.height.equalTo(@326);
    }];
    
    [self.topImg addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@200);
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
    
    UILabel *certificationLab = [UILabel LabelWithFont:Bold(18) TextColor:@"#FFFFFF" Text:@"Certification process"];
    [self.bkImg addSubview:certificationLab];
    [certificationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@332);
        make.height.equalTo(@20);
        make.left.equalTo(@16);
    }];
    
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.tableView registerClass:CertificationListTableViewCell.class forCellReuseIdentifier:CertificationListTableViewCell.className];
    self.tableView.backgroundColor = UIColor.clearColor;
    [self.bkImg addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@354);
        make.right.left.equalTo(@0);
       
    }];
    
    AC_BaseView *agreeView = [AC_BaseView new];
    agreeView.backgroundColor = UIColor.clearColor;
    [self.bkImg addSubview:agreeView];
    [agreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom).offset(18);
        make.height.equalTo(@22);
        make.centerX.equalTo(@0);
    }];

    // 勾选
    [agreeView addSubview:self.agreeImg];
    [self.agreeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.width.height.equalTo(@17);
        make.centerY.equalTo(@0);
    }];
    
    [agreeView addSubview:self.readLab];
    [self.readLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.left.equalTo(self.agreeImg.mas_right).offset(1);
        make.width.greaterThanOrEqualTo(@30);
        make.right.equalTo(@0);
    }];
    
    [agreeView addSubview:self.touchLab];
    [self.touchLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.readLab);
    }];
    
    [self.bkImg addSubview:self.loanBtn];
    [self.loanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(agreeView.mas_bottom).offset(8);
        make.left.equalTo(@32);
        make.right.equalTo(@-32);
        make.height.equalTo(@54);
        make.bottom.equalTo(@(kBottomHeight *-1));
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    self.isAgree = true;
    
    [AppAuthTool.tool getAndUpdateNextAuthStatusWithProductID:self.productID StepBlock:^(NSString * _Nonnull authType) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}


- (void)headerRefresh
{
    [self requestData];
}

- (void)requestData
{
    // 产品详情页
    [NetMonitorTool.tool postWithPath:@"/before/pumbaa" Parameters:@{@"filmmaker":@(self.productID)} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {

        if (!responseModel.success) {
            [ProgressHud showMessage:responseModel.pc_flag];
            return;
        }
        self.proDetailModel = [ProductDetailModel ACModel_withDict:responseModel.pc_portal];
       
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
    } FailBlock:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)setProDetailModel:(ProductDetailModel *)proDetailModel
{
    _proDetailModel = proDetailModel;
    // 底部按钮文案
    NSString *anniu = self.proDetailModel.pc_gore.pc_conflicts;
    [self.loanBtn setTitle:anniu forState:UIControlStateNormal];
    
    self.priceLab.text = FORMAT(@"₱%ld",self.proDetailModel.pc_gore.pc_computer);
    
    self.loantermLab.text = proDetailModel.pc_gore.pc_far.pc_zappa.pc_beck;
    self.daysLab.text = proDetailModel.pc_gore.pc_far.pc_zappa.pc_earliest;
    self.interLab.text = proDetailModel.pc_gore.pc_far.pc_expressed.pc_beck;
    self.dayLab.text = proDetailModel.pc_gore.pc_far.pc_expressed.pc_earliest;
    
    self.LoanLab.text = proDetailModel.pc_gore.pc_thing;
    
    if (proDetailModel.pc_options.pc_beck == nil || [proDetailModel.pc_options.pc_beck isEqualToString:@""]) {
        self.readLab.hidden = YES;
        self.agreeImg.hidden = YES;
    }else {
        self.readLab.hidden = NO;
        self.agreeImg.hidden = NO;
        [self makePolicyAttrStrWithStr:proDetailModel.pc_options.pc_beck];
    }
}

- (void)makePolicyAttrStrWithStr:(NSString *)string
{
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    [style setParagraphStyle:NSParagraphStyle.defaultParagraphStyle];
    style.alignment = NSTextAlignmentLeft;
    
    NSString *totalString = @"";
    NSArray *strings = [string componentsSeparatedByString:@"||"];
    NSString *policyStr = strings.lastObject;
    for (NSString *str in strings) {
        totalString = [totalString stringByAppendingString:str];
    }
    
    NSMutableAttributedString * attri = [[NSMutableAttributedString alloc]initWithString:totalString attributes:@{NSForegroundColorAttributeName:_readLab.textColor,NSFontAttributeName:_readLab.font,NSParagraphStyleAttributeName:style}];
    
    [attri addAttributes:@{
        NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
        NSForegroundColorAttributeName:HEXCOLOR(@"#FED31D")
    } range:[totalString rangeOfString:policyStr]];
    self.readLab.attributedText = attri;

    NSMutableAttributedString *touchAttri = [[NSMutableAttributedString alloc]initWithString:totalString attributes:@{NSForegroundColorAttributeName:UIColor.clearColor,NSFontAttributeName:_readLab.font,NSParagraphStyleAttributeName:style}];
    __weakSelf;
    [touchAttri setTextHighlightRange:[attri.string rangeOfString:policyStr] color:UIColor.clearColor backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        __strongSelf;
        [self loanAgreementCall];
    }];
    
    self.touchLab.attributedText = touchAttri;
    self.touchLab.preferredMaxLayoutWidth = kScreenWidth - 49 - 1 - 46 - 17;
    self.touchLab.numberOfLines = 0;
    self.touchLab.numberOfLines = 0;
}

- (void)setIsAgree:(bool)isAgree
{
    _isAgree = isAgree;
    if (isAgree){
        self.agreeImg.image = IMAGE(@"Credito_Pesos_gouxuan");
    }else{
        self.agreeImg.image = IMAGE(@"login_choose_disable");
    }
}

- (void)agreementCall
{
    self.isAgree = !self.isAgree;
    
}
- (void)loanAgreementCall
{
    NSString *url = self.proDetailModel.pc_options.pc_thrive;
    [JumpTool.tool jumpWithStr:url];
}

- (void)loanBtnClick
{
    // 下一个待完成的认证项
    NSString *nextstep = self.proDetailModel.pc_postal.pc_receiving;
    if ([nextstep isEqualToString:@""]) {
        [self orderData];
    }else {
        [AppAuthTool.tool jumpToNextStepVC];
    }
    
}

- (void)orderData
{
    if (!self.isAgree) {
        [ProgressHud showMessage:@"Please read and agree to the content of the agreement first"];
        return;
    }
    
    // 订单号,金额,期限类型  // 借款期限
    NSInteger track = self.proDetailModel.pc_gore.pc_track;
    NSString *death = self.proDetailModel.pc_gore.pc_death.firstObject;
    NSString *calling = self.proDetailModel.pc_gore.pc_funniest;
    NSInteger cash = self.proDetailModel.pc_gore.pc_computer;
    NSDictionary *dict = @{
        @"emergence":calling,
        @"computer":@(cash),
        @"attempts":death,
        @"track":@(track)
    };
    
    [ProgressHud showLoading];
    [NetMonitorTool.tool postWithPath:@"/before/resembling" Parameters:dict SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        
        [ProgressHud hiddenLoading];
        if (!responseModel.success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHud showMessage:responseModel.pc_flag];
            });
            return;
        }
        
        ApplyCashModel *model = [ApplyCashModel ACModel_withDict:responseModel.pc_portal];
        NSString *jumpUrl = model.pc_merely;
        JumpTool.tool.isNeedPopToRoot = true;
        [JumpTool.tool jumpWithStr:jumpUrl];
        JumpTool.tool.isNeedPopToRoot = false;
        
        // 传订单号
        NSString * orderId = self.proDetailModel.pc_gore.pc_funniest;
        [PositionTool.tool startReportWithType:RiskPointType_LoanStart];
        [PositionTool.tool endReportWithType:RiskPointType_LoanStart orderId:orderId];
        
        [self.tableView.mj_header endRefreshing];
    } FailBlock:^(NSError * _Nonnull error) {
        [ProgressHud hiddenLoading];
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - TableView Delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.proDetailModel.pc_rec.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CertificationListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CertificationListTableViewCell.className forIndexPath:indexPath];
    cell.dislayModel = self.proDetailModel.pc_rec[indexPath.row];
    cell.productID = self.productID;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 自定义类型的值
    /**
     '"receiving":"public"', // ocr认证
     '"receiving":"personal"', // 个人信息
     '"receiving":"job"', // 个人信息
     '"receiving":"ext"', // 紧急联系人
     '"receiving":"bank"', // 绑卡
     混淆后
     '"receiving":"ofyesa"',
     '"receiving":"ofyesb"',
     '"receiving":"ofyesc"',
     '"receiving":"ofyesd"',
     '"receiving":"ofyese"',
     */
    NSString *receiving = self.proDetailModel.pc_rec[indexPath.row].pc_receiving;
    NSInteger count = indexPath.row;
    [AppAuthTool.tool jumpToNextStepVCWithTypeStr:receiving IsComplete:self.proDetailModel.pc_rec[indexPath.row].pc_usenet == 1 Count:count];

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
        _topImg = [[UIImageView alloc]initWithImage:IMAGE(@"ident_topView")];
        _topImg.userInteractionEnabled = YES;
        
        UILabel *LoanLab = [UILabel LabelWithFont:Regular(16) TextColor:@"#5E5E5E" Text:@""];
        self.LoanLab = LoanLab;
        [_topImg addSubview:LoanLab];
        [LoanLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@171);
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
        
        UILabel *loantermLab = [UILabel LabelWithFont:Regular(14) TextColor:@"#727272" Text:@""];
        self.loantermLab =loantermLab;
        [_whiteView addSubview:loantermLab];
        [loantermLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@22);
            make.top.equalTo(@8);
            make.height.equalTo(@20);
        }];
        UILabel *interLab = [UILabel LabelWithFont:Regular(14) TextColor:@"#727272" Text:@""];
        self.interLab = interLab;
        [_whiteView addSubview:interLab];
        [interLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-25);
            make.top.equalTo(@8);
            make.height.equalTo(@20);
        }];
        
        UILabel *daysLab = [UILabel LabelWithFont:Semibold(16) TextColor:@"#000000" Text:@""];
        self.daysLab = daysLab;
        [_whiteView addSubview:daysLab];
        [daysLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@21);
            make.top.equalTo(loantermLab.mas_bottom).offset(2);
            make.height.equalTo(@22);
        }];
        
        UILabel *dayLab = [UILabel LabelWithFont:Semibold(16) TextColor:@"#000000" Text:@""];
        self.dayLab = dayLab;
        [_whiteView addSubview:dayLab];
        [dayLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-22);
            make.top.equalTo(interLab.mas_bottom).offset(2);
            make.height.equalTo(@22);
        }];
    }
    return _whiteView;
}


- (AC_BaseButton *)loanBtn
{
    if (_loanBtn == nil) {
        _loanBtn = [AC_BaseButton TextBtnWithTitle:@"" titleColor:@"#000000" font:Semibold(18)];
        _loanBtn.backgroundColor = HEXCOLOR(@"#FED31D");
        [_loanBtn setCornerRadius:30];
        [_loanBtn addTarget:self action:@selector(loanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loanBtn;
}

- (UIImageView *)agreeImg
{
    if (_agreeImg == nil) {
        _agreeImg = [UIImageView new];
        _agreeImg.userInteractionEnabled = YES;
        _agreeImg.hidden = YES;
        [_agreeImg addTarget:self action:@selector(agreementCall)];
        
    }
    return _agreeImg;
}

- (UILabel *)readLab
{
    if (_readLab == nil) {
        _readLab = [UILabel new];
        _readLab.font = Regular(14);
        _readLab.textColor = HEXCOLOR(@"#000000");
    }
    return _readLab;
}


- (YYLabel *)touchLab
{
    if (_touchLab == nil) {
        _touchLab = [YYLabel new];
        _touchLab.font = self.readLab.font;
        _touchLab.textColor = self.readLab.textColor;
    }
    return _touchLab;
}

@end
