//
//  PersonalTableViewCell.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "PersonalTableViewCell.h"
#import "SelectedPresentView.h"
#import "AddressPresentView.h"

@interface PersonalTableViewCell ()<UITextFieldDelegate>

@property (nonatomic ,strong) UILabel *title;

@property (nonatomic ,strong) UIImageView *person_cell;

@property (nonatomic ,strong) UITextField *textField;

@property (nonatomic ,strong) UILabel *saveKey;

@property (nonatomic ,strong) AC_BaseButton *arrowBtn;

@property (nonatomic , strong) UIButton *presentBtn;

@end

@implementation PersonalTableViewCell

- (void)setUpSubView
{
    [super setUpSubView];

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
        make.top.right.bottom.equalTo(@0);
       
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

- (void)setUserModel:(PC_UserInfoModel_Counterclockwise *)userModel
{
    _userModel = userModel;
    
    self.arrowBtn.hidden = YES;
    self.presentBtn.hidden = self.arrowBtn.hidden;
    self.title.text = userModel.pc_beck;
    self.textField.userInteractionEnabled = false;
    
    //保存时传入的参数key，这个字段所对应的值会在调用保存接口时使用到，这里的值需要当做保存接口的参数上传请求
    self.saveKey.text = userModel.pc_snob;
    
    NSInteger vancouver = userModel.pc_vancouver;
    if (vancouver == 1) {
        self.textField.keyboardType = UIKeyboardTypePhonePad;
    }else{
        self.textField.keyboardType = UIKeyboardTypeDefault;
    }
    
    /*
     '"bc":"enum"',
     '"bc":"txt"',
     '"bc":"citySelect"',
     混淆后
     '"bc":"similarlylikea"',
     '"bc":"similarlylikeb"',
     '"bc":"similarlylikec"',
     */
    if ([userModel.pc_bc isEqualToString:@"similarlylikea"]) {
        
        self.textField.placeholder = userModel.pc_newsgroups;
        self.textField.text = self.getCurOptsTitle;
        self.arrowBtn.hidden = NO;
        self.presentBtn.hidden = self.arrowBtn.hidden;
    }else if ([userModel.pc_bc isEqualToString:@"similarlylikeb"]) {
        self.textField.placeholder = userModel.pc_newsgroups;
        self.textField.text = userModel.pc_announcements;
        self.textField.userInteractionEnabled = true;
    }else if ([userModel.pc_bc isEqualToString:@"similarlylikec"]){
        
        self.textField.placeholder = userModel.pc_newsgroups;
        
        self.textField.text = userModel.pc_announcements;
        /*[PC_AdressTool.tool getAdressWithCode:userModel.pc_announcements];*/
    }
}

- (NSString *)getCurOptsTitle
{
    for (PC_PersonInfoModel_Counterclockwise_Darkstar *optsModel in self.userModel.pc_darkstar){
        if (self.userModel.pc_announcements.integerValue == optsModel.pc_disposing ) {
            return optsModel.pc_shoot;
        }
    }
    return @"";
}

- (void)arrowBtnCall
{
    self.arrowBtn.selected = !self.arrowBtn.selected;
    NSMutableArray *pickerModels = [NSMutableArray new];
    for (PC_PersonInfoModel_Counterclockwise_Darkstar *model in self.userModel.pc_darkstar) {
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
        self.textField.text = ((PC_PersonInfoModel_Counterclockwise_Darkstar *)rowModel.model).pc_shoot;
        NSString *selectId = FORMAT(@"%ld",((PC_PersonInfoModel_Counterclockwise_Darkstar *)rowModel.model).pc_disposing);
        self.userModel.pc_announcements = selectId;
    };
    view.didDismissBlock = ^{
        __strongSelf;
        self.arrowBtn.selected = !self.arrowBtn.selected;
    };
    [view show];
}

- (void)textFieldEditing
{
    self.userModel.pc_announcements = self.textField.text;
}

- (void)showAdressPresentView
{
    if (![self.userModel.pc_bc isEqualToString:@"similarlylikec"]) return;
    AddressPresentView *view = [AddressPresentView new];
    __weakSelf;
    view.didSelectFinish = ^(NSString * _Nonnull adressCode, NSString * _Nonnull cityName) {
        __strongSelf;
        self.textField.text = adressCode;
        self.userModel.pc_announcements = adressCode;
    };
    [view show];
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
