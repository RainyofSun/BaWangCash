//
//  CameraViewController.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PC_CameraDidTakePhoto)(UIImage *photo);

@interface CameraViewController : BaseViewController

@property (nonatomic , copy) PC_CameraDidTakePhoto didTakePhoto;

@property (nonatomic , assign) AVCaptureDevicePosition cameraPos;

@end

NS_ASSUME_NONNULL_END
