//
//  NSData+ACAutoCode.h
//  ACAutoCode
//
//  Created by Acery on 2024/10/17.
//
//
//       ,---,
//      '  .' \
//     /  ;    '.                          __  ,-.
//    :  :       \                       ,' ,'/ /|
//    :  |   /\   \     ,---.     ,---.  '  | |' |   .--,
//    |  :  ' ;.   :   /     \   /     \ |  |   ,' /_ ./|
//    |  |  ;/  \   \ /    / '  /    /  |'  :  /, ' , ' :
//    '  :  | \  \ ,'.    ' /  .    ' / ||  | '/___/ \: |
//    |  |  '  '--'  '   ; :__ '   ;   /|;  : | .  \  ' |
//    |  :  :        '   | '.'|'   |  / ||  , ;  \  ;   :
//    |  | ,'        |   :    :|   :    | ---'    \  \  ;
//    `--''           \   \  /  \   \  /           :  \  \
//                     `----'    `----'             \  ' ;
//                                                   `--`


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (ACAutoCode)

#pragma mark - Base 64

/// Base 64 解码
- (NSString *)base64DecodeToString;
- (NSData *)base64Decode;

/// Base 64 编码
- (NSString *)base64EncodeToString;
- (NSData *)base64Encode;

@end

NS_ASSUME_NONNULL_END
