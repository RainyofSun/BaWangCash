//
//  CameraViewController.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "CameraViewController.h"
#import "BaseCameraRetView.h"
#import <CoreMotion/CoreMotion.h>
#import "UIImage+FixOrientation.h"

@interface CameraViewController ()<AVCapturePhotoCaptureDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;
@property (nonatomic, strong) AVCapturePhotoOutput *photoOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (nonatomic, assign) UIDeviceOrientation deviceOrientation;
@property (nonatomic, assign) UIDeviceOrientation imageOrientation;

@property (nonatomic , strong) AC_BaseView *takeView;

@property (nonatomic, strong) AC_BaseButton *cancelBtn;

@property (nonatomic , strong) BaseCameraRetView *cameraRetView;

@end

@implementation CameraViewController

- (void)setUpSubView
{
    self.navBar.hidden = true;
    [self setupCamera];
    [self addFocusGest];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionInterrupted:) name:AVCaptureSessionWasInterruptedNotification object:self.captureSession];
    
    [self.view addSubview:self.takeView];
    [self.takeView addTarget:self action:@selector(capturePhoto)];
    [self.takeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@100);
        make.bottom.equalTo(@((kBottomHeight+30)*-1));
        make.centerX.equalTo(@0);
    }];
    
    [self.view addSubview:self.cancelBtn];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@40);
        make.right.equalTo(@-70);
        make.centerY.equalTo(self.takeView.mas_centerY);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startMontionUpdate];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.captureSession stopRunning];
    [self stopMontionUpdate];
}

#pragma mark - Device Setup

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    AVCaptureDeviceDiscoverySession *discoverySession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType:AVMediaTypeVideo position:position];
    for (AVCaptureDevice *device in discoverySession.devices) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}

- (void)setupCamera
{
    // 创建会话
    self.captureSession = [[AVCaptureSession alloc] init];
    if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    }
    
    // 配置输入设备
    AVCaptureDevice *cameraDevice = [self cameraWithPosition:self.cameraPos];
    self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:cameraDevice error:nil];
    if ([self.captureSession canAddInput:self.deviceInput]) {
        [self.captureSession addInput:self.deviceInput];
    }
    
    // 配置输出
    self.photoOutput = [[AVCapturePhotoOutput alloc] init];
    if ([self.captureSession canAddOutput:self.photoOutput]) {
        [self.captureSession addOutput:self.photoOutput];
    }
    
    // 创建预览层
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    // 启动会话
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.captureSession startRunning];
    });
}

#pragma mark - 拍照

- (void)capturePhoto
{
    AVCaptureConnection *connection = [self.photoOutput connectionWithMediaType:AVMediaTypeVideo];
    
    if (connection.isVideoOrientationSupported) {
        connection.videoOrientation = [self currentVideoOrientation];
    }
    
    if (self.cameraPos == AVCaptureDevicePositionFront) {
        connection.videoMirrored = YES;
    }else {
        connection.videoMirrored = NO;
    }
    
    AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettings];
    [self.photoOutput capturePhotoWithSettings:settings delegate:self];
}

// 关闭按钮
- (void)cancelBtnClick
{
    if ([_captureSession isRunning]) {
            [_captureSession stopRunning];  // 停止会话
        }
        [_previewLayer removeFromSuperlayer];  // 移除预览层
        _captureSession = nil;
        _deviceInput = nil;
        
        [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)startMontionUpdate
{
    if (self.motionManager.deviceMotionAvailable) {
        __weakSelf;
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            __strongSelf;
            [self performSelectorOnMainThread:@selector(handleDeviceMotion:) withObject:motion waitUntilDone:YES];
        }];
    }
}

- (void)stopMontionUpdate
{
    [self.motionManager stopDeviceMotionUpdates];
}

/// 重力感应回调
- (void)handleDeviceMotion:(CMDeviceMotion *)deviceMotion
{
    double x = deviceMotion.gravity.x;
    double y = deviceMotion.gravity.y;
    
    if (fabs(y) >= fabs(x)) {
        if (y >= 0) {
            _imageOrientation = UIDeviceOrientationPortraitUpsideDown;
            _deviceOrientation = UIDeviceOrientationPortraitUpsideDown;
        } else {
            _imageOrientation = UIDeviceOrientationPortrait;
            _deviceOrientation = UIDeviceOrientationPortrait;
        }
    } else {
        if (x >= 0) { // Home键左侧水平拍摄
            _imageOrientation = UIDeviceOrientationLandscapeLeft;
            _deviceOrientation = UIDeviceOrientationLandscapeLeft;
        } else {
            _imageOrientation = UIDeviceOrientationLandscapeRight;
            _deviceOrientation = UIDeviceOrientationLandscapeRight;
        }
    }
}

- (AVCaptureVideoOrientation)currentVideoOrientation
{
    
    AVCaptureVideoOrientation orientation;
    switch (self.imageOrientation) {
        case UIDeviceOrientationPortrait:
            orientation = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationLandscapeRight:
            orientation = AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            orientation = AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        default:
            orientation = AVCaptureVideoOrientationLandscapeLeft;
            break;
    }
    return orientation;
}

#pragma mark - AVCapturePhotoCaptureDelegate

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(NSError *)error
{
    if (error) return;
    NSData *imageData = [photo fileDataRepresentation];
    UIImage *image = [UIImage imageWithData:imageData];
    UIImage *img = [image fixOrientation];
    
    __weakSelf;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strongSelf;
        self.cameraRetView.retImg = img;
        [self.view addSubview:self.cameraRetView];
        [self.cameraRetView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    });
}

#pragma mark - 对焦

- (void)addFocusGest
{
    [self.view addTarget:self action:@selector(focusGesture:)];
}

- (void)focusGesture:(UITapGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:self.view];
    CGPoint cameraPoint = [self.previewLayer captureDevicePointOfInterestForPoint:point];
    
    AVCaptureDevice *device = self.deviceInput.device;
    if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.focusPointOfInterest = cameraPoint;
            device.focusMode = AVCaptureFocusModeAutoFocus;
            [device unlockForConfiguration];
        }
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if (orientation != UIDeviceOrientationFaceUp && orientation != UIDeviceOrientationFaceDown) {
            self.previewLayer.connection.videoOrientation = (AVCaptureVideoOrientation)orientation;
        }
    } completion:nil];
}

#pragma mark - Noti

- (void)sessionInterrupted:(NSNotification *)noti
{
    
}

#pragma mark - Init

- (AC_BaseView *)takeView
{
    if (_takeView == nil) {
        _takeView = [AC_BaseView new];
        _takeView.backgroundColor = UIColor.whiteColor;
        [_takeView setCornerRadius:50];
    }
    return _takeView;
}

- (CMMotionManager *)motionManager
{
    if (_motionManager == nil) {
        _motionManager = [CMMotionManager new];
        _motionManager.deviceMotionUpdateInterval = 1/15.0;
    }
    return _motionManager;
}

- (AC_BaseButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        _cancelBtn = [AC_BaseButton new];
        [_cancelBtn setBackgroundImage:IMAGE(@"address_icon_close") forState:UIControlStateNormal];
    }
    return _cancelBtn;
}

- (BaseCameraRetView *)cameraRetView
{
    if (_cameraRetView == nil) {
        _cameraRetView = [BaseCameraRetView new];
        __weakSelf;
        _cameraRetView.needUseThisImgBlock = ^(UIImage * _Nonnull img) {
            __strongSelf;
            [self dismissViewControllerAnimated:true completion:nil];
            [self cancelBtnClick];
            if (self.didTakePhoto) self.didTakePhoto(img);
        };
    }
    return _cameraRetView;
}

@end
