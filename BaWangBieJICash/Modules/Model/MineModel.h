//
//  MineModel.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import <Foundation/Foundation.h>

@class PC_MeModel_Inserting,PC_MeModel_Customerservice,PC_MeModel_Userinfo;

NS_ASSUME_NONNULL_BEGIN

@interface MineModel : NSObject

@property (nonatomic, assign) NSInteger  pc_YTPM8twD3rX;

@property (nonatomic, strong) NSArray<PC_MeModel_Inserting *> *pc_inserting;

@property (nonatomic, strong) NSNull * pc_JAWxIq;

@property (nonatomic, copy) NSString * pc_FK72UBDa;

@property (nonatomic, copy) NSString * pc_DCtcXdC1;

@property (nonatomic, strong) NSArray<PC_MeModel_Customerservice *> *pc_customerService;

@property (nonatomic, copy) NSString * pc_ZLVHbVD;

@property (nonatomic, copy) NSString * pc_Ea7V;

@property (nonatomic, strong) NSNull * pc_ikL2mVwgF;

@property (nonatomic, assign) NSInteger  pc_certStatus;

@property (nonatomic, copy) NSString * pc_TUofoo7;

@property (nonatomic, strong) PC_MeModel_Userinfo * pc_userInfo;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_MeModel_Inserting : NSObject

@property (nonatomic, copy) NSString * pc_gathered;

@property (nonatomic, copy) NSString * pc_beck;

@property (nonatomic, copy) NSString * pc_merely;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_MeModel_Customerservice : NSObject

@property (nonatomic, copy) NSString * pc_merely;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

@interface PC_MeModel_Userinfo : NSObject

@property (nonatomic, copy) NSString * pc_userphone;

@property (nonatomic, copy) NSString * pc_raging;

@property (nonatomic, assign) NSInteger  pc_isReal;


+ (instancetype)ACModel_withDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
