//
//  LoginCodeModel.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import <Foundation/Foundation.h>

@class PC_LoginCodeModel_Consists;

NS_ASSUME_NONNULL_BEGIN

@interface LoginCodeModel : NSObject

@property (nonatomic, copy) NSString * pc_qFFG2rUDMAaQ;

@property (nonatomic, copy) NSString * pc_NG8dKzUw1B;

@property (nonatomic, copy) NSString * pc_c3lvJoFeb;

@property (nonatomic, copy) NSString * pc_rEFy;

@property (nonatomic, strong) NSNull * pc_mc5yMCj9Hr;

@property (nonatomic, assign) NSInteger  pc_QlVeG;

@property (nonatomic, copy) NSString * pc_lkQUjvmy69;

@property (nonatomic, strong) PC_LoginCodeModel_Consists * pc_consists;

@property (nonatomic, strong) NSNull * pc_0Nixf1TV;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_LoginCodeModel_Consists : NSObject

@property (nonatomic, copy) NSString * pc_flag;

@property (nonatomic, copy) NSString * pc_RCaptchaKey;

@property (nonatomic, copy) NSString * pc_consists;

@property (nonatomic, copy) NSString * pc_snob;

@property (nonatomic, assign) NSInteger  pc_expecting;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
