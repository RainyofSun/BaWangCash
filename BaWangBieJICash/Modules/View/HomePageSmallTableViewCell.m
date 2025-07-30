//
//  HomePageSmallTableViewCell.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "HomePageSmallTableViewCell.h"
#import "HomePageCommentModel.h"

@interface HomePageSmallTableViewCell ()

@property (nonatomic, strong) AC_BaseView *cellView;
@property (nonatomic, strong) AC_BaseButton *applyBtn;

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

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self.contentView addSubview:self.cellView];
    [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
        make.top.equalTo(@14);
        make.bottom.equalTo(@0).priorityLow();
    }];
    
    [self.cellView addSubview:self.applyBtn];
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-16);
        make.top.equalTo(@22);
        make.height.equalTo(@34);
        make.width.equalTo(@85);
    }];
    
    
    [self.cellView addSubview:self.termLabel];
    [self.termLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.termtitle.mas_right).offset(4);
        make.top.equalTo(@87);
        make.height.equalTo(@14);
        make.bottom.equalTo(@-14);
    }];
    
    [self.cellView addSubview:self.rateLabel];
    [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ratetitle.mas_right).offset(4);
        make.top.equalTo(@87);
        make.height.equalTo(@14);
        make.bottom.equalTo(@-14);
    }];
    
    [self.contentView addTarget:self action:@selector(jumpCall)];
}


- (void)setHomeModel:(PC_HomeSmallModel_Inserting_Consists *)homeModel
{
    _homeModel = homeModel;
    
    self.nameLab.text = homeModel.pc_instruct;
    self.priceLab.text = homeModel.pc_longer;
    [self.applyBtn setTitle:homeModel.pc_conflicts forState:UIControlStateNormal];
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


- (AC_BaseView *)cellView
{
    if (_cellView == nil) {
        _cellView = [AC_BaseView new];
        [_cellView setCornerRadius:14];
        _cellView.backgroundColor = HEXCOLOR(@"#FFFFFF");
        [_cellView makeShadowWithColor:[HEXCOLOR(@"#595959") colorWithAlphaComponent:0.04] opacity:8 radius:2 offset:CGSizeMake(0, 0)];
        
        ImgViewWithName(iconImg, @"");
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
            make.height.equalTo(@16);
        }];
        
        
        UILabel *priceLab = [UILabel LabelWithFont:Bold(25) TextColor:@"#333333" Text:@""];
        self.priceLab = priceLab;
        [_cellView addSubview:priceLab];
        [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.top.equalTo(iconImg.mas_bottom).offset(8);
            make.height.equalTo(@25);
        }];
        
        UILabel *termLab = [UILabel LabelWithFont:Regular(12) TextColor:@"#777DA3" Text:@""];
        self.termtitle = termLab;
        [_cellView addSubview:termLab];
        [termLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.top.equalTo(priceLab.mas_bottom).offset(16);
            make.height.equalTo(@12);
            make.bottom.equalTo(@-14);
        }];
        
        UILabel *rateLab = [UILabel LabelWithFont:Regular(12) TextColor:@"#777DA3" Text:@""];
        self.ratetitle = rateLab;
        [_cellView addSubview:rateLab];
        [rateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(kScreenWidth / 2));
            make.top.equalTo(priceLab.mas_bottom).offset(16);
            make.height.equalTo(@12);
            make.bottom.equalTo(@-14);
        }];
        
        
    }
    return _cellView;
}

- (AC_BaseButton *)applyBtn
{
    if (_applyBtn == nil) {
        _applyBtn = [AC_BaseButton TextBtnWithTitle:@"" titleColor:@"#FFFFFF" font:Semibold(16)];
        [_applyBtn setBackgroundImage:IMAGE(@"home_apply_small") forState:UIControlStateNormal];
        
    }
    return _applyBtn;
}

- (UILabel *)termLabel
{
    if (_termLabel == nil) {
        _termLabel = [UILabel LabelWithFont:Semibold(12) TextColor:@"#4497F5" Text:@""];
    }
    return _termLabel;
}

- (UILabel *)rateLabel
{
    if (_rateLabel == nil) {
        _rateLabel = [UILabel LabelWithFont:Semibold(12) TextColor:@"#4497F5" Text:@""];
    }
    return _rateLabel;
}

@end
