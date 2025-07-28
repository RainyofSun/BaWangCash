//
//  NT_RunTime.h
//  ACAuotCode
//
//  Created by Acery on 2024/7/1.
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

@interface AC_RunTimeTool : NSObject

/// 交换同一个类的两个实例方法
/// - Parameters:
///   - classType: 交换的类
///   - originalSelector: 原本的实例方法
///   - swizzledSelector: 交换的实例方法
+ (void)ExChangeMethodWithClass:(Class)classType
               OriginalSelector:(SEL)originalSelector
               SwizzledSelector:(SEL)swizzledSelector;

/// 交换不同类的两个实例方法
/// - Parameters:
///   - originalCls: 原本的类
///   - swizzledCls: 交换的类
///   - originalSelector: 原本的实例方法
///   - swizzledSelector: 交换的实例方法
+ (void)EXChangeDifferentClassMethodWithClass:(Class)originalCls
                                SwizzledClass:(Class)swizzledCls
                             OriginalSelector:(SEL)originalSelector
                             SwizzledSelector:(SEL)swizzledSelector;

/// 获取类的所有实例方法
/// - Parameter classType: 类
+ (NSArray *)GetAllMethodsWithClass:(Class)classType;

@end

NS_ASSUME_NONNULL_END
