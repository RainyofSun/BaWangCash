//
//  HtmlViewController.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CP_H5ViewDidGetTitle)(NSString *title);

@interface HtmlViewController : BaseViewController

@property (nonatomic, assign) bool isInAuthMode;

@property (nonatomic , assign) bool isNeedPopToRoot;

/// 加载H5
/// - Parameter urlStr: H5地址
- (void)loadWithURL:(NSString *)urlStr;

@end

@interface PC_H5View : AC_BaseView

@property (nonatomic , copy) CP_H5ViewDidGetTitle didGetTitle;

/// 加载H5
/// - Parameter urlStr: H5地址
- (void)loadWithURL:(NSString *)urlStr;

@end

NS_ASSUME_NONNULL_END
