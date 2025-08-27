//
//  InfoPresentView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "InfoPresentView.h"
#import "DateOfBirthdayConfirmView.h"

@interface InfoPresentView ()

@property (nonatomic ,strong) AC_BaseButton *nextBtn;
@property (nonatomic ,strong) AC_BaseButton *closeBtn;

@property (nonatomic, strong) AC_BaseView *garyViewa;
@property (nonatomic, strong) AC_BaseView *garyViewb;
@property (nonatomic, strong) AC_BaseView *garyViewc;

@property (nonatomic, strong) UITextField *name;
@property (nonatomic, strong) UITextField *birth;
@property (nonatomic, strong) UITextField *number;

@end

@implementation InfoPresentView

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@455);
    }];
    
    ImgViewWithName(contentbk, @"logoff_bk");
    contentbk.userInteractionEnabled = YES;
    [self.contentView addSubview:contentbk];
    [contentbk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    UILabel *title = [UILabel LabelWithFont:Semibold(18) TextColor:@"#000000" Text:@"Information confirmation"];
    [contentbk addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.height.equalTo(@18);
        make.top.equalTo(@24);
    }];
    
    [contentbk addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@26);
        make.height.width.equalTo(@15);
        make.right.equalTo(@-18);
    }];
    
    UILabel* nametitle = [UILabel LabelWithFont:Medium(14) TextColor:@"#000000" Text:@"Full name"];
    [contentbk addSubview:nametitle];
    [nametitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.height.equalTo(@20);
        make.top.equalTo(title.mas_bottom).offset(32);
    }];
    [contentbk addSubview:self.garyViewa];
    [self.garyViewa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@18);
        make.right.equalTo(@-18);
        make.height.equalTo(@55);
        make.top.equalTo(nametitle.mas_bottom).offset(6);
    }];
    
    UILabel* birthtitle = [UILabel LabelWithFont:Medium(14) TextColor:@"#000000" Text:@"Birthday"];
    [contentbk addSubview:birthtitle];
    [birthtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.height.equalTo(@20);
        make.top.equalTo(self.garyViewa.mas_bottom).offset(14);
    }];
    [contentbk addSubview:self.garyViewb];
    [self.garyViewb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@18);
        make.right.equalTo(@-18);
        make.height.equalTo(@55);
        make.top.equalTo(birthtitle.mas_bottom).offset(6);
    }];
    
    UILabel* numbertitle = [UILabel LabelWithFont:Medium(14) TextColor:@"#000000" Text:@"Identification number"];
    [contentbk addSubview:numbertitle];
    [numbertitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.height.equalTo(@20);
        make.top.equalTo(self.garyViewb.mas_bottom).offset(14);
    }];
    [contentbk addSubview:self.garyViewc];
    [self.garyViewc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@18);
        make.right.equalTo(@-18);
        make.height.equalTo(@55);
        make.top.equalTo(numbertitle.mas_bottom).offset(6);
    }];
    
    
    [contentbk addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@32);
        make.height.equalTo(@54);
        make.right.bottom.equalTo(@-32);
        make.top.equalTo(self.garyViewc.mas_bottom).offset(24);
        make.bottom.equalTo(@32);
    }];
    
    [self addKeyboardAutoOffset];
}


- (void)setModel:(IDCardModel *)model
{
    _model = model;
    self.name.text = model.pc_shoot;
    self.birth.text = model.pc_flicks;
    self.number.text = model.pc_washington;
    
}



#pragma mark - event

- (void)nextSaveCall
{
    if (self.nextSaveBlock) self.nextSaveBlock(self.name.text,self.birth.text,self.number.text, self);
}

- (void)disMiss
{
    [super disMiss];
    
}

- (void)birthSelectViewCall
{
    DateOfBirthdayConfirmView *view = [DateOfBirthdayConfirmView new];
    [view show];
    view.didSelctRowBlock = ^(NSString * _Nonnull selectText) {
        self.birth.text = selectText;
    };
}


#pragma mark - init

- (AC_BaseButton *)nextBtn
{
    if (_nextBtn == nil) {
        _nextBtn = [AC_BaseButton TextBtnWithTitle:@"Next" titleColor:@"#FFFFFF" font:Semibold(16)];
        [_nextBtn setBackgroundImage:IMAGE(@"next_btn") forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextSaveCall) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}


- (AC_BaseButton *)closeBtn
{
    if (_closeBtn == nil) {
        _closeBtn = [AC_BaseButton ImageBtnWithImgName:@"address_icon_close"];
        [_closeBtn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (AC_BaseView *)garyViewa
{
    if (_garyViewa == nil) {
        _garyViewa = [AC_BaseView new];
        _garyViewa.backgroundColor =HEXCOLOR(@"#F6F6F6");
        [_garyViewa setCornerRadius:16];
        
        UITextField *textfield = [UITextField new];
        self.name = textfield;
        textfield.textColor = HEXCOLOR(@"#000000");
        textfield.font = Regular(14);
        textfield.backgroundColor = UIColor.clearColor;
        NSDictionary *attr = @{NSFontAttributeName:Regular(14),NSForegroundColorAttributeName:HEXCOLOR(@"#808080")};
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"Please enter your name." attributes:attr];
        textfield.attributedPlaceholder = attrStr;
        [_garyViewa addSubview:textfield];
        [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@5);
            make.left.equalTo(@24);
            make.right.bottom.equalTo(@-5);
            
        }];
    }
    return _garyViewa;
}

- (AC_BaseView *)garyViewb
{
    if (_garyViewb == nil) {
        _garyViewb = [AC_BaseView new];
        _garyViewb.backgroundColor =HEXCOLOR(@"#F6F6F6");
        [_garyViewb setCornerRadius:16];
       
//        [_garyViewb addSubview:self.birth];
//        [self.birth mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(@0);
//            make.left.equalTo(@24);
//            make.height.equalTo(@20);
//        }];
        UITextField *textfield = [UITextField new];
        self.birth = textfield;
        textfield.textColor = HEXCOLOR(@"#000000");
        textfield.font = Regular(14);
        textfield.backgroundColor = UIColor.clearColor;
        NSDictionary *attr = @{NSFontAttributeName:Regular(14),NSForegroundColorAttributeName:HEXCOLOR(@"#808080")};
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"Please select the time." attributes:attr];
        textfield.attributedPlaceholder = attrStr;
        [_garyViewb addSubview:textfield];
        [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@5);
            make.left.equalTo(@24);
            make.right.bottom.equalTo(@-5);
        }];
        
        AC_BaseView *view = [AC_BaseView new];
        view.backgroundColor = UIColor.clearColor;
        [view addTarget:self action:@selector(birthSelectViewCall)];
        [_garyViewb addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        
    }
    return _garyViewb;
}

- (AC_BaseView *)garyViewc
{
    if (_garyViewc == nil) {
        _garyViewc = [AC_BaseView new];
        _garyViewc.backgroundColor =HEXCOLOR(@"#F6F6F6");
        [_garyViewc setCornerRadius:16];
        
        UITextField *textfield = [UITextField new];
        self.number = textfield;
        textfield.textColor = HEXCOLOR(@"#000000");
        textfield.font = Regular(14);
        textfield.backgroundColor = UIColor.clearColor;
        NSDictionary *attr = @{NSFontAttributeName:Regular(14),NSForegroundColorAttributeName:HEXCOLOR(@"#808080")};
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"Please enter your ID card number." attributes:attr];
        textfield.attributedPlaceholder = attrStr;
        [_garyViewc addSubview:textfield];
        [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@5);
            make.left.equalTo(@24);
            make.right.bottom.equalTo(@-5);
        }];
    }
    return _garyViewc;
}

@end
