//
//  AC_Define.h
//  ACAutoCode
//
//  Created by Acery on 2024/10/15.
//
//
//       ,---,
//      '  .' \
//     /  ;    '.                          __  ,-.
//    :  :       \                       ,' ,'/ /|
//    :  |   /\   \     ,---.     ,---.  '  | |' |   .--,
//    |  :  ' ;.   :   /     \   /     \ |  |   ,' /_ ./|
//    |  |  ;/  \   \ /    / '  /    /  |'  :  /, ' , ' :
//    '  :  | \  \ ,'.    ' /  .    ' / ||  | '/___/ \: |
//    |  |  '  '--'  '   ; :__ '   ;   /|;  : | .  \  ' |
//    |  :  :        '   | '.'|'   |  / ||  , ;  \  ;   :
//    |  | ,'        |   :    :|   :    | ---'    \  \  ;
//    `--''           \   \  /  \   \  /           :  \  \
//                     `----'    `----'             \  ' ;
//                                                   `--`


#ifndef AC_Define_h
#define AC_Define_h

#pragma mark - Base value

#define kScreenSize                             [UIScreen mainScreen].bounds.size

#define kScreenWidth                            kScreenSize.width
#define kScreenHeight                           kScreenSize.height

#define kNavigationBarHeight                    (kScreenHeight >= 812.0 ? 88 : 64)
#define kStatusBarHeight                        ([UIApplication.sharedApplication getStatusBarHeight])

#define kTabbarHeight                           (kScreenHeight >= 812.0 ? 83 : 49)
#define kBottomHeight                           (kScreenHeight >= 812.0 ? 34 : 0 )

#pragma mark - Head

#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <SDWebImage/SDWebImage.h>
#import <LYEmptyView/LYEmptyViewHeader.h>

#pragma mark - Noti

/// 发送通知
#define Noti_Post(_name_)                       [[NSNotificationCenter defaultCenter] postNotificationName:_name_ object:nil]
#define Noti_PostWithObj(_name_,_obj_)          [[NSNotificationCenter defaultCenter] postNotificationName:_name_ object:_obj_]

/// 移除通知
#define Noti_RemoveObs(_name_)                  [[NSNotificationCenter defaultCenter] removeObserver:self name:_name_ object:nil]
#define Noti_RemoveAllObs(_name_)               [[NSNotificationCenter defaultCenter] removeObserver:self]

/// 通知中心
#define Noti_Center                             [NSNotificationCenter defaultCenter]

#pragma mark - String

#define FORMAT(s, ...)                          [NSString stringWithFormat:s, ##__VA_ARGS__]

#pragma mark - Img

/// 通过名字创建图片
#define IMAGE(_image_)                          [UIImage imageNamed:_image_]

/// 通过名字创建UIImage View
#define ImgViewWithName(_viewName_,_imgName_)   UIImageView *_viewName_ = [[UIImageView alloc]initWithImage:IMAGE(_imgName_)]
#define ImgView(_imgName_)                      UIImageView *_imgName_ = [[UIImageView alloc]initWithImage:IMAGE(_imgName_)]

#pragma mark - Time

/// 连点屏蔽
#define kRepeatClickTime(_seconds_) \
static BOOL shouldPrevent; \
if (shouldPrevent) return; \
shouldPrevent = YES; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((_seconds_) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ \
shouldPrevent = NO; \
}); \

#pragma mark - Defaults

#define UserDefaultsObj                         [NSUserDefaults standardUserDefaults]

#pragma mark - Color

#define HEXCOLOR(string)                        [UIColor colorWithHexString:string]
#define RANDOM_COLOR                            [UIColor colorWithHue: (arc4random() % 256 / 256.0) saturation:((arc4random()% 128 / 256.0 ) + 0.5) brightness:(( arc4random() % 128 / 256.0 ) + 0.5) alpha:1]

#pragma mark - Font

#define UltraLight(_SIZE_)                      [UIFont UltraLight_size:_SIZE_]
#define Thin(_SIZE_)                            [UIFont Thin_size:_SIZE_]
#define Light(_SIZE_)                           [UIFont Light_size:_SIZE_]
#define Regular(_SIZE_)                         [UIFont Regular_size:_SIZE_]
#define Medium(_SIZE_)                          [UIFont Medium_size:_SIZE_]
#define Semibold(_SIZE_)                        [UIFont Semibold_size:_SIZE_]
#define Bold(_SIZE_)                            [UIFont Bold_size:_SIZE_]
#define Heavy(_SIZE_)                           [UIFont Heavy_size:_SIZE_]
#define Black(_SIZE_)                           [UIFont Black_size:_SIZE_]

#pragma mark - Weak

#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#define __weakSelf          @weakify(self)
#define __strongSelf        @strongify(self)

#endif /* AC_Define_h */
