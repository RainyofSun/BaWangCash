//
//  LoginPresent.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "LoginPresent.h"
#import "LoginLogic.h"
#import "JumpTool.h"
#import "CustomTextFiled.h"

@interface LoginPresent ()<UITextFieldDelegate>

@property (nonatomic ,assign) bool isAgree;

@property (nonatomic ,strong) UIImageView *bkImg;

@property (nonatomic, strong) CustomTextFiled *phoneTextField;

@property (nonatomic, strong) CustomTextFiled *codeTextField;

@property (nonatomic, strong) AC_BaseButton *getCodeBtn;

@property (nonatomic, strong) AC_BaseButton *signBtn;

@property (nonatomic, copy) NSString *phoenNumber;

/// 验证码过期倒计时，秒
@property (nonatomic, assign) NSInteger codeExpiry;

/// 验证码
@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) NSInteger cuurentCodeExpiry;
@property (nonatomic, strong) NSTimer *timer;

// 协议是否同意
@property (nonatomic ,strong) UIImageView *agreementImg;

@end

@implementation LoginPresent

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.contentView addSubview:self.bkImg];
    [self.bkImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    NSString *savePhoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"savePhoneNumber"];
    if (savePhoneNumber) {
        self.phoneTextField.text = savePhoneNumber;
    }
    
    self.isAgree = true;
}

- (void)setIsAgree:(bool)isAgree
{
    _isAgree = isAgree;
    if (isAgree){
        self.agreementImg.image = IMAGE(@"login_chose_yes");
    }else{
        self.agreementImg.image = IMAGE(@"login_chose_no");
    }
}

- (void)setCodeExpiry:(NSInteger)codeExpiry
{
    _codeExpiry = codeExpiry;
    self.cuurentCodeExpiry = codeExpiry;
    [self timer];
}

- (void)setCuurentCodeExpiry:(NSInteger)cuurentCodeExpiry
{
    _cuurentCodeExpiry = cuurentCodeExpiry;
    self.getCodeBtn.enabled = cuurentCodeExpiry <= 0;
    
    if (cuurentCodeExpiry <= 0) {
        [self.getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.getCodeBtn setTitle:@"Get code" forState:UIControlStateNormal];
    }else {
        [self.getCodeBtn setTitleColor:[UIColor colorWithHexString:@"#9471F3"] forState:UIControlStateNormal];
        NSString *title = FORMAT(@"%lds",cuurentCodeExpiry);
        [self.getCodeBtn setTitle:title forState:UIControlStateNormal];
    }
    
}

- (void)setCode:(NSString *)code
{
    _code = code;
    if ([code isExist]) self.codeTextField.text = code;
}

#pragma mark - func

- (void)signClick
{
    self.phoenNumber = self.phoneTextField.text;
    self.code = self.codeTextField.text;
    
    if (!self.isAgree) {
        [ProgressHud showMessage:@"Please read and agree to the agreement"];
        return;
    }else {
        
        __weakSelf;
        [LoginLogic.tool loginWithMobile:self.phoenNumber Code:self.code WithBlock:^(bool succ) {
            __strongSelf;
            if (!succ) {
                return;
            }
            [self disMiss];
            [PositionTool.tool endReportWithType:RiskPointType_Register];
        }];
        
        self.phoenNumber = self.phoneTextField.text;
        [[NSUserDefaults standardUserDefaults] setObject:self.phoenNumber forKey:@"savePhoneNumber"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

- (void)getCodeClick
{
    NSString *number = self.phoneTextField.text;
    __weakSelf;
    [LoginLogic.tool sendLoginCodeWithMobile:number SuccBlock:^(NSString * _Nonnull mobile, NSInteger expiry, bool succ) {
        __strongSelf;
        if (succ) {
            self.codeExpiry = expiry;
            
            [PositionTool.tool startReportWithType:RiskPointType_Register];
            [self sendVerificationCode];
            
        }
    }];
}

// 语音验证码点击
- (void)voiceCodeCall
{
    
    NSString *number = self.phoneTextField.text;
    
    [LoginLogic.tool getLoginVoiceCodeWithMobile:number WithBlock:^(bool succ) {
        if (succ) {
            [PositionTool.tool startReportWithType:RiskPointType_Register];
            [self sendVerificationCode];
        }
    }];
    
}

// 协议是否同意
- (void)agreeementCall
{
    self.isAgree = !self.isAgree;
}
// 协议
- (void)agreementClick
{
    [self disMiss];
    NSString *url = LoginLogic.tool.loginConfig.pc_lion;
    [JumpTool.tool jumpWithStr:url];
}

#pragma mark - delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.codeTextField) {
        
    }
    NSInteger maxLength = textField == self.codeTextField ? 6 : 20;
    NSString *currentText = textField.text ?: @"";
    NSString *newText = [currentText stringByReplacingCharactersInRange:range withString:string];
    
    return newText.length <= maxLength;
}

// 发送验证码，成功后光标会自动定
- (void)sendVerificationCode {
    // 发送验证码的代码
    [self performSelector:@selector(focusOnVerificationCodeTextField) withObject:nil afterDelay:0.5]; // 假设验证码发送后0.5秒回调成功
}
 
- (void)focusOnVerificationCodeTextField {
    [self.codeTextField becomeFirstResponder]; // 将光标定位到验证码输入框
}

#pragma mark - init

- (UIImageView *)bkImg
{
    if (_bkImg == nil) {
        _bkImg = [[UIImageView alloc]initWithImage:IMAGE(@"login_bk")];
        _bkImg.userInteractionEnabled = true;
        
        AC_BaseButton *closeBtn = [AC_BaseButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setImage:[UIImage imageNamed:@"login_close"] forState:UIControlStateNormal];
        
        [closeBtn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
        [_bkImg addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kStatusBarHeight);
            make.left.equalTo(@16);
            make.height.width.equalTo(@30);
        }];
        
        
        UIImageView *cardView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_card"]];
        cardView.userInteractionEnabled = YES;
        [_bkImg addSubview:cardView];
        
        [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(closeBtn.mas_bottom).offset(kScreenHeight * 0.2);
            make.centerX.mas_equalTo(_bkImg);
        }];
        
        [cardView addSubview:self.phoneTextField];
        [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cardView.mas_left).offset(25);
            make.right.mas_equalTo(cardView.mas_right).offset(-25);
            make.top.mas_equalTo(cardView.mas_top).offset(64);
            make.height.equalTo(@52);
        }];
        
        [cardView addSubview:self.codeTextField];
        [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.phoneTextField.mas_bottom).offset(20);
            make.left.width.height.equalTo(self.phoneTextField);
        }];
        
        AC_BaseButton *tipBtn = [AC_BaseButton ImageBtnWithImgName:@"login_voice"];
        [tipBtn addTarget:self action:@selector(voiceCodeCall) forControlEvents:UIControlEventTouchUpInside];
        [cardView addSubview:tipBtn];
        [tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.codeTextField.mas_bottom).offset(27);
            make.centerX.equalTo(cardView);
        }];
        
        [cardView addSubview:self.signBtn];
        [self.signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@32);
            make.right.equalTo(@-32);
            make.height.equalTo(@54);
            make.top.equalTo(tipBtn.mas_bottom).offset(85);
        }];
        
        [_bkImg addSubview:self.agreementImg];
        [self.agreementImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cardView.mas_bottom).offset(80);
            make.left.equalTo(@40);
            make.height.width.equalTo(@20);
        }];
        
        UILabel *readLab = [UILabel LabelWithFont:Regular(13) TextColor:@"#717171" Text:@"I have read and agree"];
        [self.bkImg addSubview:readLab];
        [readLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.agreementImg);
            make.left.equalTo(self.agreementImg.mas_right).offset(10);
            make.height.equalTo(@22);
        }];
        
        UIButton *privateLab = [UIButton TextBtnWithTitle:@"<Privacy Agreement>" titleColor:@"#9471F3" font:Regular(13)];
        [privateLab addTarget:self action:@selector(agreementClick) forControlEvents:UIControlEventTouchUpInside];
        
        [_bkImg addSubview:privateLab];
        [privateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(readLab.mas_right).offset(4);
            make.centerY.equalTo(readLab);
            make.height.equalTo(@20);
            make.width.greaterThanOrEqualTo(@125);
        }];
        
    }
    return _bkImg;
}

- (CustomTextFiled *)phoneTextField
{
    if (_phoneTextField == nil) {
        _phoneTextField = [CustomTextFiled new];
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        _phoneTextField.textColor = HEXCOLOR(@"#000000");
        _phoneTextField.font = Regular(16);
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.delegate = self;
        _phoneTextField.backgroundColor = [UIColor colorWithHexString:@"#F9F5FD"];
        _phoneTextField.layer.cornerRadius = 12;
        _phoneTextField.clipsToBounds = YES;
        
        NSDictionary *attr = @{NSFontAttributeName:Regular(16),NSForegroundColorAttributeName:HEXCOLOR(@"#727272")};
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"Enter verification code" attributes:attr];
        _phoneTextField.attributedPlaceholder = attrStr;
        
        UILabel *countryCode = [UILabel LabelWithFont:Regular(16) TextColor:@"#000000" Text:[NSString stringWithFormat:@"+%@", LoginLogic.tool.loginConfig.pc_commenting.pc_pumbaa]];
        countryCode.frame = CGRectMake(0, 0, 30, 30);
        _phoneTextField.leftView = countryCode;
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _phoneTextField;
}

- (CustomTextFiled *)codeTextField
{
    if (_codeTextField == nil) {
        _codeTextField = [CustomTextFiled new];
        _codeTextField.textColor = HEXCOLOR(@"#000000");
        _codeTextField.font = Regular(16);
        _codeTextField.keyboardType = UIKeyboardTypePhonePad;
        _codeTextField.delegate = self;
        _codeTextField.backgroundColor = [UIColor colorWithHexString:@"#F9F5FD"];
        _codeTextField.layer.cornerRadius = 12;
        _codeTextField.clipsToBounds = YES;
        
        NSDictionary *attr = @{NSFontAttributeName:Regular(16),NSForegroundColorAttributeName:HEXCOLOR(@"#727272")};
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"Enter verification code" attributes:attr];
        _codeTextField.attributedPlaceholder = attrStr;
        
        self.getCodeBtn.frame = CGRectMake(0, 0, 80, 62);
        _codeTextField.rightView = self.getCodeBtn;
        _codeTextField.rightViewMode = UITextFieldViewModeAlways;
        
    }
    return _codeTextField;
}

- (AC_BaseButton *)getCodeBtn
{
    if (_getCodeBtn == nil) {
        _getCodeBtn = [AC_BaseButton TextBtnWithTitle:@"Get code" titleColor:@"#FFFFFF" font:Semibold(16)];
        _getCodeBtn.backgroundColor = MAIN_COLOR;
        _getCodeBtn.layer.cornerRadius = 10;
        _getCodeBtn.clipsToBounds = YES;
        [_getCodeBtn addTarget:self action:@selector(getCodeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCodeBtn;
}

- (AC_BaseButton *)signBtn
{
    if (_signBtn == nil) {
        _signBtn = [AC_BaseButton TextBtnWithTitle:@"Login" titleColor:@"#FFFFFF" font:Semibold(18)];
        _signBtn.backgroundColor = MAIN_COLOR;
        _signBtn.layer.cornerRadius = 27;
        _signBtn.clipsToBounds = YES;
        
        [_signBtn addTarget:self action:@selector(signClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signBtn;
}


- (NSTimer *)timer
{
    if (_timer == nil){
        __weakSelf;
        _timer = [NSTimer timerWithTimeInterval:1.0 repeats:true block:^(NSTimer * _Nonnull timer) {
            __strongSelf;
            
            self.cuurentCodeExpiry -= 1;
            if (self.cuurentCodeExpiry <= 0){
                [self.timer invalidate];
                self.timer = nil;
            }
            
        }];
        
        [NSRunLoop.mainRunLoop addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}


- (UIImageView *)agreementImg
{
    if (_agreementImg == nil) {
        _agreementImg = [UIImageView new];
        _agreementImg.userInteractionEnabled = YES;
        [_agreementImg addTarget:self action:@selector(agreeementCall)];
    }
    return _agreementImg;
}

@end
