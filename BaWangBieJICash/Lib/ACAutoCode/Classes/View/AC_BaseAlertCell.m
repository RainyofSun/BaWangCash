//
//  AC_BaseAlertCell.m
//  ACAuotCode
//
//  Created by Acery on 2024/5/7.
//

#import "AC_BaseAlertCell.h"

@interface AC_BaseAlertCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation AC_BaseAlertCell

+ (instancetype)alertCellWithTitle:(NSString *)title CliclBlock:(AC_AlertCell_DidClick)clickBlock
{
    __kindof AC_BaseAlertCell *cell = [self new];
    cell.title = title;
    cell.clickBlock = clickBlock;
    return cell;
}

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.backgroundColor = HEXCOLOR(@"#1D1C22");
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@56);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@19);
        make.center.equalTo(@0);
    }];
    
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCall)];
    [self addGestureRecognizer:gest];
}

- (void)clickCall
{
    if (self.clickBlock) self.clickBlock(self.title);
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

#pragma mark - init

- (UILabel *)titleLabel
{
    if (_titleLabel == nil){
        _titleLabel = [UILabel LabelWithFont:Regular(16) TextColor:@"#C0C0C0" Text:@""];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
