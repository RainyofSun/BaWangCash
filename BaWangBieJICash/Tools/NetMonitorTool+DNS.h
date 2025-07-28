//
//  NetMonitorTool+DNS.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "NetMonitorTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetMonitorTool (DNS)

@property (nonatomic , strong) SwitchNetModel *cuurentDNSModel;

/// 切换动态域名
- (void)switchDDNSWithSuccBlock:(void(^)(bool succ))successBlock;

/// 获取当前域名
- (NSString *)getCuurentDNS;

@end

NS_ASSUME_NONNULL_END
