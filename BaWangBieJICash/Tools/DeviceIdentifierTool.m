//
//  DeviceIdentifierTool.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "DeviceIdentifierTool.h"
#import <AdSupport/ASIdentifierManager.h>
#import <SAMKeychain/SAMKeychain.h>

#import <AppTrackingTransparency/AppTrackingTransparency.h>

static NSString *const kKeychainService = @"com.yourcompany.app";
static NSString *const kIDFVKey = @"deviceIDFV";

@implementation DeviceIdentifierTool

+ (NSString *)getIDFVWithKeychain {
    // 1. 尝试从钥匙串读取
    NSString *savedIDFV = [SAMKeychain passwordForService:kKeychainService account:kIDFVKey];
    
    if (savedIDFV.length > 0) {
        return savedIDFV;
    }
    
    // 2. 获取新IDFV并存入钥匙串
    NSString *newIDFV = [UIDevice currentDevice].identifierForVendor.UUIDString;
    [SAMKeychain setPassword:newIDFV forService:kKeychainService account:kIDFVKey];
    
    return newIDFV;
}

+ (NSString *)getIDFA {
    if (@available(iOS 14, *)) {
        // 需在Info.plist添加NSUserTrackingUsageDescription
        ATTrackingManagerAuthorizationStatus status = [ATTrackingManager trackingAuthorizationStatus];
        if (status != ATTrackingManagerAuthorizationStatusAuthorized) {
            return nil;
        }
    }
    return [ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString;
}

@end
