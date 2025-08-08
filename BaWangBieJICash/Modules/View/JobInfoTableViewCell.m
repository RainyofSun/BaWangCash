//
//  JobInfoTableViewCell.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "JobInfoTableViewCell.h"
#import "PickerCellModel.h"
#import "SelectedPresentView.h"
#import "AddressPresentView.h"

@interface JobInfoTableViewCell ()

@property (nonatomic ,strong) UILabel *title;

@property (nonatomic ,strong) UIImageView *person_cell;

@property (nonatomic ,strong) UITextField *textField;

@property (nonatomic ,strong) UILabel *saveKey;

@property (nonatomic ,strong) AC_BaseButton *arrowBtn;

@property (nonatomic , strong) UIButton *presentBtn;

@end

@implementation JobInfoTableViewCell

- (void)setUpSubView
{
    [super setUpSubView];

    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    
    [self.contentView addSubview:self.person_cell];
    [self.person_cell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@42);
        make.left.right.bottom.equalTo(@0);
    }];
    
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@7);
        make.bottom.equalTo(self.person_cell.mas_top).offset(-6);
        make.height.equalTo(@20);
    }];
    
    [self.person_cell addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.top.bottom.right.equalTo(@0);
    }];
    
    [self.person_cell addSubview:self.arrowBtn];
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.width.height.equalTo(@16);
        make.right.equalTo(@-16);
    }];
    
    [self.person_cell addSubview:self.presentBtn];
    [self.presentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.contentView addTarget:self action:@selector(showAdressPresentView)];
}

- (void)setJobModel:(PC_JobInfoModel_Counterclockwise *)jobModel
{
    _jobModel = jobModel;
    self.arrowBtn.hidden = YES;
    self.presentBtn.hidden = self.arrowBtn.hidden;
    self.textField.userInteractionEnabled = false;
    self.title.text = jobModel.pc_beck;
    
    //保存时传入的参数key，这个字段所对应的值会在调用保存接口时使用到，这里的值需要当做保存接口的参数上传请求
    self.saveKey.text = jobModel.pc_snob;
    
    NSInteger vancouver = jobModel.pc_vancouver;
    if (vancouver == 1) {
        self.textField.keyboardType = UIKeyboardTypePhonePad;
    }else{
        self.textField.keyboardType = UIKeyboardTypeDefault;
    }
    
    if ([jobModel.pc_bc isEqualToString:@"similarlylikea"]) {
        self.textField.placeholder = jobModel.pc_newsgroups;
        self.textField.text = self.getCurOptsTitle;
        
        self.arrowBtn.hidden = NO;
        self.presentBtn.hidden = self.arrowBtn.hidden;
    }else if ([jobModel.pc_bc isEqualToString:@"similarlylikeb"]) {
        self.textField.placeholder = jobModel.pc_newsgroups;
        self.textField.text = jobModel.pc_announcements;
        self.textField.userInteractionEnabled = true;
    }else if ([jobModel.pc_bc isEqualToString:@"similarlylikec"]) {
        self.textField.placeholder = jobModel.pc_newsgroups;
        
        self.textField.text = jobModel.pc_announcements;
    }
}

- (NSString *)getCurOptsTitle
{
    for (PC_JobInfoModel_Counterclockwise_Darkstar *optsModel in self.jobModel.pc_darkstar){
        if (self.jobModel.pc_announcements.integerValue == optsModel.pc_disposing) {
            return optsModel.pc_shoot;
        }
    }
    return @"";
}

- (void)arrowBtnCall
{
    self.arrowBtn.selected = !self.arrowBtn.selected;
    NSMutableArray *pickerModels = [NSMutableArray new];
    for (PC_JobInfoModel_Counterclockwise_Darkstar *model in self.jobModel.pc_darkstar) {
        PickerCellModel *pickerModel = [PickerCellModel new];
        pickerModel.title = model.pc_shoot;
        pickerModel.model = model;
        [pickerModels addObject:pickerModel];
    }

    // 弹起选择器
    SelectedPresentView *view = [SelectedPresentView new];
    view.models = pickerModels;
    __weakSelf;
    view.didSelctRowBlock = ^(PickerCellModel * _Nonnull rowModel) {
        __strongSelf;
        self.textField.text = ((PC_JobInfoModel_Counterclockwise_Darkstar *)rowModel.model).pc_shoot;

        self.jobModel.pc_announcements = FORMAT(@"%ld",((PC_JobInfoModel_Counterclockwise_Darkstar *)rowModel.model).pc_disposing);
    };
    
    view.didDismissBlock = ^{
        __strongSelf;
        self.arrowBtn.selected = !self.arrowBtn.selected;
    };
    
    [view show];
}

- (void)showAdressPresentView
{
    if (![self.jobModel.pc_bc isEqualToString:@"similarlylikec"]) return;
    AddressPresentView *view = [AddressPresentView new];
    __weakSelf;
    view.didSelectFinish = ^(NSString * _Nonnull adressCode, NSString * _Nonnull cityName) {
        __strongSelf;
        self.textField.text = adressCode;
        self.jobModel.pc_announcements = adressCode;
    };
    [view show];
}


- (void)textFieldEditing
{
    self.jobModel.pc_announcements = self.textField.text;
}

#pragma mark - init

- (UILabel *)title
{
    if (_title == nil) {
        _title = [UILabel LabelWithFont:Medium(14) TextColor:@"#000000" Text:@""];
    }
    return _title;
}

- (UIImageView *)person_cell
{
    if (_person_cell == nil) {
        ImgViewWithName(person_cell, @"person_cell");
        _person_cell = person_cell;
        _person_cell.userInteractionEnabled = YES;
    }
    return _person_cell;
}

- (UITextField *)textField
{
    if (_textField == nil){
        _textField = [UITextField new];
        _textField.textColor = HEXCOLOR(@"#000000");
        _textField.font = Regular(14);
        _textField.backgroundColor = UIColor.clearColor;
        [_textField addTarget:self action:@selector(textFieldEditing) forControlEvents:UIControlEventEditingChanged];
        NSDictionary *attr = @{NSFontAttributeName:Regular(14),NSForegroundColorAttributeName:HEXCOLOR(@"#808080")};
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"" attributes:attr];
        _textField.attributedPlaceholder = attrStr;
        
    }
    return _textField;
}

- (AC_BaseButton *)arrowBtn
{
    if (_arrowBtn == nil) {
        _arrowBtn = [AC_BaseButton new];
        _arrowBtn.userInteractionEnabled = false;
        [_arrowBtn setImage:IMAGE(@"contact_icon_arrow") forState:UIControlStateSelected];
        [_arrowBtn setImage:IMAGE(@"person_icon_arrow") forState:UIControlStateNormal];
    }
    return _arrowBtn;
}

- (UIButton *)presentBtn
{
    if (_presentBtn == nil) {
        _presentBtn = [UIButton new];
        [_presentBtn addTarget:self action:@selector(arrowBtnCall) forControlEvents:UIControlEventTouchUpInside];
    }
    return _presentBtn;
}

@end
