//
//  AC_BaseView.h
//  ACAuotCode
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


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AC_BaseView : UIView

@property (nonatomic, strong) NSDictionary *userDict;
@property (nonatomic, strong) __kindof NSObject *userObj;

- (void)setUpSubView;

@end

@interface AC_BaseGradientView : AC_BaseView

/// colos
@property(nonatomic, nullable, copy) NSArray *colors;

/// locations
@property(nonatomic, nullable, copy) NSArray<NSNumber *> *locations;

@property(nonatomic, assign) CGPoint startPoint;

@property(nonatomic, assign) CGPoint endPoint;

@end

@interface AC_BaseGradientBorderView : AC_BaseGradientView

@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, assign) CGFloat borderWidth;


@end

NS_ASSUME_NONNULL_END
