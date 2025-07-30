//
//  AppAuthTool+ID.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "AppAuthTool.h"
#import "UserIdentifiInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AuthToolGetUserIDModelBlock)(UserIdentifiInfoModel  * _Nullable model);

@interface AppAuthTool (ID)

- (void)getUserIDModelWithBlock:(AuthToolGetUserIDModelBlock)block;

@end

NS_ASSUME_NONNULL_END
