//
//  NT_RunTime.m
//  NewYY
//
//  Created by Acery on 2023/3/21.
//

#import "AC_RunTimeTool.h"
#import <objc/runtime.h>

@implementation AC_RunTimeTool

+ (void)ExChangeMethodWithClass:(Class)classType OriginalSelector:(SEL)originalSelector SwizzledSelector:(SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod(classType,originalSelector);
    Method swizzledMethod = class_getInstanceMethod(classType,swizzledSelector);

    BOOL didAddMethod = class_addMethod(classType,
                                        swizzledSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));

    if(didAddMethod){
        class_replaceMethod(classType,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod,swizzledMethod);
    }
}

+ (void)EXChangeDifferentClassMethodWithClass:(Class)originalCls
                                SwizzledClass:(Class)swizzledCls
                             OriginalSelector:(SEL)originalSelector
                             SwizzledSelector:(SEL)swizzledSelector
{
    /// 类名为空
    if (!originalCls || !swizzledCls) return;
    
    /// 方法名为空
    if (!originalSelector || !swizzledSelector) return;
    
    Method originalMethod = class_getInstanceMethod(originalCls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledCls, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(originalCls,
                                        swizzledSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    
    /// 添加方法失败
    if (didAddMethod) method_exchangeImplementations(originalMethod, class_getInstanceMethod(originalCls, swizzledSelector));
    
}

+ (NSArray *)GetAllMethodsWithClass:(Class)classType
{
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(classType, &methodCount);
    NSMutableArray *methodArray = [NSMutableArray arrayWithCapacity:methodCount];
    for (int i = 0; i < methodCount; i++) {
        Method temp = methodList[i];
        SEL name_F = method_getName(temp);
        const char *name_s = sel_getName(name_F);
        [methodArray addObject:[NSString stringWithUTF8String:name_s]];
    }
    free(methodList);
    return methodArray;
}

@end
