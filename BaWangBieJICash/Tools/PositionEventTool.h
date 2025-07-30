//
//  PositionEventTool.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, RiskPointType) {
    RiskPointType_Register = 1,
    RiskPointType_IDCard,
    RiskPointType_FrontPhoto,
    RiskPointType_Selfie,
    RiskPointType_PersonalInfo,
    RiskPointType_WorkInfo,
    RiskPointType_Contacts,
    RiskPointType_BindCard,
    RiskPointType_LoanStart,
    RiskPointType_LoanEnd
};

@interface PositionEventTool : NSObject

@property (nonatomic, assign) NSTimeInterval start;
@property (nonatomic, assign) NSTimeInterval end;
@property (nonatomic, assign) RiskPointType type;

+ (instancetype)modelWithType:(RiskPointType)type StartTime:(NSTimeInterval)startTime;

@end

NS_ASSUME_NONNULL_END
