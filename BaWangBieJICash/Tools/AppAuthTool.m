//
//  AppAuthTool.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "AppAuthTool.h"
#import "ProductDetailModel.h"
#import "CertificationListViewController.h"
#import "IdentityViewController.h"
#import "PersonalViewController.h"
#import "JobViewController.h"
#import "ContactViewController.h"

@interface AppAuthTool ()

@property (nonatomic ,strong) ProductDetailModel *proDetailModel;

@property (nonatomic, strong) NSDictionary <NSString *,Class> *map;

@property (nonatomic, copy) NSString *bankUrl;

@end

@implementation AppAuthTool

+ (instancetype)tool
{
    static dispatch_once_t onceToken;
    static AppAuthTool *_tool = nil;
    dispatch_once(&onceToken, ^{
        if (_tool == nil) {
            _tool = [AppAuthTool new];
        }
    });
    return _tool;
}

- (void)setProDetailModel:(ProductDetailModel *)proDetailModel
{
    _proDetailModel = proDetailModel;
}

- (BOOL)hasInfo
{
    return self.proDetailModel != nil;
}

- (void)getAndUpdateNextAuthStatusWithProductID:(NSInteger)productID StepBlock:(PC_AuthStepBlock)stepBlock
{
    _productID = productID;
    __weakSelf;
    [NetMonitorTool.tool postWithPath:@"/before/pumbaa" Parameters:@{@"filmmaker":@(productID)} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        __strongSelf;
        if (!responseModel.success) {
            stepBlock(@"");
            [ProgressHud showMessage:responseModel.pc_flag];
            return;
        }
        self.proDetailModel = [ProductDetailModel ACModel_withDict:responseModel.pc_portal];
        stepBlock([self getNextAuthStepValue]);
    } FailBlock:^(NSError * _Nonnull error) {
        stepBlock(@"");
    }];
}

/// 如果没有请求到模型返回 ``空字符串``
- (NSString *)getNextAuthStepValue
{
    if (self.proDetailModel == nil) {
        return @"";
    }
    return self.proDetailModel.pc_postal.pc_receiving;
}

- (NSString *)getNextAuthStatus
{
    return [self getNextAuthStepValue];
}

/// 跳转到下一步的控制器
- (void)jumpToNextStepVC
{
    __weakSelf;
    
    [self getAndUpdateNextAuthStatusWithProductID:self.productID StepBlock:^(NSString * _Nonnull authType) {
        __strongSelf;
        
        NSString *nextStep = AppAuthTool.tool.getNextAuthStatus;
        
        PC_ProduceDetailModel_Rec *nextAuthModel = nil;
        for (PC_ProduceDetailModel_Rec *authStep in  self.proDetailModel.pc_rec) {
            if ([authStep.pc_receiving isEqualToString:nextStep]) {
                // 点的就是下一步
                nextAuthModel = authStep;
                break;
            }else if ([nextStep isEqualToString:@""]) {
                // 如果下一步为空就调用【下单】（需要loading）接口获取跳转url，跳转到相应页面。
                for (__kindof UIViewController *subVC in UIViewController.currentVC.navigationController.childViewControllers) {
                    if ([subVC isMemberOfClass:CertificationListViewController.class]) {
                        [UIViewController.currentVC.navigationController popToViewController:subVC animated:true];
                        return;
                    }
                }
            }
        }
        if (nextAuthModel == nil) return;
        
        NSString *receiving = nextAuthModel.pc_receiving;
        if ([receiving isEqualToString:@"ofyesa"]) {
    
            IdentityViewController *vc = [IdentityViewController new];
            vc.title = nextAuthModel.pc_beck;
            
            [UIViewController.currentVC.navigationController pushViewController:vc animated:YES];
            
        }else if ([receiving isEqualToString:@"ofyesb"]){
            PersonalViewController *vc = [PersonalViewController new];
            vc.title = nextAuthModel.pc_beck;
            vc.productID = self.productID;
            [UIViewController.currentVC.navigationController pushViewController:vc animated:YES];
            
        }else if ([receiving isEqualToString:@"ofyesc"]){
            JobViewController *vc = [JobViewController new];
            vc.title = nextAuthModel.pc_beck;
            vc.productID = self.productID;
            [UIViewController.currentVC.navigationController pushViewController:vc animated:YES];
            
        }else if ([receiving isEqualToString:@"ofyesd"]){
            ContactViewController *vc = [ContactViewController new];
            vc.title = nextAuthModel.pc_beck;
            vc.productID = self.productID;
            [UIViewController.currentVC.navigationController pushViewController:vc animated:YES];
            
        }else if ([receiving isEqualToString:@"ofyese"]){
            NSString *url = nextAuthModel.pc_merely;
            self.bankUrl = url;
            JumpTool.tool.isInAuthMode = true;
            [JumpTool.tool jumpWithStr:url];
            JumpTool.tool.isInAuthMode = false;
        }
    }];
}

/// 跳转到下一步的控制器
- (void)jumpToNextStepVCWithTypeStr:(NSString *)typeStr IsComplete:(BOOL)isComplete Count:(NSInteger)count
{
    
    if (!isComplete) {
        [self jumpToNextStepVC];
        return;
    }
    
    if ([typeStr isEqualToString:@"ofyesa"]) {

        IdentityViewController *vc = [IdentityViewController new];
        vc.title = self.proDetailModel.pc_rec[count].pc_beck;
        [UIViewController.navVC pushViewController:vc animated:true];
    }else if ([typeStr isEqualToString:@"ofyesb"]){
        PersonalViewController *vc = [PersonalViewController new];
        vc.title = self.proDetailModel.pc_rec[count].pc_beck;
        vc.productID = self.productID;
        [UIViewController.currentVC.navigationController pushViewController:vc animated:YES];
    }else if ([typeStr isEqualToString:@"ofyesc"]){
        JobViewController *vc = [JobViewController new];
        vc.title = self.proDetailModel.pc_rec[count].pc_beck;
        vc.productID = self.productID;
        [UIViewController.currentVC.navigationController pushViewController:vc animated:YES];
    }else if ([typeStr isEqualToString:@"ofyesd"]){
        ContactViewController *vc = [ContactViewController new];
        vc.title = self.proDetailModel.pc_rec[count].pc_beck;
        vc.productID = self.productID;
        [UIViewController.currentVC.navigationController pushViewController:vc animated:YES];
    }else if ([typeStr isEqualToString:@"ofyese"]){
        NSString *url = self.proDetailModel.pc_rec[count].pc_merely;
        [JumpTool.tool jumpWithStr:url];
    }
}
@end
