//
//  PhotoTool.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "PhotoTool.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@interface PhotoTool ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation PhotoTool

+ (instancetype)tool
{
    static dispatch_once_t onceToken;
    static PhotoTool *_tool = nil;
    dispatch_once(&onceToken, ^{
        if (_tool == nil) {
            _tool = [PhotoTool new];
        }
    });
    return _tool;
}

+ (void)requestCameraPermission:(void (^)(BOOL granted))completion {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) completion(granted);
        });
    }];
}

+ (void)requestPhotoLibraryPermission:(void (^)(BOOL granted))completion {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(status == PHAuthorizationStatusAuthorized);
        });
    }];
}


#pragma mark - Auth

- (void)isGetCameraAuth:(void (^)(BOOL granted))completion
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        // 弹自定义弹窗
        completion(false);
        [self showCustomDeniedAlert];
        return;
    }
    
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [self.class requestCameraPermission:^(BOOL granted) {
            if (granted) {
                completion(true);
            }else{
                [self showCustomDeniedAlert];
            }
        }];
        return;
    }
    
    completion(true);
}

- (void)isGetPhotoAuth:(void (^)(BOOL granted))completion
{
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus == PHAuthorizationStatusDenied) {
        // 弹自定义弹窗
        completion(false);
        [self showCustomDeniedAlert];
        return;
    }
    
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [self.class requestPhotoLibraryPermission:^(BOOL granted) {
            if (granted) {
                completion(true);
            }else{
                [self showCustomDeniedAlert];
            }
        }];
        return;
    }
    
    completion(true);
}

- (void)showCustomDeniedAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Permission denied"
                                                                  message:@"Please enable permissions in the settings"
                                                           preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *settingsAction = [UIAlertAction
        actionWithTitle:@"To setting"
        style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:
                [NSURL URLWithString:UIApplicationOpenSettingsURLString]
                options:@{}
                completionHandler:nil];
        }];
    
    UIAlertAction *cancelAction = [UIAlertAction
        actionWithTitle:@"Cancel"
        style:UIAlertActionStyleCancel
        handler:nil];
    
    [alert addAction:settingsAction];
    [alert addAction:cancelAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIViewController.currentVC presentViewController:alert animated:YES completion:nil];
    });
}

@end
