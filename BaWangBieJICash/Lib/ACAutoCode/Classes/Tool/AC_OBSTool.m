//
//  AC_OBSTool.m
//  ACAutoCode
//
//  Created by Acery on 2024/10/20.
//

#import "AC_OBSTool.h"

@implementation AC_OBSTool

+ (instancetype)tool
{
    static dispatch_once_t onceToken;
    static AC_OBSTool *_tool = nil;
    dispatch_once(&onceToken, ^{
        if (_tool == nil) {
            _tool = [AC_OBSTool new];
        }
    });
    return _tool;
}

#pragma mark - OBS

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

}


@end
