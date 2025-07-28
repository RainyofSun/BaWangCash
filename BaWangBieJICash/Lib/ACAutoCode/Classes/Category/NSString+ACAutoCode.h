//
//  NSString+ACAutoCode.h
//  ACAutoCode
//
//  Created by Acery on 2022/7/15.
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

@interface NSString (ACAutoCode)

/// 是否是空字符串
- (BOOL)isEmptyCharacters;

/// 字符串是否存在
- (BOOL)isExist;

/// josn -> dict
- (NSDictionary *)convertToDictionary;

/// json -> array
- (NSArray *)convertToArray;

/// 把字典和数组转换成json字符串
/// - Parameter obj: 字典或者数组
+ (NSString *)convertObjToJson:(id)obj;

/// 获取数字的缩写
/// k m b
- (instancetype)getNumberAbbr;

/// 价格转换为每隔3位用逗号分割
/// - Parameters:
///   - value: 价格
///   - show: 是否显示小数点后面
///   - minPointWidth: 最小小数位数
///   - maxPointWidth: 最大小数位数
+ (NSString *)makePriceStrWithNumber:(CGFloat)value showPoint:(BOOL)show MinPointWidth:(NSUInteger)minPointWidth MaxPointWidth:(NSUInteger)maxPointWidth;

#pragma mark - Base 64

/// Base 64 解码
- (NSData *)base64DecodeToData;
- (NSString *)base64Decode;

/// Base 64 编码
- (NSData *)base64EncodeToData;
- (NSString *)base64Encode;

#pragma mark - Bounds

/// 获取单行文字宽度
/// - Parameter font: 使用的字体
- (CGFloat)getSingleWidthWithFont:(UIFont *)font;

/// 获取字符串宽度，并不会考虑多行的最大宽度，多行情况下考虑第一行
/// 一般用来获取单行文字宽度
/// - Parameters:
///   - height: 指定的高度，如果需要获取单行的传入``0``
///   - font: 使用的字体
- (CGFloat)getWidthWithHeight:(CGFloat)height Font:(UIFont *)font;

/// 获取文字高度
/// - Parameters:
///   - width: 指定高度
///   - font: 使用字体
- (CGFloat)getHeightWithWidth:(CGFloat)width Font:(UIFont *)font;

#pragma mark - Time

/// 通过时间戳和格式字符串构建时间字符串
/// - Parameters:
///   - stamp: 时间戳
///   - format: 格式
+ (instancetype)createTimeStringWithStamp:(NSTimeInterval)stamp Format:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
