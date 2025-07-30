//
//  PositionTool.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import "PositionTool.h"
#import "LoginLogic.h"
#import "DeviceIdentifierTool.h"

@interface PositionTool ()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation* location;

@property (nonatomic, strong) NSMutableDictionary <NSString * ,PositionEventTool *> *eventMap;

@end

@implementation PositionTool

+ (instancetype)tool
{
    static dispatch_once_t onceToken;
    static PositionTool *_tool = nil;
    dispatch_once(&onceToken, ^{
        if (_tool == nil) {
            _tool = [PositionTool new];
            
        }
    });
    return _tool;
}

- (void)requestWhenInUsePermission
{
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation]; // 开始更新位置信息
}

- (void)checkLocationPermission
{
    CLAuthorizationStatus status = self.locationManager.authorizationStatus;
    
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            [self requestWhenInUsePermission]; // 未决定时请求权限
            break;
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
            if ([self shouldShowDailyReminder]) {
                [self showPermissionAlertIfNeeded];
            }
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self startUpdatingLocation]; // 已授权时开始定位
            break;
    }
}

- (void)requestTemporaryFullAccuracyWithComplete:(void(^)(bool succ))completeBlock
{
    CLAuthorizationStatus status = self.locationManager.authorizationStatus;
    if (status == kCLAuthorizationStatusAuthorizedAlways ||
        status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager requestTemporaryFullAccuracyAuthorizationWithPurposeKey:@"Location" completion:^(NSError *error){
            if (completeBlock) completeBlock(true);
        }];
    }else{
        if (completeBlock) completeBlock(false);
    }
}

- (void)startUpdatingLocation
{
    CLAuthorizationStatus status = self.locationManager.authorizationStatus;
    if (status == kCLAuthorizationStatusAuthorizedAlways ||
        status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
    }
}

- (void)showPermissionAlertIfNeeded
{
    if (LoginLogic.tool.loginConfig.pc_king != 1) return;
    UIAlertController *alert = [UIAlertController
        alertControllerWithTitle:@"Location permission is required"
        message:@"Enable location permission to help FastLending accurately assess loan needs and provide considerate and localized service."
        preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *settingsAction = [UIAlertAction
        actionWithTitle:@"To setting"
        style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:
                [NSURL URLWithString:UIApplicationOpenSettingsURLString]
                options:@{}
                completionHandler:nil];
        }];
    
    UIAlertAction *cancelAction = [UIAlertAction
        actionWithTitle:@"Cancel"
        style:UIAlertActionStyleCancel
        handler:nil];
    
    [alert addAction:settingsAction];
    [alert addAction:cancelAction];
    
    UIViewController *rootVC = UIViewController.nowWindow.rootViewController;
    [rootVC presentViewController:alert animated:YES completion:nil];
}

- (BOOL)shouldShowDailyReminder
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *lastReminderDate = [defaults objectForKey:@"LastLocationReminderDate"];
    
    if (!lastReminderDate) {
        [defaults setObject:[NSDate date] forKey:@"LastLocationReminderDate"];
        return YES;
    }
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:lastReminderDate];
    if (interval >= 86400) { // 24小时
        [defaults setObject:[NSDate date] forKey:@"LastLocationReminderDate"];
        return YES;
    }
    return NO;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject]; // 获取最新的位置信息
    self.location = location;
    // 上报位置信息，例如发送到服务器
    [self reportPositionWith:location];
    [self.locationManager stopUpdatingLocation];
}
 
- (void)reportPositionWith:(CLLocation *)location
{
    CLGeocoder *coder = [[CLGeocoder alloc]init];
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            // 地标信息
        if (error || placemarks.count == 0) {
            NSLog(@"Geocode failed: %@", error.localizedDescription);
            return;
        }
        CLPlacemark *placemark = [placemarks firstObject];
        NSString *jiedao = @"";
        CLLocationDegrees latitude = 0;
        CLLocationDegrees longitude = 0;
        
        if (placemark.thoroughfare != nil) {
            jiedao = [jiedao stringByAppendingFormat:@"%@",placemark.thoroughfare];
        }
        
        if (placemark.subThoroughfare != nil) {
            jiedao = [jiedao stringByAppendingFormat:@"%@",placemark.subThoroughfare];
        }
        
        if (location != nil) {
            latitude = location.coordinate.latitude;
            longitude = location.coordinate.longitude;
        }
       
        NSDictionary *dict = @{
            @"commentator":(placemark.administrativeArea != nil ? placemark.administrativeArea : @""),  //省
            @"golf":(placemark.ISOcountryCode != nil ? placemark.ISOcountryCode : @""),//国家code
            @"kind":(placemark.country != nil ? placemark.country : @""),//国家
            @"kerzner":jiedao,//街道
            @"sparks":@(latitude),//纬度
            @"ron":@(longitude),//经度
            @"liana":(placemark.locality != nil ? placemark.locality : @""),//市
            @"sock":(placemark.subLocality != nil ? placemark.subLocality : @"")//区
        };
        
        [NetMonitorTool.tool postWithPath:@"/before/arrested" Parameters:dict SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        } FailBlock:^(NSError * _Nonnull error) {
        }];
    }];
}

#pragma mark - log

#pragma mark - 埋点控制

- (void)startReportWithType:(RiskPointType)type
{
    // 开始定位
    [self startUpdatingLocation];
    
    // 记录开始时间
    NSTimeInterval timestamp = [NSDate.date timeIntervalSince1970];
    PositionEventTool *eventModel = [PositionEventTool modelWithType:type StartTime:timestamp];
    [self.eventMap setObject:eventModel forKey:FORMAT(@"%ld",type)];
}

- (void)endReportWithType:(RiskPointType)type
{
    PositionEventTool *eventModel = [self.eventMap objectForKey:FORMAT(@"%ld",type)];
    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
    eventModel.end = endTime;
    
    [self reportRiskPoint:type startTime:eventModel.start endTime:endTime orderId:nil];
}
- (void)endReportWithType:(RiskPointType)type orderId:(NSString *)orderId
{
    PositionEventTool *eventModel = [self.eventMap objectForKey:FORMAT(@"%ld",type)];
    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
    eventModel.end = endTime;
    
    [self reportRiskPoint:type startTime:eventModel.start endTime:endTime orderId:orderId];
}


- (void)reportRiskPoint:(RiskPointType)type
             startTime:(NSTimeInterval)startTime
               endTime:(NSTimeInterval)endTime
              orderId:(NSString *)orderId
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"earning"] = @(type).stringValue;
    params[@"icwxp"] = @"2"; // iOS标识
    params[@"plot"] = [DeviceIdentifierTool getIDFVWithKeychain];
    params[@"xp"] = [self idfa];
    params[@"ron"] = self.location == nil ? @0 : @(self.location.coordinate.longitude);
    params[@"sparks"] = self.location == nil ? @0 : @(self.location.coordinate.latitude);
    params[@"warriors"] = @((NSInteger)startTime).stringValue;
    params[@"incognito"] = @((NSInteger)endTime).stringValue;
   
    if (orderId) {
        params[@"noteworthy"] = orderId;
    }
    
    [self asyncPostRequestWithParams:params];
}

- (void)asyncPostRequestWithParams:(NSDictionary *)params
{
    [NetMonitorTool.tool postWithPath:@"/before/regulars" Parameters:params SuccBlock:^(BaseNetResponseModel * _Nonnull responseModel) {
        
        if (!responseModel.success) {
            return;
        }
    } FailBlock:^(NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark - init

- (CLLocationManager *)locationManager
{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kCLDistanceFilterNone; // 更改此值以减少更新频率
        
       
    }
    return _locationManager;
}


- (NSMutableDictionary<NSString *, PositionEventTool *> *)eventMap
{
    if (_eventMap == nil) {
        _eventMap = [NSMutableDictionary dictionary];
    }
    return _eventMap;
}

- (NSString *)idfa
{
    return [XYUUID uuidForIDFA];
}

- (NSString *)idfv
{
    return [XYUUID uuidForIDFV];
}

@end
