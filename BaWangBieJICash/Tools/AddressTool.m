//
//  AddressTool.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "AddressTool.h"

@implementation AddressTool

+ (instancetype)tool
{
    static AddressTool *_tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [AddressTool new];
    });
    return _tool;
}

- (void)updateAdressInfo
{
    [NetMonitorTool.tool getWithPath:@"/before/reunion" Parameters:@{} SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        self.addressModel = [AddressModel ACModel_withDict:responseModel.pc_portal];
    } FailBlock:^(NSError * _Nonnull error) {
            
    }];
}

- (void)setAddressModel:(AddressModel *)addressModel
{
    _addressModel = addressModel;
}

- (NSString *)getAdressWithCode:(NSString *)code
{
    NSString *adress = @"";
    
    NSArray <NSString *>*codes = [code componentsSeparatedByString:@"|"];
    
    PC_AdressModel_Inserting *city = nil;
    for (PC_AdressModel_Inserting *_city in self.addressModel.pc_inserting) {
        if (_city.pc_consumers == codes.firstObject.integerValue) {
            city = _city;
            adress = [adress stringByAppendingFormat:@"%@ ",_city.pc_shoot];
        }
    }
    
    PC_AdressModel_Inserting *city_1 = nil;
    for (PC_AdressModel_Inserting *_city in city.pc_inserting) {
        if (_city.pc_consumers == codes[1].integerValue) {
            city_1 = _city;
            adress = [adress stringByAppendingFormat:@"%@ ",_city.pc_shoot];
        }
    }
    
    for (PC_AdressModel_Inserting *_city in city_1.pc_inserting) {
        if (_city.pc_consumers == codes[2].integerValue) {
            adress = [adress stringByAppendingFormat:@"%@ ",_city.pc_shoot];
        }
    }
    
    return adress;
}

@end
