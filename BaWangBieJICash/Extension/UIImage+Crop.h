//
//  UIImage+Crop.h
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Crop)

- (NSData *)compressWithMaxLength:(NSUInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
