//
//  HomePageSmallTableViewCell.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "HomePageSmallTableViewCell.h"
#import "HomePageCommentModel.h"
#import "HomeSmallApplyButton.h"

@interface HomePageSmallTableViewCell ()

@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) AC_BaseView *cellView;
@property (nonatomic, strong) HomeSmallApplyButton *applyBtn;

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *priceLab;

@property (nonatomic, strong) UILabel *termtitle;
@property (nonatomic, strong) UILabel *ratetitle;

@property (nonatomic, strong) UILabel *termLabel;
@property (nonatomic, strong) UILabel *rateLabel;

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic ,assign) NSInteger productID;

@property (nonatomic , assign) bool isInNet;

@end

@implementation HomePageSmallTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self.contentView addSubview:self.cellView];
    [self.cellView insertSubview:self.bgView atIndex:0];
    [self.cellView addSubview:self.termLabel];
    [self.cellView addSubview:self.applyBtn];
    [self.cellView addSubview:self.rateLabel];
    
    [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
        make.top.equalTo(@14);
        make.bottom.equalTo(@0).priorityLow();
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.cellView);
    }];
    
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-16);
        make.centerY.mas_equalTo(self.nameLab);
    }];
    
    [self.termtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.termLabel.mas_left).offset(-16);
        make.centerY.equalTo(self.priceLab);
        make.size.equalTo(@6);
    }];
    
    [self.termLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.ratetitle.mas_left).offset(-16);
        make.centerY.equalTo(self.termtitle);
    }];
    
    [self.ratetitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rateLabel.mas_left).offset(-16);
        make.centerY.equalTo(self.termLabel);
        make.size.equalTo(@6);
    }];
    
    [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.cellView).offset(-16);
        make.centerY.equalTo(self.ratetitle);
    }];
    
    [self.contentView addTarget:self action:@selector(jumpCall)];
}


- (void)setHomeModel:(PC_HomeSmallModel_Inserting_Consists *)homeModel
{
    _homeModel = homeModel;
    
    self.nameLab.text = homeModel.pc_instruct;
    self.priceLab.text = homeModel.pc_longer;
    self.applyBtn.titleLab.text = homeModel.pc_conflicts;
    self.termtitle.text = homeModel.pc_boxed;
    self.ratetitle.text = homeModel.pc_gila;
   
    self.termLabel.text = homeModel.pc_godzilla;
    self.rateLabel.text = homeModel.pc_burned;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:homeModel.pc_seminar]];
    
    self.productID = homeModel.pc_consumers;
}

- (void)jumpCall
{
    if (self.isInNet) return;
    self.isInNet = true;
    // 准入接口(首页点击产品 必须先调用此接口)
    [ProgressHud showLoading];
    [NetMonitorTool.tool postWithPath:@"/before/commenting" Parameters:@{@"filmmaker":@(self.productID)} CompleteBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        [ProgressHud hiddenLoading];
        self.isInNet = false;
        if (!responseModel.success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHud showMessage:responseModel.pc_flag];
            });
            return;
        }
        HomePageCommentModel *model = [HomePageCommentModel ACModel_withDict:responseModel.pc_portal];
        NSString *url = model.pc_merely;
        [JumpTool.tool jumpWithStr:url];
    } FailBlock:^(NSError * _Nonnull error) {
        self.isInNet = false;
        [ProgressHud hiddenLoading];
    }];
}

#pragma mark - init
- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"small_cell_bg"]];
    }
    
    return _bgView;
}

- (AC_BaseView *)cellView
{
    if (_cellView == nil) {
        _cellView = [AC_BaseView new];
        [_cellView makeShadowWithColor:[HEXCOLOR(@"#595959") colorWithAlphaComponent:0.04] opacity:8 radius:2 offset:CGSizeMake(0, 0)];
        
        ImgViewWithName(iconImg, @"");
        iconImg.layer.cornerRadius = 4;
        iconImg.clipsToBounds = YES;
        self.iconImg = iconImg;
        [_cellView addSubview:iconImg];
        [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.top.equalTo(@14);
            make.height.width.equalTo(@24);
        }];
        
        UILabel *pcLab = [UILabel LabelWithFont:Semibold(16) TextColor:@"#333333" Text:@""];
        self.nameLab = pcLab;
        [_cellView addSubview:pcLab];
        [pcLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImg.mas_right).offset(6);
            make.top.equalTo(@17);
        }];
        
        UILabel *amountLab = [UILabel LabelWithFont:Regular(12) TextColor:@"#858585" Text:@"Loan amount"];
        [_cellView addSubview:amountLab];
        [amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.top.equalTo(iconImg.mas_bottom).offset(8);
        }];
        
        UILabel *priceLab = [UILabel LabelWithFont:ShuHeiTi(28) TextColor:@"#333333" Text:@""];
        self.priceLab = priceLab;
        [_cellView addSubview:priceLab];
        [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(amountLab);
            make.top.equalTo(amountLab.mas_bottom);
            make.bottom.equalTo(@-8);
        }];
        
        UILabel *termLab = [UILabel LabelWithFont:Regular(12) TextColor:@"#777DA3" Text:@""];
        [termLab setCornerRadius:3];
        termLab.backgroundColor = MAIN_COLOR;
        
        self.termtitle = termLab;
        [_cellView addSubview:termLab];
        
        UILabel *rateLab = [UILabel LabelWithFont:Regular(12) TextColor:@"#777DA3" Text:@""];
        [rateLab setCornerRadius:3];
        rateLab.backgroundColor = MAIN_COLOR;
        
        self.ratetitle = rateLab;
        [_cellView addSubview:rateLab];
        
        
    }
    return _cellView;
}

- (HomeSmallApplyButton *)applyBtn
{
    if (_applyBtn == nil) {
        _applyBtn = [[HomeSmallApplyButton alloc] initWithFrame:CGRectZero];
    }
    return _applyBtn;
}

- (UILabel *)termLabel
{
    if (_termLabel == nil) {
        _termLabel = [UILabel LabelWithFont:Semibold(12) TextColor:@"#9471F3" Text:@""];
    }
    return _termLabel;
}

- (UILabel *)rateLabel
{
    if (_rateLabel == nil) {
        _rateLabel = [UILabel LabelWithFont:Semibold(12) TextColor:@"#9471F3" Text:@""];
    }
    return _rateLabel;
}

@end
