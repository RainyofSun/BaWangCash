//
//  PositionEventTool.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "PositionEventTool.h"

@implementation PositionEventTool

+ (instancetype)modelWithType:(RiskPointType)type StartTime:(NSTimeInterval)startTime
{
    PositionEventTool *model = [PositionEventTool new];
    model.type = type;
    model.start = startTime;
    return model;
}

@end
