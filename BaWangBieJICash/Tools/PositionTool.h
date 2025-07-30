//
//  PositionTool.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import <Foundation/Foundation.h>
#import "PositionEventTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface PositionTool : NSObject

//订单号 风控埋点接口会用到【重要】
@property (nonatomic, copy) NSString * orderId;

+ (instancetype)tool;

#pragma mark - position

- (void)startUpdatingLocation;
- (void)checkLocationPermission;

- (void)requestTemporaryFullAccuracyWithComplete:(void(^)(bool succ))completeBlock;

- (NSString *)idfv;

#pragma mark - log

- (void)startReportWithType:(RiskPointType)type;

- (void)endReportWithType:(RiskPointType)type;
- (void)endReportWithType:(RiskPointType)type orderId:(NSString *)orderId;

- (void)reportRiskPoint:(RiskPointType)type
              startTime:(NSTimeInterval)startTime
                endTime:(NSTimeInterval)endTime
                orderId:(nullable NSString *)orderId;

@end

NS_ASSUME_NONNULL_END
