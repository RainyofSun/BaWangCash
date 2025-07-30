//
//  NetMonitorTool+Monitor.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "NetMonitorTool.h"

NS_ASSUME_NONNULL_BEGIN

#define WhenNetworkEnable_NotiKey  @"WhenNetworkEnable_NotiKey"

@interface NetMonitorTool (Monitor)

+ (void)startReachabilityMonitoring;

@end

NS_ASSUME_NONNULL_END
