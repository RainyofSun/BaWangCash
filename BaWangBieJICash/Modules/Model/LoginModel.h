//
//  LoginModel.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginModel : NSObject

@property (nonatomic, assign) NSInteger  pc_wrCKuW;

@property (nonatomic, strong) NSNull * pc_cgU89;

@property (nonatomic, copy) NSString * pc_a2geOPoGMGA;

@property (nonatomic, copy) NSString * pc_Ozkjc94QBfZc;

@property (nonatomic, assign) NSInteger  pc_uid;

@property (nonatomic, assign) NSInteger  pc_isOld;

@property (nonatomic, copy) NSString * pc_raging;

@property (nonatomic, copy) NSString * pc_silhouetted;

@property (nonatomic, copy) NSString * pc_jBzlJ;

@property (nonatomic, strong) NSNull * pc_1FR8rAfxW6;

@property (nonatomic, copy) NSString * pc_quite;

@property (nonatomic , strong) NSDictionary *modelDict;

+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

- (void)saveToDisk;
+ (void)removeFromDisk;
+ (instancetype)readFromDisk;

@end

NS_ASSUME_NONNULL_END
