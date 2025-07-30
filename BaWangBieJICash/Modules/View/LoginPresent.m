//
//  LoginPresent.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "LoginPresent.h"
#import "LoginLogic.h"
#import "JumpTool.h"

@interface LoginPresent ()<UITextFieldDelegate>

@property (nonatomic ,assign) bool isAgree;

@property (nonatomic ,strong) UIImageView *bkImg;

@property (nonatomic, strong) UITextField *phoneTextField;

@property (nonatomic, strong) UITextField *codeTextField;

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
    
    
    [self.contentView addSubview:self.bkImg];
    [self.bkImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    NSString *savePhoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"savePhoneNumber"];
    if (savePhoneNumber) {
        self.phoneTextField.text = savePhoneNumber;
    }
    
    self.isAgree = true;
    
    [self addKeyboardAutoOffset];
}

- (void)setIsAgree:(bool)isAgree
{
    _isAgree = isAgree;
    if (isAgree){
        self.agreementImg.image = IMAGE(@"Credito_Pesos_gouxuan");
    }else{
        self.agreementImg.image = IMAGE(@"login_choose_disable");
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
        [self.getCodeBtn setTitle:@"Get code" forState:UIControlStateNormal];
    }else {
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
        
        ImgViewWithName(login_close, @"login_close");
        login_close.userInteractionEnabled = YES;
        [_bkImg addSubview:login_close];
        [login_close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@97);
            make.right.equalTo(@-18);
            make.height.width.equalTo(@15);
        }];
        
        AC_BaseButton *closeBtn = [AC_BaseButton buttonWithType:UIButtonTypeCustom];
        [closeBtn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
        [login_close addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@-10);
            make.right.equalTo(@10);
            make.height.width.equalTo(@30);
        }];
        
        
        UILabel *phoneNum = [UILabel LabelWithFont:Regular(16) TextColor:@"#FFFFFF" Text:@"Phone number"];
        [_bkImg addSubview:phoneNum];
        [phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(login_close.mas_bottom).offset(20);
            make.left.equalTo(@20);
            make.height.equalTo(@24);
        }];
        
        ImgViewWithName(numView, @"login_white");
        numView.userInteractionEnabled = YES;
        [_bkImg addSubview:numView];
        [numView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(phoneNum.mas_bottom).offset(8);
            make.left.equalTo(@20);
            make.height.equalTo(@55);
            make.right.equalTo(@-20);
        }];
        
        UIImageView *nationIcon = [[UIImageView alloc]init];
        [nationIcon sd_setImageWithURL:[NSURL URLWithString:LoginLogic.tool.loginConfig.pc_commenting.pc_timon]];
        [numView addSubview:nationIcon];
        [nationIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.left.equalTo(@20);
            make.height.equalTo(@20);
            make.width.equalTo(@30);
        }];
        
        UILabel *countryCode = [UILabel LabelWithFont:Regular(16) TextColor:@"#000000" Text:LoginLogic.tool.loginConfig.pc_commenting.pc_pumbaa];
        [numView addSubview:countryCode];
        [countryCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.left.equalTo(nationIcon.mas_right).offset(12);
            make.height.equalTo(@22);
        }];
        
        AC_BaseView *vLine = [AC_BaseView new];
        vLine.backgroundColor = HEXCOLOR(@"#E0D5FF");
        [numView addSubview:vLine];
        [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.left.equalTo(countryCode.mas_right).offset(10);
            make.height.equalTo(@19);
            make.width.equalTo(@1);
        }];
        
        [numView addSubview:self.phoneTextField];
        [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.left.equalTo(vLine.mas_right).offset(7);
            make.width.equalTo(@218);
            make.height.equalTo(@40);
        }];
        
        UILabel *verCode = [UILabel LabelWithFont:Regular(16) TextColor:@"#FFFFFF" Text:@"Verification Code"];
        [_bkImg addSubview:verCode];
        [verCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(numView.mas_bottom).offset(17);
            make.left.equalTo(@20);
            make.height.equalTo(@24);
        }];
        
        ImgViewWithName(codeView, @"login_white");
        codeView.userInteractionEnabled = YES;
        [_bkImg addSubview:codeView];
        [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(verCode.mas_bottom).offset(8);
            make.left.equalTo(@20);
            make.height.equalTo(@55);
            make.right.equalTo(@-20);
        }];
        
        [codeView addSubview:self.codeTextField];
        [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.left.equalTo(@16);
            make.width.equalTo(@218);
            make.height.equalTo(@40);
        }];
        
        [codeView addSubview:self.getCodeBtn];
        [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.right.equalTo(@-24);
            make.height.equalTo(@22);
        }];
        
        
        AC_BaseButton *tipBtn = [AC_BaseButton TextBtnWithTitle:@"Voice Verifcation Code?" titleColor:@"#FFFFFF" font:Regular(13)];
        [tipBtn addTarget:self action:@selector(voiceCodeCall) forControlEvents:UIControlEventTouchUpInside];
        [_bkImg addSubview:tipBtn];
        [tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(codeView.mas_bottom).offset(27);
            make.right.equalTo(@-20);
            make.height.equalTo(@18);
        }];
        
        [_bkImg addSubview:self.agreementImg];
        [self.agreementImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tipBtn.mas_bottom).offset(45);
            make.left.equalTo(@40);
            make.height.width.equalTo(@20);
        }];
        
        UILabel *readLab = [UILabel LabelWithFont:Regular(14) TextColor:@"#FFFFFF" Text:@"I have read and agree"];
        [self.bkImg addSubview:readLab];
        [readLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tipBtn.mas_bottom).offset(44);
            make.left.equalTo(self.agreementImg.mas_right).offset(1);
            make.height.equalTo(@22);
        }];
        
        ImgViewWithName(loanAgreement, @"privacy_Agreement");
        loanAgreement.contentMode = UIViewContentModeScaleAspectFit;
        loanAgreement.userInteractionEnabled = YES;
        [loanAgreement addTarget:self action:@selector(agreementClick)];
        [self.bkImg addSubview:loanAgreement];
        [loanAgreement mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(readLab.mas_right).offset(4);
            make.top.equalTo(tipBtn.mas_bottom).offset(45);
            make.height.equalTo(@20);
            make.width.equalTo(@125);
        }];
        
        [self.bkImg addSubview:self.signBtn];
        [self.signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@32);
            make.right.equalTo(@-32);
            make.height.equalTo(@53);
            make.top.equalTo(codeView.mas_bottom).offset(119);
        }];
        
    }
    return _bkImg;
}

- (UITextField *)phoneTextField
{
    if (_phoneTextField == nil) {
        _phoneTextField = [UITextField new];
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        _phoneTextField.textColor = HEXCOLOR(@"#000000");
        _phoneTextField.font = Regular(14);
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.delegate = self;
        
        NSDictionary *attr = @{NSFontAttributeName:Regular(14),NSForegroundColorAttributeName:HEXCOLOR(@"#727272")};
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"Enter verification code" attributes:attr];
        _phoneTextField.attributedPlaceholder = attrStr;
    }
    return _phoneTextField;
}

- (UITextField *)codeTextField
{
    if (_codeTextField == nil) {
        _codeTextField = [UITextField new];
        _codeTextField.textColor = HEXCOLOR(@"#000000");
        _codeTextField.font = Regular(14);
        _codeTextField.keyboardType = UIKeyboardTypePhonePad;
        _codeTextField.delegate = self;
        NSDictionary *attr = @{NSFontAttributeName:Regular(14),NSForegroundColorAttributeName:HEXCOLOR(@"#727272")};
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"Enter verification code" attributes:attr];
        _codeTextField.attributedPlaceholder = attrStr;
    }
    return _codeTextField;
}

- (AC_BaseButton *)getCodeBtn
{
    if (_getCodeBtn == nil) {
        _getCodeBtn = [AC_BaseButton TextBtnWithTitle:@"Get code" titleColor:@"#4497F5" font:Semibold(16)];
        [_getCodeBtn addTarget:self action:@selector(getCodeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCodeBtn;
}

- (AC_BaseButton *)signBtn
{
    if (_signBtn == nil) {
        _signBtn = [AC_BaseButton TextBtnWithTitle:@"Sign in" titleColor:@"#000000" font:Semibold(18)];
        [_signBtn setBackgroundImage:IMAGE(@"login_sign_bk") forState:UIControlStateNormal];
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
