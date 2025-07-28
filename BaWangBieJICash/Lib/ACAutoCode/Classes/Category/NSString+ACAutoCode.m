//
//  NSString+ACAutoCode.m
//  ACAutoCode
//
//  Created by Acery on 2022/7/15.
//

#import "NSString+ACAutoCode.h"
#import "NSData+ACAutoCode.h"


@implementation NSString (ACAutoCode)

- (BOOL)isEmptyCharacters
{
    NSMutableCharacterSet *set = [NSMutableCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *lastText = [self stringByTrimmingCharactersInSet:set];
    return (lastText.length == 0);
}


- (BOOL)isExist
{
    return ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0 && ![self isKindOfClass:[NSNull class]]);
}

+ (NSString *)convertObjToJson:(id)obj
{
    if (obj == nil && [obj isKindOfClass:NSNull.class]) return @"";
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                     options:NSJSONWritingPrettyPrinted error:nil];
    NSString *strs = [[NSString alloc] initWithData:jsonData
                                          encoding:NSUTF8StringEncoding];
    return strs;
}

- (NSDictionary *)convertToDictionary
{
    NSDictionary *dict = @{};
    
    if (![self isExist]) return dict;
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *_dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) return dict;
    
    if ([_dict isKindOfClass:NSDictionary.class]) dict = _dict;
    
    return dict;
}

- (NSArray *)convertToArray
{
    NSArray *array = @[];
    
    if (![self isExist]) return array;
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSArray *_array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) return array;
    
    if ([_array isKindOfClass:NSArray.class]) array = _array;
    
    return array;
}

- (instancetype)getNumberAbbr
{
    bool isNumber = false;
    if (self.integerValue != 0 || self.floatValue != 0) isNumber = true;
    if (!isNumber) return self;
    
    CGFloat number = self.floatValue;
    CGFloat result = 0;
    NSString *flag = @"";
    
    if (number < 1000) return self;
    if (number >= 1000 && number < 1000000) {
        result = number/1000.0;
        flag = @"k";
    }
    
    if (number >= 1000000 && number < 1000000000) {
        result = number/1000000.0;
        flag = @"m";
    }
    
    if (number >= 1000000000 ) {
        result = number/1000000000.0;
        flag = @"b";
    }

    NSString *numberStr = FORMAT(@"%.2f",result);
    
    NSArray *numberPaty = [numberStr componentsSeparatedByString:@"."];
    NSString *floatStr = numberPaty.lastObject;
    NSString *intStr = numberPaty.firstObject;
    
    if (floatStr.integerValue == 0) {
        return FORMAT(@"%@%@",intStr,flag);
    }else{
        return FORMAT(@"%.1f%@",result,flag);
    }
}

+ (NSString *)makePriceStrWithNumber:(CGFloat)value showPoint:(BOOL)show MinPointWidth:(NSUInteger)minPointWidth MaxPointWidth:(NSUInteger)maxPointWidth
{
    NSString *valueStr = @"";
    NSString *format = @"";
    if (show) {
        valueStr = [NSString stringWithFormat:@"%.2f", value];
        format = @",###.##";
    } else {
        valueStr = [NSString stringWithFormat:@"%.f", value];
        format = @",###";
    }
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:valueStr];
    NSNumberFormatter *numberFormatter =   [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setPositiveFormat:format];
    [numberFormatter setMaximumFractionDigits:maxPointWidth];
    [numberFormatter setMinimumFractionDigits:minPointWidth];
    return [numberFormatter stringFromNumber:decNumber];
}

#pragma mark - Base 64

- (NSData *)base64DecodeToData
{
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[4];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;
 
    if (self == nil) {
        return [NSData data];
    }
 
    ixtext = 0;
 
    tempcstring = (const unsigned char *)[self UTF8String];
 
    lentext = [self length];
 
    theData = [NSMutableData dataWithCapacity: lentext];
 
    ixinbuf = 0;
 
    while (true) {
        if (ixtext >= lentext){
            break;
        }
 
        ch = tempcstring [ixtext++];
 
        flignore = false;
 
        if ((ch >= 'A') && (ch <= 'Z')) {
            ch = ch - 'A';
        } else if ((ch >= 'a') && (ch <= 'z')) {
            ch = ch - 'a' + 26;
        } else if ((ch >= '0') && (ch <= '9')) {
            ch = ch - '0' + 52;
        } else if (ch == '+') {
            ch = 62;
        } else if (ch == '=') {
            flendtext = true;
        } else if (ch == '/') {
            ch = 63;
        } else {
            flignore = true;
        }
 
        if (!flignore) {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;
 
            if (flendtext) {
                if (ixinbuf == 0) {
                    break;
                }
 
                if ((ixinbuf == 1) || (ixinbuf == 2)) {
                    ctcharsinbuf = 1;
                } else {
                    ctcharsinbuf = 2;
                }
 
                ixinbuf = 3;
 
                flbreak = true;
            }
 
            inbuf [ixinbuf++] = ch;
 
            if (ixinbuf == 4) {
                ixinbuf = 0;
 
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
 
                for (i = 0; i < ctcharsinbuf; i++) {
                    [theData appendBytes: &outbuf[i] length: 1];
                }
            }
 
            if (flbreak) {
                break;
            }
        }
    }
 
    return theData;
}

- (NSString *)base64Decode
{
    return [[NSString alloc]initWithData:self.base64DecodeToData encoding:NSUTF8StringEncoding];
}

/// Base 64 编码
- (NSString *)base64Encode
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return data.base64EncodeToString;
}

- (NSData *)base64EncodeToData
{
    NSString *base64Str = self.base64Encode;
    return [base64Str dataUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - Bounds

- (CGFloat)getSingleWidthWithFont:(UIFont *)font
{
    return [self getWidthWithHeight:0 Font:font];
}

- (CGFloat)getWidthWithHeight:(CGFloat)height Font:(UIFont *)font
{
    if (![self isExist]) return 0;
    return [self boundingRectWithSize:CGSizeMake(0,height)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName:font}
                              context:nil].size.width;
}

- (CGFloat)getHeightWithWidth:(CGFloat)width Font:(UIFont *)font
{
    return [self boundingRectWithSize:CGSizeMake(width,0)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName:font}
                              context:nil].size.height;
}

#pragma mark - Time

+ (instancetype)createTimeStringWithStamp:(NSTimeInterval)stamp Format:(NSString *)format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeZone = [NSTimeZone systemTimeZone];
    formatter.dateFormat = format;
    
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:stamp];
    return [formatter stringFromDate:date];
}

@end
