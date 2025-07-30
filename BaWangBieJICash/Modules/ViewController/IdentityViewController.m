//
//  IdentityViewController.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "IdentityViewController.h"
#import "IDCardModel.h"
#import "UserIdentifiInfoModel.h"
#import "AppAuthTool+ID.h"
#import "AuthSelectedPresentView.h"
#import "UpCardPersentView.h"
#import "UpFacePersentView.h"
#import "PhotoTool.h"
#import "InfoPresentView.h"
#import "CameraViewController.h"

@interface IdentityViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic ,strong) AC_BaseButton *nextBtn;

@property (nonatomic, strong) IDCardModel *idCardModel;

@property (nonatomic, copy) NSString *flicks;
@property (nonatomic, copy) NSString *washington;
@property (nonatomic, copy) NSString *shoot;

@property (nonatomic, strong) AC_BaseButton *cameraIdCardBtn;
@property (nonatomic, strong) AC_BaseButton *cameraFaceBtn;

@property (nonatomic ,strong) UserIdentifiInfoModel *userInModel;

@property (nonatomic, strong) UIImageView *idCardImg;
@property (nonatomic, strong) UIImageView *faceImg;

@property (nonatomic, assign) bool IsIDCard;

@property (nonatomic, assign) bool isCardSucc;

@property (nonatomic, assign) bool isAllSucc;

@property (nonatomic, copy) NSString *selectTypeTitle;

@end

@implementation IdentityViewController

- (void)setUpSubView
{
    [super setUpSubView];
    
    
    ImgViewWithName(topView, @"bj_img");
    topView.userInteractionEnabled = YES;
    [self.view insertSubview:topView atIndex:0];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.equalTo(@98);
    }];
    
    // 照片上传类型: 0.拍照+相册; 1.拍照
    NSInteger upType = self.userInModel.pc_alberta;
    
    ImgViewWithName(idCardImg, @"");
    self.idCardImg = idCardImg;
    [self.idCardImg setCornerRadius:12];
    self.idCardImg.contentMode = UIViewContentModeScaleAspectFill;
    idCardImg.userInteractionEnabled = YES;
    [self.view addSubview:idCardImg];
    [idCardImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(40);
        make.height.equalTo(idCardImg.mas_width).multipliedBy(170.0/261.0);
        make.left.equalTo(@57);
        make.right.equalTo(@-57);
    }];
    
    
    [self.cameraIdCardBtn addTarget:self action:@selector(idCardCameraCall) forControlEvents:UIControlEventTouchUpInside];
    [idCardImg addSubview:self.cameraIdCardBtn];
    [self.cameraIdCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@48);
        make.center.equalTo(@0);
    }];
    
    UILabel *idCardLab = [UILabel LabelWithFont:Medium(16) TextColor:@"#000000" Text:@"Front of ID carde"];
    [self.view addSubview:idCardLab];
    [idCardLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(idCardImg.mas_bottom).offset(16);
        make.centerX.equalTo(@0);
        make.height.equalTo(@20);
    }];
    
    ImgViewWithName(faceImg, @"");
    self.faceImg = faceImg;
    [self.faceImg setCornerRadius:12];
    self.faceImg.contentMode = UIViewContentModeScaleAspectFill;
    faceImg.userInteractionEnabled = YES;
    [self.view addSubview:faceImg];
    [faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(idCardLab.mas_bottom).offset(40);
        make.height.equalTo(faceImg.mas_width).multipliedBy(170.0/261.0);
        make.left.equalTo(@57);
        make.right.equalTo(@-57);
    }];
    
   
    [self.cameraFaceBtn addTarget:self action:@selector(faceCameraCall) forControlEvents:UIControlEventTouchUpInside];
   
    [faceImg addSubview:self.cameraFaceBtn];
    [self.cameraFaceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@48);
        make.center.equalTo(@0);
    }];
    
    UILabel *faceLab = [UILabel LabelWithFont:Medium(16) TextColor:@"#000000" Text:@"Face Recognition"];
    [self.view addSubview:faceLab];
    [faceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(faceImg.mas_bottom).offset(16);
        make.centerX.equalTo(@0);
        make.height.equalTo(@20);
    }];
    
    
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@32);
        make.right.equalTo(@-32);
        make.height.equalTo(@54);
        make.bottom.equalTo(@-20);
    }];
    
    
    [ProgressHud showLoading];
    __weakSelf;
    [AppAuthTool.tool getUserIDModelWithBlock:^(UserIdentifiInfoModel * _Nullable model) {
        __strongSelf;
        self.userInModel = model;
        [ProgressHud hiddenLoading];
    }];
}

- (void)setUserInModel:(UserIdentifiInfoModel *)userInModel
{
    _userInModel = userInModel;
    
    // 验证是否通过:状态 0未完成 1已完成
    NSInteger idcardSucc = userInModel.pc_acquired.pc_usenet;
    NSInteger faceSucc = self.userInModel.pc_arts.pc_usenet;
    
    self.selectTypeTitle = userInModel.pc_acquired.pc_successfully;
    
    NSString *cameraUpText;
    NSString *cameraDwonText;
    
    if (idcardSucc == 1) {
        [self.idCardImg sd_setImageWithURL:StringToURL(userInModel.pc_acquired.pc_merely)];
        self.isCardSucc = true;
        cameraUpText = @"icon_complete_white";
        self.cameraIdCardBtn.userInteractionEnabled = false;
        
    } else {
        self.idCardImg.image = IMAGE(@"img_idCard_up");
        cameraUpText = @"camera_up";
    }
    
    if (faceSucc == 1) {
        [self.faceImg sd_setImageWithURL:StringToURL(userInModel.pc_arts.pc_merely)];
        cameraDwonText = @"icon_complete_white";
        self.cameraFaceBtn.userInteractionEnabled = false;
        self.isAllSucc = true;
    } else {
        self.faceImg.image = IMAGE(@"img_Face");
        cameraDwonText = @"camera_up";
    }
    
    [self.cameraIdCardBtn setBackgroundImage:IMAGE(cameraUpText) forState:UIControlStateNormal];
    [self.cameraFaceBtn setBackgroundImage:IMAGE(cameraDwonText) forState:UIControlStateNormal];
}

- (void)showCameraIsFront:(BOOL)isFront
{
    [PhotoTool.tool isGetCameraAuth:^(BOOL granted) {
        if (!granted) return;
        
        CameraViewController *vc = [CameraViewController new];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        vc.cameraPos = isFront ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
        __weakSelf;
        vc.didTakePhoto = ^(UIImage * _Nonnull photo) {
            __strongSelf;
            // 拍照完成的回调
            if (self.IsIDCard) {
                self.idCardImg.image = photo;
                [self updateWithIdCardWithMetro:1];
            }else{
                self.faceImg.image = photo;
                [self updateWithFace];
            }
        };
        [self presentViewController:vc animated:true completion:nil];
    }];
}

- (void)showPhoto
{
    [PhotoTool.tool isGetPhotoAuth:^(BOOL granted) {
        if (!granted) return;
        
        UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
        [self presentViewController:imagePicker animated:YES completion:nil];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }];
}

#pragma mark - Event

/// 卡片点击
- (void)idCardCameraCall
{
    self.IsIDCard = true;
    
    AuthSelectedPresentView *selectView = [AuthSelectedPresentView new];
    __weakSelf
    selectView.disMissBlock = ^(NSString * _Nonnull selectType) {
        __strongSelf;
        self.selectTypeTitle = selectType;
        UpCardPersentView *view = [UpCardPersentView new];
        view.disMissBlock = ^{
            __strongSelf;
            [self showPhotoChoseIsFront:false];
        };
        [view show];
    };
    [selectView show];
   
   
}

/// 人脸点击
- (void)faceCameraCall
{
    if (!self.isCardSucc) {
        // 显示文案
        [ProgressHud showMessage:@"Please upload your ID card first"];
        return;
    }
    self.IsIDCard = false;
    UpFacePersentView *view = [UpFacePersentView new];
    [view show];
    __weakSelf
    view.disMissBlock = ^{
        __strongSelf;
        [self showCameraIsFront:true];
    };
    [PositionTool.tool startReportWithType:RiskPointType_Selfie];
    
}

- (void)nextBtnClick
{
    if (self.isAllSucc) {
        [self backBtnClick];
    }else {
        if (!self.isCardSucc) {
            [self idCardCameraCall];
        }else {
            [self faceCameraCall];
        }
    }
}


/// IdCard接口上传
- (void)updateWithIdCardWithMetro:(NSInteger)metro
{
    NSDictionary *dict = @{
        @"metro":@(metro),
            @"disposing":@11,
            @"successfully":self.selectTypeTitle
        };
    UIImage *img = self.idCardImg.image;
    [ProgressHud showLoading];
    __weakSelf;
    [NetMonitorTool.tool postWithPath:@"/before/king" Parameters:dict UploadImg:img ImgParameterName:@"withNotably" ProgressBlock:nil SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        __strongSelf;
        [ProgressHud hiddenLoading];
        if (!responseModel.success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHud showMessage:responseModel.pc_flag];
            });
            self.idCardImg.image = IMAGE(@"img_idCard_up");
            return;
        }
        
        self.idCardModel = [IDCardModel ACModel_withDict:responseModel.pc_portal];
        
        __block InfoPresentView *view = [InfoPresentView new];
        view.model = self.idCardModel;
        __weakSelf;
        view.nextSaveBlock = ^(NSString * _Nonnull name, NSString * _Nonnull birth, NSString * _Nonnull number, InfoPresentView * _Nonnull infoView) {
            __strongSelf;
            [self saveInterfaceWithName:name birth:birth number:number Completion:^(BOOL success) {
                if (success) {
                    [infoView disMiss];
                }
            }];
        };
        [view show];
        [PositionTool.tool endReportWithType: RiskPointType_FrontPhoto];
        
    } FailBlock:^(NSError * _Nonnull error) {
        [ProgressHud hiddenLoading];
    }];
}

/// Face接口上传
- (void)updateWithFace
{
    NSDictionary *dict = @{
            @"metro":@1,
            @"disposing":@10,
        };
    UIImage *img = self.faceImg.image;
    [ProgressHud showLoading];
    [NetMonitorTool.tool postWithPath:@"/before/king" Parameters:dict UploadImg:img ImgParameterName:@"withNotably" ProgressBlock:nil SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        [ProgressHud hiddenLoading];
        self.isAllSucc = responseModel.success;
        
        if (!responseModel.success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHud showMessage:responseModel.pc_flag];
            });
            return;
        }
        self.cameraFaceBtn.userInteractionEnabled = false;
        [self.cameraFaceBtn setBackgroundImage:IMAGE(@"icon_complete_white") forState:UIControlStateNormal];
        [PositionTool.tool endReportWithType:RiskPointType_Selfie];
        
    } FailBlock:^(NSError * _Nonnull error) {
        [ProgressHud hiddenLoading];
    }];
}

- (void)setIdCardModel:(IDCardModel *)idCardModel
{
    _idCardModel = idCardModel;
    
    self.flicks = self.idCardModel.pc_flicks;
    self.washington = self.idCardModel.pc_washington;
    self.shoot = self.idCardModel.pc_shoot;
}

/// 保存用户身份证信息
- (void)saveInterfaceWithName:(NSString *)name birth:(NSString *)birth number:(NSString *)number Completion:(void(^)(BOOL success))completion
{
    NSDictionary *dict = @{
            @"flicks":birth,
            @"washington":number,
            @"shoot":name,
            @"disposing":@11,
            @"successfully":self.selectTypeTitle
        };

    /// 保存用户身份证信息
    [ProgressHud showLoading];
    __weakSelf;
    [NetMonitorTool.tool postWithPath:@"/before/lion" Parameters:dict SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        [ProgressHud hiddenLoading];
        __strongSelf;
        self.isCardSucc = responseModel.success;
        if (!responseModel.success) {
//            PC_tipsPresent *view = [PC_tipsPresent new];
//            view.detailab.text = responseModel.pc_flag;
//            [view show];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHud showMessage:responseModel.pc_flag];
            });
            completion(false);
            return;
        }
    
        self.cameraFaceBtn.userInteractionEnabled = true;
        self.cameraIdCardBtn.userInteractionEnabled = false;
        [self.cameraIdCardBtn setBackgroundImage:IMAGE(@"icon_complete_white") forState:UIControlStateNormal];
        completion(true);
    } FailBlock:^(NSError * _Nonnull error) {
        completion(false);
        [ProgressHud hiddenLoading];
    }];
}

#pragma mark - delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (self.IsIDCard) {
        self.idCardImg.image = image;
        [self updateWithIdCardWithMetro:2];
    }else{
        self.faceImg.image = image;
        [self updateWithFace];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - Source Type

- (void)showPhotoChoseIsFront:(BOOL)isFront
{
    
    if (self.userInModel.pc_alberta == 0) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        [PositionTool.tool startReportWithType:RiskPointType_FrontPhoto];
        __weakSelf;
        UIAlertAction *photo = [UIAlertAction actionWithTitle:@"Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            __strongSelf;
            [self showPhoto];
        }];
        
        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self showCameraIsFront:isFront];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        [vc addAction:photo];
        [vc addAction:camera];
        [vc addAction:cancel];
        
        [self presentViewController:vc animated:true completion:nil];
    }else{
        [self showCameraIsFront:isFront];
    }
}

//- (void)showOnlyCameraIsFront:(BOOL)isFront
//{
//
//    if (self.userInModel.pc_alberta == 0) {
//        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
//
//        __weakSelf;
//        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            __strongSelf;
//            [self showCameraIsFront:isFront];
//        }];
//
//        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
//
//        [vc addAction:camera];
//        [vc addAction:cancel];
//
//        [self presentViewController:vc animated:true completion:nil];
//    }
//}

- (void)reconfirmOptionsWithComfirmBlock:(void(^)(void))comfirmBlock
{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        comfirmBlock();
        
    }];

    UIAlertAction *retake = [UIAlertAction actionWithTitle:@"Retake" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [vc dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [vc addAction:confirm];
    [vc addAction:retake];
    [vc addAction:cancel];
    
    [self presentViewController:vc animated:true completion:nil];
}

#pragma mark - init

- (AC_BaseButton *)cameraIdCardBtn
{
    if (_cameraIdCardBtn == nil) {
        _cameraIdCardBtn = [AC_BaseButton new];
    }
    return _cameraIdCardBtn;
}

- (AC_BaseButton *)cameraFaceBtn
{
    if (_cameraFaceBtn == nil) {
        _cameraFaceBtn = [AC_BaseButton new];
    }
    return _cameraFaceBtn;
}

- (AC_BaseButton *)nextBtn
{
    if (_nextBtn == nil) {
        _nextBtn = [AC_BaseButton TextBtnWithTitle:@"Next" titleColor:@"#FFFFFF" font:Semibold(18)];
        [_nextBtn setBackgroundImage:IMAGE(@"next_btn") forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

@end
