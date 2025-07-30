//
//  HtmlViewController.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "HtmlViewController.h"
#import "HtmlJSHelp.h"
#import <WebKit/WebKit.h>
#import "CertificationListViewController.h"

@interface HtmlViewController ()

@property (nonatomic,strong) PC_H5View *h5View;

@end

@implementation HtmlViewController

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self.view addSubview:self.h5View];
    [self.h5View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(self.navBar.mas_bottom);
    }];
}

/// 加载H5
/// - Parameter urlStr: H5地址
- (void)loadWithURL:(NSString *)urlStr
{
    [self.h5View loadWithURL:[NetMonitorTool.tool addHeadToURLWithOrPath:urlStr]];
}

- (void)backBtnClick
{
    if (self.isNeedPopToRoot) {
        [self.navigationController popToRootViewControllerAnimated:true];
        return;
    }
    
    if (self.isInAuthMode) {
        for (__kindof UIViewController *subVC in self.navigationController.childViewControllers) {
            if ([subVC isMemberOfClass:CertificationListViewController.class]) {
                [self.navigationController popToViewController:subVC animated:true];
                return;
            }
        }
        [super backBtnClick];
        return;
    }
    
    if (self.navigationController == nil) {
        [self dismissViewControllerAnimated:true completion:nil];
        return;
    }
    
    [super backBtnClick];
}

#pragma mark - Init

- (PC_H5View *)h5View
{
    if (_h5View == nil){
        _h5View = [PC_H5View new];
        __weakSelf;
        _h5View.didGetTitle = ^(NSString * _Nonnull title) {
            __strongSelf;
            self.title = title;
            self.vcTitleLabel.textColor = HEXCOLOR(@"#000000");
            
        };
    }
    return _h5View;
}

@end

#pragma mark - PC_H5View

@interface PC_H5View ()
<WKNavigationDelegate,
WKScriptMessageHandler,
WKUIDelegate>

@property (nonatomic,strong) WKWebView *wkWebView;

@property (nonatomic, strong) HtmlJSHelp *jsHelp;

@end

@implementation PC_H5View

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.jsHelp addJsBridges];
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    if (newWindow == nil) [self.jsHelp removeAllBridge];
}

- (void)loadWithURL:(NSString *)urlStr
{
    [self.wkWebView stopLoading];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:url];
    [self.wkWebView loadRequest:urlReq];
}

- (void)dealloc
{
    [_wkWebView removeObserver:self forKeyPath:@"title"];
    [_wkWebView stopLoading];
}

#pragma mark - obs

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"title"]) {
        if (object == self.wkWebView) {
            if (self.didGetTitle) self.didGetTitle(self.wkWebView.title);
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
}

#pragma mark - JS

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler
{
    if (prompt) {
        
        completionHandler(@"");
    }
}

/// 没有参数的js调用原生
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    [self.jsHelp fromJSCallWithMessage:message];
}



#pragma mark - Init

- (WKWebView *)wkWebView
{
    if (_wkWebView == nil){
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.allowsInlineMediaPlayback = YES;
        configuration.allowsPictureInPictureMediaPlayback = YES;
        configuration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
        [configuration.preferences setValue:@1 forKey:@"allowFileAccessFromFileURLs"];
        
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        _wkWebView.backgroundColor = UIColor.clearColor;
        _wkWebView.scrollView.backgroundColor = UIColor.clearColor;
        _wkWebView.scrollView.bounces = NO;
        _wkWebView.opaque = NO;
        [_wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        if (@available(iOS 11.0, *)) _wkWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    return _wkWebView;
}

- (HtmlJSHelp *)jsHelp
{
    if (_jsHelp == nil) {
        _jsHelp = [[HtmlJSHelp alloc]initWithWebView:self.wkWebView ScriptDelegate:self];
    }
    return _jsHelp;
}

@end
