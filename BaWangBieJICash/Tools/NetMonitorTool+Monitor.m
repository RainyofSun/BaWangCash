//
//  NetMonitorTool+Monitor.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "NetMonitorTool+Monitor.h"

@implementation NetMonitorTool (Monitor)

+ (void)startReachabilityMonitoring
{
    __weakSelf;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        __strongSelf;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                // 未知状态
                NSLog(@"🛜switch -> Unknown state");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                // 拒绝
                NSLog(@"🛜switch -> Refuse");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                // 蜂窝
                NSLog(@"🛜switch -> Honeycomb");
                [self whenNetworkEnable];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //Wi-Fi
                NSLog(@"🛜switch -> Wi-Fi");
                [self whenNetworkEnable];
                break;
                
            default:
                break;
        }
    }];
    [manager startMonitoring];
}

+ (void)whenNetworkEnable
{
    [Noti_Center postNotificationName:WhenNetworkEnable_NotiKey object:nil];
}

@end
