//
//  APPLogTool.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "APPLogTool.h"
#import <CoreLocation/CoreLocation.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <sys/utsname.h>
#import <sys/stat.h>
#import <dlfcn.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>

#import <NetworkExtension/NetworkExtension.h>
#import "DeviceIdentifierTool.h"

@implementation APPLogTool

+ (instancetype)tool
{
    static dispatch_once_t onceToken;
    static APPLogTool *_tool = nil;
    dispatch_once(&onceToken, ^{
        if (_tool == nil) {
            _tool = [APPLogTool new];
        }
    });
    return _tool;
}


//- (void)reportPosition
//{
//    NSDictionary *dict = @{
//        @"commentator":@"ss",  //省
//        @"golf":@"CN",//国家code
//        @"kind":@"China",//国家
//        @"kerzner":@"OLA Bar And RESTAURANT (Dabang Cooperation Guangchang Branch)",//街道
//        @"sparks":@"31.24643134910169",//纬度
//        @"ron":@"121.4511185077306",//经度
//        @"liana":@"Shanghai",//市
//        @"sock":@"江北区"//区
//    };
//
//    [PC_NetWorkTool.tool postWithPath:@"/before/arrested" Parameters:@{} SuccBlock:^(PC_BaseResponModel * _Nonnull responseModel) {
//
//    } FailBlock:^(NSError * _Nonnull error) {
//
//    }];
//}

// idfv&idfa上报
- (void)reportDeviceIDsWithCompletion:(void(^)(BOOL success))completion
{
    [NetMonitorTool.tool postWithPath:@"/before/disposing" Parameters:@{@"nite":[DeviceIdentifierTool getIDFVWithKeychain],@"predecessor":self.idfa} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        if (!responseModel.success) {
            return;
        }
    } FailBlock:^(NSError * _Nonnull error) {
        completion(false);
    }];
        
}

// 设备信息上报
- (void)reportDeviceWithCompletion:(void(^)(BOOL success))completion
{
    NSMutableDictionary *wifiDict = [self makeDeviceReport];
    [self getWifiInfoWithComplete:^(NSDictionary *dict) {
        wifiDict[@"awareness"] = dict;
        NSString *json = [wifiDict getJsonStr];
        
        [NetMonitorTool.tool postWithPath:@"/before/inserting" Parameters:@{@"portal":json} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        } FailBlock:^(NSError * _Nonnull error) {
            completion(false);
        }];
    }];
}

- (NSMutableDictionary *)makeDeviceReport
{
    NSMutableDictionary *portal = [NSMutableDictionary dictionary];
    
    
    NSDictionary *storage = [self getStorageInfo];
    NSMutableDictionary *espn = [NSMutableDictionary dictionary];
    espn[@"debuted"] = storage[@"free"];
    espn[@"jami"] = storage[@"total"];
    espn[@"cinema"] = [self getTotalMemorySize];
    espn[@"deadly"] = [self getAvailableMemorySize];
    portal[@"espn"] = espn;
    
    
    UIDevice *device = [UIDevice currentDevice];
       device.batteryMonitoringEnabled = YES;
    NSMutableDictionary *fun = [NSMutableDictionary dictionary];
    fun[@"poke"] = @((int)(device.batteryLevel * 100));
    fun[@"dubbed"] = @(device.batteryState == UIDeviceBatteryStateCharging ? 1 : 0);
    portal[@"fun"] = fun;
    
         
    NSMutableDictionary *imported = [NSMutableDictionary dictionary];
    imported[@"kaiju"] =  [UIDevice currentDevice].systemVersion;
    imported[@"giant"] = UIDevice.currentDevice.model;
    imported[@"gordon"] = [self getDeviceModelIdentifier];
    portal[@"imported"] = imported;
    
    
    NSMutableDictionary *bert = [NSMutableDictionary dictionary];
    bert[@"limelight"] = [self isSimulator] ? @1 : @0;
    bert[@"wood"] = [self isJailbroken] ? @1 : @0;
    portal[@"bert"] = bert;
    
    
    NSMutableDictionary *ed = [NSMutableDictionary dictionary];
    ed[@"direction"] = [NSTimeZone systemTimeZone].name;
    ed[@"nite"] = [DeviceIdentifierTool getIDFVWithKeychain];
    ed[@"schlefaz"] = NSLocale.preferredLanguages.firstObject;
    ed[@"poor"] = [self getNetworkType];
    ed[@"predecessor"] = self.idfa;
    portal[@"ed"] = ed;
    
    return portal;
}


#pragma mark - 存储信息
- (NSDictionary *)getStorageInfo {
    NSError *error = nil;
    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    
    NSError *freeError = nil;
    NSDictionary *results = [[[NSURL alloc] initFileURLWithPath:NSTemporaryDirectory()] resourceValuesForKeys:@[NSURLVolumeAvailableCapacityForImportantUsageKey] error:&error];

    
    NSMutableDictionary *retDict = [NSMutableDictionary new];
    
    if (error){
        [retDict setObject:@"0" forKey:@"total"];
    }else{
        [retDict setObject:FORMAT(@"%lld",[dict[NSFileSystemSize] longLongValue]) forKey:@"total"];
    }
    
    
    if (freeError){
        [retDict setObject:@"0" forKey:@"free"];
    }else{
        [retDict setObject:FORMAT(@"%lld",[results[NSURLVolumeAvailableCapacityForImportantUsageKey] longLongValue]) forKey:@"free"];
    }
    
    return retDict;
}

- (NSNumber *)getTotalMemorySize
{
    long long totalMemorySize = [NSProcessInfo processInfo].physicalMemory;
    return @(totalMemorySize);
}

- (NSNumber *)getAvailableMemorySize
{
    vm_statistics64_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return @0;
    }
    long long availableMemorySize = ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
    return @(availableMemorySize);
}


- (NSString *)getDeviceModelIdentifier
{
    struct utsname systemInfo;
    uname(&systemInfo); // 调用 Unix 系统函数获取设备信息:ml-citation{ref="2,4" data="citationList"}
    return [[NSString stringWithCString:systemInfo.machine
                              encoding:NSASCIIStringEncoding] lowercaseString]; // 转换为小写格式
}

// 检测模拟器
- (BOOL)isSimulator {
#if TARGET_OS_SIMULATOR
    return YES;
#else
    return NO;
#endif
}

// 检测越狱状态
- (BOOL)isJailbroken {
    // 检查常见越狱文件路径
    NSArray *jailbreakPaths = @[
        @"/Applications/Cydia.app",
        @"/Library/MobileSubstrate/MobileSubstrate.dylib",
        @"/bin/bash",
        @"/usr/sbin/sshd",
        @"/etc/apt"
    ];
    
    for (NSString *path in jailbreakPaths) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            return YES;
        }
    }
    
    // 检查动态库注入
    void *handle = dlopen("/Library/MobileSubstrate/MobileSubstrate.dylib", RTLD_NOW);
    if (handle) {
        dlclose(handle);
        return YES;
    }
    // 检查文件系统权限
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"]) {
        return YES;
    }
    return NO;
}


- (NSString *)getNetworkType
{
    // 先检测 WiFi 状态
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, "www.apple.com");
    SCNetworkReachabilityFlags flags;
    SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    
    // 判断 WiFi 连接
    if ((flags & kSCNetworkReachabilityFlagsReachable) &&
       !(flags & kSCNetworkReachabilityFlagsIsWWAN)) {
        return @"WIFI";
    }
    
    // 蜂窝网络类型检测
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSString *radioType = networkInfo.currentRadioAccessTechnology;
    
    // 网络类型映射表（iOS 14+ 支持5G）
    NSDictionary *typeMapping = @{
        CTRadioAccessTechnologyGPRS: @"2G",
        CTRadioAccessTechnologyEdge: @"2G",
        CTRadioAccessTechnologyCDMA1x: @"2G",
        
        CTRadioAccessTechnologyWCDMA: @"3G",
        CTRadioAccessTechnologyHSDPA: @"3G",
        CTRadioAccessTechnologyHSUPA: @"3G",
        CTRadioAccessTechnologyCDMAEVDORev0: @"3G",
        CTRadioAccessTechnologyCDMAEVDORevA: @"3G",
        CTRadioAccessTechnologyCDMAEVDORevB: @"3G",
        CTRadioAccessTechnologyeHRPD: @"3G",
        
        CTRadioAccessTechnologyLTE: @"4G",
        
        // iOS 14+ 新增的5G类型
        CTRadioAccessTechnologyNRNSA: @"5G", // Sub-6GHz
        CTRadioAccessTechnologyNR: @"5G"     // mmWave
    };
    
    // 处理iOS版本差异
    NSString *networkType = typeMapping[radioType];
    
    if (networkType) {
        return networkType;
    }
    
    // 处理未知类型（iOS未来可能新增类型）
    if ([radioType hasPrefix:@"CTRadioAccessTechnology"]) {
        return @"OTHER";
    }
    
    // 无网络连接状态
    return (flags & kSCNetworkReachabilityFlagsReachable) ? @"OTHER" : @"NO_NETWORK";
}


- (void)getWifiInfoWithComplete:(void(^)(NSDictionary *dict))completeBlock
{
    [PositionTool.tool requestTemporaryFullAccuracyWithComplete:^(_Bool succ) {
        
        if (!succ) {
            completeBlock(@{@"flats":@{}});
            return;
        }
        
        if (@available(iOS 14.0, *)) {
            [NEHotspotNetwork fetchCurrentWithCompletionHandler:^(NEHotspotNetwork * _Nullable currentNetwork) {
                
                NSString *bssid = currentNetwork.BSSID;
                NSString *ssid = currentNetwork.SSID;
                
                NSMutableDictionary *wifiInfo = [NSMutableDictionary dictionary];
                if ([bssid isExist]) [wifiInfo setObject:bssid forKey:@"yucca"];
                if ([ssid isExist]) [wifiInfo setObject:ssid forKey:@"shoot"];
                
                completeBlock(@{@"flats":wifiInfo});
                
            }];
        } else {
            NSMutableDictionary *wifiInfo = [NSMutableDictionary dictionary];
            CFArrayRef interfaces = CNCopySupportedInterfaces();
            if (interfaces) {
                CFIndex count = CFArrayGetCount(interfaces);
                for (CFIndex i = 0; i < count; i++) {
                    CFStringRef interface = CFArrayGetValueAtIndex(interfaces, i);
                    CFDictionaryRef networkInfo = CNCopyCurrentNetworkInfo(interface);
                               
                    if (networkInfo) {
                        NSDictionary *infoDict = (__bridge NSDictionary *)networkInfo;

                        NSString *bssid = infoDict[(__bridge NSString *)kCNNetworkInfoKeyBSSID];
                        NSString *ssid = infoDict[(__bridge NSString *)kCNNetworkInfoKeySSID];
                                   
                        if (bssid && [bssid isExist] && ssid && [ssid isExist]) {
                            [wifiInfo setObject:bssid forKey:@"yucca"];
                            [wifiInfo setObject:ssid forKey:@"shoot"];
                        }

                        CFRelease(networkInfo);
                        break;
                    }
                }
                CFRelease(interfaces);
            }
            completeBlock(@{@"flats":wifiInfo});
        }
    }];
}

- (NSString *)idfa
{
    return [XYUUID uuidForIDFA];
}

- (NSString *)idfv
{
    return [XYUUID uuidForIDFV];
}

@end
