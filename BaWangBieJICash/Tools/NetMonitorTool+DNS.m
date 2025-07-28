//
//  NetMonitorTool+DNS.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "NetMonitorTool+DNS.h"

@implementation NetMonitorTool (DNS)

- (void)getDNSConfigWithSuccBlock:(void(^)( NSData * _Nullable data))successBlock
{
    [self getDataWithoutHeadWithFullPath:@"https://ph01-dc.oss-ap-southeast-6.aliyuncs.com/power-cash/687087c410071.json" Parameters:@{} SuccBlock:^(NSData * _Nonnull responseData) {
        if (successBlock) successBlock(responseData);
    } FailBlock:^(NSError * _Nonnull error) {
        if (successBlock) successBlock(nil);
    }];
}

/// 切换动态域名
- (void)switchDDNSWithSuccBlock:(void(^)(bool succ))successBlock
{
    __weakSelf;
    [self getDNSConfigWithSuccBlock:^(NSData * _Nullable data) {
        
        if (data == nil || ![data isKindOfClass:NSData.class]) {
            if (successBlock) successBlock(false);
            return;
        }
        
        NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSArray *dnss = [json convertToArray];
        
        if (dnss.count < 1) return;
        
        dispatch_queue_t globalqueue = dispatch_get_global_queue(0, 0);
        dispatch_group_t group = dispatch_group_create();
        
        __block bool isSucc = false;
        
        for (NSDictionary *dict in dnss) {
            SwitchNetModel *model = [SwitchNetModel ModelWithDict:dict];
            [self.dnsModels addObject:model];
            
            dispatch_group_enter(group);
            dispatch_group_async(group, globalqueue, ^{
                [self checkDNSModel:model WithSuccBlock:^(SwitchNetModel *subModel, bool succ) {
                    __strongSelf;
                    dispatch_group_leave(group);
                    if (succ && !isSucc) {
                        isSucc = true;
                        [self setCuurentDNSModel:subModel];
                        if (successBlock) successBlock(true);
                    }
                }];
            });
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            if (!isSucc) {
                if (successBlock) successBlock(false);
            }
        });
    }];
}

- (void)checkDNSModel:(SwitchNetModel *)dnsModel WithSuccBlock:(void(^)(SwitchNetModel *model, bool succ))succBlock
{
    NSDictionary *dict = @{@"schlefaz":@"en",@"camp":@([NetMonitorTool isProxy]),@"kitsch":@([NetMonitorTool isVPNConnected])};
    
    NSString *path = [dnsModel.pc stringByAppendingString:@"before/schlefaz"];
    
    [NetMonitorTool.tool postWithFullPath:path Parameters:dict ProgressBlock:nil SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        if (succBlock) succBlock(dnsModel,responseModel.success);
    } FailBlock:^(NSError * _Nonnull error) {
        if (succBlock) succBlock(dnsModel,false);
    }];
}

- (void)setCuurentDNSModel:(SwitchNetModel *)cuurentDNSModel
{
    PCLog(@"当前动态域名 -> %@",cuurentDNSModel.pc);
    [cuurentDNSModel addPropertyWithKey:@selector(cuurentDNSModel) ToObject:self PropertyType:PC_PropertyType_RETAIN];
}

- (SwitchNetModel *)cuurentDNSModel
{
    return [SwitchNetModel getPropertyWithKey:@selector(cuurentDNSModel) FromObject:self];
}

/// 获取当前域名
- (NSString *)getCuurentDNS
{
    if (self.cuurentDNSModel == nil) {
        return @"https://pcm.versara-lending.com/resort";
    }
    return [self.cuurentDNSModel.pc substringWithRange:NSMakeRange(0, self.cuurentDNSModel.pc.length-1)];
}

@end
