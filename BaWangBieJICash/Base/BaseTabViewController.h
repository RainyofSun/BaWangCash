//
//  BaseTabViewController.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "AC_BaseTabVC.h"
#import "AC_BaseNaVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface PC_TabBarModel : NSObject

@property (nonatomic, copy) NSString *normalImgName;

@property (nonatomic, copy) NSString *selectImgName;

@property (nonatomic, assign) bool select;

@end


@interface TabBarItem : AC_BaseView

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) PC_TabBarModel *model;

@end

@interface BaseTabViewController : AC_BaseTabVC

@end

NS_ASSUME_NONNULL_END
