//
//  HtmlJSHelp.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class WKScriptMessage;
@class WKWebView;
@protocol WKScriptMessageHandler;

@interface HtmlJSHelp : NSObject

- (instancetype)initWithWebView:(__kindof WKWebView *)webView ScriptDelegate:(id <WKScriptMessageHandler>)scriptDelegate;

/// 移除所有交互
- (void)removeAllBridge;

/// 注册所有交互
- (void)addJsBridges;

/// JS调用
/// - Parameter msg: js信息
- (void)fromJSCallWithMessage:(WKScriptMessage *)msg;

@end

NS_ASSUME_NONNULL_END
