//
//  AppAuthTool+ID.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "AppAuthTool+ID.h"

@implementation AppAuthTool (ID)

- (void)getUserIDModelWithBlock:(AuthToolGetUserIDModelBlock)block
{
    [NetMonitorTool.tool postWithPath:@"/before/timon" Parameters:@{@"filmmaker":@(self.productID)} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        if (!responseModel.success) {
            block(nil);
            [ProgressHud showMessage:responseModel.pc_flag];
            return;
        }
        block([UserIdentifiInfoModel ACModel_withDict:responseModel.pc_portal]);
    } FailBlock:^(NSError * _Nonnull error) {
        block(nil);
    }];
}

@end
