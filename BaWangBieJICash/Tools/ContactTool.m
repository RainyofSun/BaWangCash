//
//  ContactTool.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "ContactTool.h"

@interface ContactTool ()<CNContactPickerDelegate>

@property (nonatomic, strong) CNContactStore *store;

@end

@implementation ContactTool

+ (instancetype)tool
{
    static dispatch_once_t onceToken;
    static ContactTool *_tool = nil;
    dispatch_once(&onceToken, ^{
        if (_tool == nil) {
            _tool = [ContactTool new];
        }
    });
    return _tool;
}

- (void)requestContactPermission
{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    if (@available(iOS 18.0, *)) {
        if (status == CNAuthorizationStatusDenied) {
            [self showCustomDeniedAlert]; // 自定义拒绝弹窗
        } else if (status == CNAuthorizationStatusNotDetermined) {
            // 如果没有确定过权限，请求权限
            [self.store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    [self showContactVC];
                } else {
                    [self showCustomDeniedAlert];
                }
            }];
        } else if (status == CNAuthorizationStatusAuthorized || status == CNAuthorizationStatusLimited){
            [self showContactVC];
        }
    } else {
        if (status == CNAuthorizationStatusDenied) {
            [self showCustomDeniedAlert]; // 自定义拒绝弹窗
        } else if (status == CNAuthorizationStatusNotDetermined) {
            // 如果没有确定过权限，请求权限
            [self.store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    [self showContactVC];
                } else {
                    [self showCustomDeniedAlert];
                }
            }];
        } else if (status == CNAuthorizationStatusAuthorized){
            [self showContactVC];
        }
    }
}

- (void)showCustomDeniedAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Permission denied"
                                                                  message:@"Please enable address book permissions in the settings"
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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIViewController.currentVC presentViewController:alert animated:YES completion:nil];
    });
}

- (void)requestContactAllDataWithBlock:(PC_ContactTool_UpContact)completeBlock
{
    NSMutableArray *contactsArray = [NSMutableArray array];
    NSArray *typeArray = @[CNContactGivenNameKey,
                           CNContactPhoneNumbersKey,
                           CNContactFamilyNameKey,
                           CNContactIdentifierKey,
                           CNContactEmailAddressesKey,
                           CNContactBirthdayKey];
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc]initWithKeysToFetch:typeArray];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSError *error;
        [self.store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            NSMutableDictionary *contactDict = [NSMutableDictionary dictionary];
                   
            NSString *upName = @"";
            if ([contact.givenName isExist] && [contact.familyName isExist]) {
                upName = [NSString stringWithFormat:@"%@ %@", contact.givenName, contact.familyName];
            }else if ([contact.familyName isExist]){
                upName = [NSString stringWithFormat:@"%@",contact.familyName];
            }else if ([contact.givenName isExist]){
                upName = [NSString stringWithFormat:@"%@",contact.givenName];
            }
            [contactDict setObject:upName forKey:@"shoot"];
                
            // 电话处理
            NSString *phones = @"";
            for (CNLabeledValue *phone in contact.phoneNumbers) {
                CNPhoneNumber *phoneNumber = phone.value;
                NSString *phoneNum = phoneNumber.stringValue;
                if ([phoneNum isExist]) {
                    phones = [phones stringByAppendingFormat:@"%@,",phoneNum];
                }
            }
            if (![phones isEqualToString:@""]) phones = [phones substringWithRange:NSMakeRange(0, phones.length-1)];
            [contactDict setObject:phones forKey:@"bender"];
                   
            NSDate *birthday = contact.birthday.date;
            [contactDict setObject:birthday == nil ? @0 : @([birthday timeIntervalSince1970]) forKey:@"flicks"];
    
            // 邮箱处理
            NSString *emails = @"";
            for (CNLabeledValue *email in contact.emailAddresses) {
                if ([email.value isKindOfClass:[NSString class]]) {
                    NSString *emailStr = email.value;
                    emails = [emails stringByAppendingFormat:@"%@,",emailStr];
                }
            }
            if (![emails isEqualToString:@""]) emails = [emails substringWithRange:NSMakeRange(0, emails.length-1)];
            [contactDict setObject:emails != nil ? emails : @"" forKey:@"vogt"];
            
            [contactsArray addObject:contactDict];
        }];
        if (completeBlock) completeBlock(contactsArray);
    });
}

- (void)showContactVC
{
    dispatch_async(dispatch_get_main_queue(), ^{
        CNContactPickerViewController *contactVC = [[CNContactPickerViewController alloc] init];
        contactVC.delegate = self;
        [UIViewController.currentVC presentViewController:contactVC animated:YES completion:nil];
    });
}

#pragma mark - deelegate

// 选中联系人回调
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    
    NSString *name = @"";
    NSString *phone = @"";
    if ([contact.givenName isExist] && [contact.familyName isExist]) {
        name = [NSString stringWithFormat:@"%@ %@", contact.givenName, contact.familyName];
    }else if ([contact.familyName isExist]){
        name = [NSString stringWithFormat:@"%@",contact.familyName];
    }else if ([contact.givenName isExist]){
        name = [NSString stringWithFormat:@"%@",contact.givenName];
    }
   // name = [NSString stringWithFormat:@"%@%@", contact.familyName, contact.givenName];
    phone = contact.phoneNumbers[0].value.stringValue;
   
//    NSString *note = contact.note;
//    NSDate *birthday = contact.birthday.date;
//    NSString *emailAddress = contact.emailAddresses.count > 0 ? contact.emailAddresses[0].value : @"";
    
    if (name.length == 0 || phone.length == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHud showMessage:@"Name or phone number is empty"];
        });
    }else {
        NSString *string = [NSString stringWithFormat:@"%@-%@", name, phone];
        [ProgressHud showMessage:string];
    }
    
    if (self.didSelectContact) self.didSelectContact(phone,name);
}


- (CNContactStore *)store
{
    if (_store == nil) {
        _store = [[CNContactStore alloc]init];
    }
    return _store;
}

@end
