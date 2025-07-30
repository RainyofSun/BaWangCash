//
//  ContactTool.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PC_ContactTool_DidSelectContact)(NSString *phone, NSString *name);
typedef void(^PC_ContactTool_UpContact)(NSMutableArray *contact);

@interface ContactTool : NSObject

@property (nonatomic, copy) PC_ContactTool_DidSelectContact didSelectContact;

+ (instancetype)tool;



/// 弹出通讯录
- (void)showContactVC;

- (void)requestContactPermission;

- (void)requestContactAllDataWithBlock:(PC_ContactTool_UpContact)completeBlock;
@end

NS_ASSUME_NONNULL_END
