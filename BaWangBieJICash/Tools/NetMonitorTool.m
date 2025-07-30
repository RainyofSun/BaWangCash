//
//  NetMonitorTool.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "NetMonitorTool.h"
// 代理检测
#import <CFNetwork/CFNetwork.h>
// VPN检测
#import <ifaddrs.h>
#import <net/if.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "NetMonitorTool+DNS.h"
#import "LoginPresent.h"
#import "LoginLogic.h"

@interface NetMonitorTool()

/// netWork Manager
@property(nonatomic, strong) AFHTTPSessionManager *manager;

/// head
@property (nonatomic, strong) NSMutableDictionary *tokenDict;
@property (nonatomic, strong) NSMutableDictionary *head;

@property (nonatomic , strong) NSMutableArray <SwitchNetModel *> *dnsModels;

@end

@implementation NetMonitorTool

+ (instancetype)tool
{
    static dispatch_once_t onceToken;
    static NetMonitorTool *_tool = nil;
    dispatch_once(&onceToken, ^{
        if (_tool == nil) {
            _tool = [NetMonitorTool new];
        }
    });
    return _tool;
}


/// 是否使用代理
+ (BOOL)isProxyEnabled
{
    CFDictionaryRef proxySettingsRef = CFNetworkCopySystemProxySettings();
    NSDictionary *proxySettings = (__bridge_transfer NSDictionary *)proxySettingsRef;
    
    NSString *httpProxy = proxySettings[@"HTTPProxy"];
    NSString *httpsProxy = proxySettings[@"HTTPSProxy"];
    NSNumber *httpEnabled = proxySettings[@"HTTPEnable"];
    
    return ([httpEnabled boolValue] && (httpProxy.length > 0 || httpsProxy.length > 0));
}

/// 是否使用VPN
+ (BOOL)isVPNConnected
{
    NSDictionary *dict = CFBridgingRelease(CFNetworkCopySystemProxySettings());
    NSArray *keys = [dict[@"__SCOPED__"]allKeys];
    for (NSString *key in keys) {
        if ([key rangeOfString:@"tap"].location != NSNotFound ||
            [key rangeOfString:@"tun"].location != NSNotFound ||
            [key rangeOfString:@"ppp"].location != NSNotFound){
            return YES;
        }
    }
    return NO;
}

- (nullable NSURLSessionDataTask * )postWithPath:(NSString *)path
                                      Parameters:(NSDictionary *)parameters
                                   ProgressBlock:(CR_NetWorkTool_ReqProgressBlock)progressBlock
                                       SuccBlock:(CR_NetWorkTool_ReqSuccBlock)succBlock
                                       FailBlock:(CR_NetWorkTool_ReqFailBlock)failBlock
{
    NSString *allPath = [self makeFullPathWithSubPath:path];
    return [self postWithFullPath:allPath Parameters:parameters ProgressBlock:progressBlock SuccBlock:succBlock FailBlock:failBlock];
}

- (nullable NSURLSessionDataTask * )postWithFullPath:(NSString *)path
                                          Parameters:(NSDictionary *)parameters
                                       ProgressBlock:(CR_NetWorkTool_ReqProgressBlock)progressBlock
                                           SuccBlock:(CR_NetWorkTool_ReqSuccBlock)succBlock
                                           FailBlock:(CR_NetWorkTool_ReqFailBlock)failBlock
{
    __weakSelf;
    NSString *allPath = path;
    allPath = [self addHeadToURLWithOrPath:allPath];
    
    NSURLSessionDataTask *task = [self.manager POST:allPath parameters:parameters headers:self.head progress:progressBlock success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strongSelf;
        
        BaseNetResponseModel *model = [self makeResponseModelWithResponseObj:responseObject Path:path];
        [self isReqSuccessWithResponseModel:model];
        if (succBlock) succBlock(model);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) {
            failBlock(error);
        }
    }];
    return task;
}

- (nullable NSURLSessionDataTask * )postWithPath:(NSString *)path
                                      Parameters:(NSDictionary *)parameters
                                       UploadImg:(UIImage *)img
                                ImgParameterName:(NSString *)imgParameterName
                                   ProgressBlock:(nullable CR_NetWorkTool_ReqProgressBlock)progressBlock
                                       SuccBlock:(CR_NetWorkTool_ReqSuccBlock)succBlock
                                       FailBlock:(CR_NetWorkTool_ReqFailBlock)failBlock
{
    __weakSelf;
    NSData *imgData = [img compressWithMaxLength:819200];
    NSString *allPath = [self makeFullPathWithSubPath:path];
    allPath = [self addHeadToURLWithOrPath:allPath];
    [self.manager.requestSerializer setTimeoutInterval:60.0];
    
    NSURLSessionDataTask *task = [self.manager POST:allPath parameters:parameters headers:self.head constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imgData name:imgParameterName fileName:@"uploadImg.jpg" mimeType:@"image/jpeg"];
    } progress:progressBlock success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strongSelf;
        BaseNetResponseModel *model = [self makeResponseModelWithResponseObj:responseObject Path:path];
        [self isReqSuccessWithResponseModel:model];
        if (succBlock) succBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) failBlock(error);
    }];
    [self.manager.requestSerializer setTimeoutInterval:10.0];
    return task;
}

- (nullable NSURLSessionDataTask * )postWithPath:(NSString *)path
                                      Parameters:(NSDictionary *)parameters
                                       SuccBlock:(CR_NetWorkTool_ReqSuccBlock)succBlock
                                       FailBlock:(CR_NetWorkTool_ReqFailBlock)failBlock
{
    return [self postWithPath:path Parameters:parameters ProgressBlock:nil SuccBlock:succBlock FailBlock:failBlock];
}

- (nullable NSURLSessionDataTask * )postWithPath:(NSString *)path
                                      Parameters:(NSDictionary *)parameters
                                   CompleteBlock:(CR_NetWorkTool_ReqSuccBlock)succBlock
                                       FailBlock:(CR_NetWorkTool_ReqFailBlock)failBlock
{
    __weakSelf;
    NSString *allPath = [self makeFullPathWithSubPath:path];
    allPath = [self addHeadToURLWithOrPath:allPath];
    
    NSURLSessionDataTask *task = [self.manager POST:allPath parameters:parameters headers:self.head progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strongSelf;
        
        BaseNetResponseModel *model = [self makeResponseModelWithResponseObj:responseObject Path:path];
        [self isReqSuccessWithResponseModel:model];
        if (succBlock) succBlock(model);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) {
            failBlock(error);
        }
    }];
    return task;
}

- (nullable NSURLSessionDataTask *)getWithPath:(NSString *)path
                                    Parameters:(NSDictionary *)parameters
                                     SuccBlock:(CR_NetWorkTool_ReqSuccBlock)succBlock
                                     FailBlock:(CR_NetWorkTool_ReqFailBlock)failBlock
{
 
    NSString *allPath = [self makeFullPathWithSubPath:path];
    allPath = [self addHeadToURLWithOrPath:allPath];
    
    __weakSelf;
    NSURLSessionDataTask *task = [self.manager GET:allPath parameters:parameters headers:self.head progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strongSelf;
        BaseNetResponseModel *model = [self makeResponseModelWithResponseObj:responseObject Path:path];
        [self isReqSuccessWithResponseModel:model];
        if (succBlock) succBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) failBlock(error);
    }];
    return task;
}

/// GET 请求
/// - Parameters:
///   - path: 请求地址
///   - parameters: 参数
///   - succBlock: 成功回调
///   - failBlock: 失败回调
- (nullable NSURLSessionDataTask *)getDataWithoutHeadWithFullPath:(NSString *)path
                                                       Parameters:(NSDictionary *)parameters
                                                        SuccBlock:(CR_NetWorkTool_ReqDataSuccBlock)succBlock
                                                        FailBlock:(CR_NetWorkTool_ReqFailBlock)failBlock
{
    NSURLSessionDataTask *task = [self.manager GET:path parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (succBlock) succBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) failBlock(error);
    }];
    return task;
}

- (NSString *)makeFullPathWithSubPath:(NSString *)subPath
{
    return [self.getCuurentDNS stringByAppendingString:subPath];
}

- (BaseNetResponseModel *)makeResponseModelWithResponseObj:(id  _Nullable)responseObject Path:(NSString *)path
{
    BaseNetResponseModel *model = [BaseNetResponseModel new];
    
    // 响应体容错
    if (![responseObject isKindOfClass:NSData.class] || responseObject == nil) return model;
    NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    
    NSDictionary *resDict = [responseStr convertToDictionary];
    
    model = [BaseNetResponseModel ACModel_withDict:resDict];
    
    
//    if ([model.pc_snob isEqualToString:@"0"]) NSLog(@"--> %@ :Succ",path);
    
    return model;
}

- (bool)isReqSuccessWithResponseModel:(BaseNetResponseModel *)responseModel
{
    switch (responseModel.pc_snob.integerValue) {
        case 0:
            return true;
            break;
            
        case -2:{
            LoginPresent *view = [LoginPresent new];
            [view show];
        }
            return false;
            break;
            
        default:
            return false;
            break;
    }
}

/// 拼接公共参数
/// 在请求地址后按照``GET``的格式拼接参数，不区分``GET``和``POST``
/// - Parameter path: 原始地址
- (NSString *)addHeadToURLWithOrPath:(NSString *)path
{
    NSString *temp = path;
    NSInteger idx = 0;
    bool hasHead = [path containsString:@"?"];
    for (NSString *key in self.head.allKeys) {
        
        NSString *format = (idx == 0 && !hasHead) ? @"?" : @"&";
        __kindof NSObject *val = self.head[key];
        if (val == nil) val = @"";
        temp = [temp stringByAppendingFormat:@"%@%@=%@",format,key,val];
        idx += 1;
    }
    return temp;
}


#pragma mark - Init

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = AFHTTPSessionManager.manager;
        _manager.requestSerializer = AFHTTPRequestSerializer.serializer;
        _manager.responseSerializer = AFHTTPResponseSerializer.serializer;
        [_manager.requestSerializer setTimeoutInterval:10.0];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/plain",@"application/json"]];
    }
    return _manager;
}

- (NSMutableDictionary *)head
{
    NSDictionary *dict = @{
        @"quite":[LoginLogic.tool.loginModel.pc_quite isExist] ? LoginLogic.tool.loginModel.pc_quite : @"",
        @"conclusion":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
        @"shocked":UIDevice.currentDevice.name,
        @"sloane":[XYUUID uuidForIDFV],
        @"rick":UIDevice.currentDevice.systemVersion,
        @"squirm":[XYUUID uuidForIDFA],
        @"allers": LoginLogic.tool.loginConfig == nil ? @"0" : FORMAT(@"%ld",LoginLogic.tool.loginConfig.pc_allers)
    };
    
    return [[NSMutableDictionary alloc]initWithDictionary:dict];
}

- (NSMutableArray<SwitchNetModel *> *)dnsModels
{
    if (_dnsModels == nil) {
        _dnsModels = [NSMutableArray new];
    }
    return _dnsModels;
}

@end
