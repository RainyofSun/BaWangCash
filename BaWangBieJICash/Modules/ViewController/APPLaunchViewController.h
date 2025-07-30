//
//  APPLaunchViewController.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface APPLaunchViewController : BaseViewController

@property (nonatomic , weak) UIApplication *application;
@property (nonatomic , strong) NSDictionary *launchOptions;

@end

NS_ASSUME_NONNULL_END
