//
//  AC_BaseTableCell.m
//  ACAuotCode
//
//  Created by Acery on 2022/11/22.
//

#import "AC_BaseTableCell.h"

@implementation AC_BaseTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.clearColor;
        [self setUpSubView];
    }
    return self;
}

- (void)setUpSubView{}

@end
