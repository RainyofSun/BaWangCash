//
//  NetMonitorTool.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SwitchNetModel.h"
#import "BaseNetResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CR_NetWorkTool_ReqSuccBlock)(BaseNetResponseModel *responseModel);
typedef void(^CR_NetWorkTool_ReqDataSuccBlock)(NSData *responseData);
typedef void(^CR_NetWorkTool_ReqFailBlock)(NSError * _Nonnull error);
typedef void(^CR_NetWorkTool_ReqProgressBlock)(NSProgress *progress);

@interface NetMonitorTool : NSObject

+ (instancetype)tool;


/// POST 请求
/// - Parameters:
///   - path: 请求地址
///   - parameters: 参数
///   - succBlock: 成功回调
///   - failBlock: 失败回调
- (nullable NSURLSessionDataTask *)postWithPath:(NSString *)path
                                     Parameters:(NSDictionary *)parameters
                                      SuccBlock:(CR_NetWorkTool_ReqSuccBlock)succBlock
                                      FailBlock:(CR_NetWorkTool_ReqFailBlock)failBlock;
/// 需要在外界判断请求成功失败的POST
- (nullable NSURLSessionDataTask * )postWithPath:(NSString *)path
                                      Parameters:(NSDictionary *)parameters
                                   CompleteBlock:(CR_NetWorkTool_ReqSuccBlock)succBlock
                                       FailBlock:(CR_NetWorkTool_ReqFailBlock)failBlock;

- (nullable NSURLSessionDataTask * )postWithPath:(NSString *)path
                                      Parameters:(NSDictionary *)parameters
                                   ProgressBlock:(nullable CR_NetWorkTool_ReqProgressBlock)progressBlock
                                       SuccBlock:(CR_NetWorkTool_ReqSuccBlock)succBlock
                                       FailBlock:(CR_NetWorkTool_ReqFailBlock)failBlock;

- (nullable NSURLSessionDataTask * )postWithFullPath:(NSString *)path
                                          Parameters:(NSDictionary *)parameters
                                       ProgressBlock:(nullable CR_NetWorkTool_ReqProgressBlock)progressBlock
                                           SuccBlock:(CR_NetWorkTool_ReqSuccBlock)succBlock
                                           FailBlock:(CR_NetWorkTool_ReqFailBlock)failBlock;

/// 带有上传图片的``POST``
/// - Parameters:
///   - path: 地址
///   - parameters: 参数，不包括图片二进制的字段
///   - img: 图片
///   - imgParameterName: 用于图片二进制的字段名
- (nullable NSURLSessionDataTask * )postWithPath:(NSString *)path
                                      Parameters:(NSDictionary *)parameters
                                       UploadImg:(UIImage *)img
                                ImgParameterName:(NSString *)imgParameterName
                                   ProgressBlock:(nullable CR_NetWorkTool_ReqProgressBlock)progressBlock
                                       SuccBlock:(CR_NetWorkTool_ReqSuccBlock)succBlock
                                       FailBlock:(CR_NetWorkTool_ReqFailBlock)failBlock;

/// GET 请求
/// - Parameters:
///   - path: 请求地址
///   - parameters: 参数
///   - succBlock: 成功回调
///   - failBlock: 失败回调
- (nullable NSURLSessionDataTask *)getWithPath:(NSString *)path
                                    Parameters:(NSDictionary *)parameters
                                     SuccBlock:(CR_NetWorkTool_ReqSuccBlock)succBlock
                                     FailBlock:(CR_NetWorkTool_ReqFailBlock)failBlock;

/// GET 请求
/// - Parameters:
///   - path: 请求地址
///   - parameters: 参数
///   - succBlock: 成功回调
///   - failBlock: 失败回调
- (nullable NSURLSessionDataTask *)getDataWithoutHeadWithFullPath:(NSString *)path
                                                       Parameters:(NSDictionary *)parameters
                                                        SuccBlock:(CR_NetWorkTool_ReqDataSuccBlock)succBlock
                                                        FailBlock:(CR_NetWorkTool_ReqFailBlock)failBlock;


#pragma mark - Public Head

/// 在地址后拼接公共参数
/// - Parameter path: 原始地址
- (NSString *)addHeadToURLWithOrPath:(NSString *)path;

#pragma mark - 检测

/// 是否使用代理
+ (BOOL)isProxyEnabled;

/// 是否使用VPN
+ (BOOL)isVPNConnected;

#pragma mark - DNS

- (NSMutableArray<SwitchNetModel *> *)dnsModels;

@end

NS_ASSUME_NONNULL_END
