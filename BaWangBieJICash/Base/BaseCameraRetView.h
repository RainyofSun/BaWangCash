//
//  BaseCameraRetView.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "AC_BaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CameraRetView_NeedUseThisImg)(UIImage *img);

@interface BaseCameraRetView : AC_BaseView

@property (nonatomic , copy) CameraRetView_NeedUseThisImg needUseThisImgBlock;

@property (nonatomic , strong) UIImage *retImg;

@end

NS_ASSUME_NONNULL_END
