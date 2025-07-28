//
//  NT_BaseAlertView.m
//  ACAuotCode
//
//  Created by Acery on 2024/5/7.
//

#import "AC_BaseAlertView.h"

@interface AC_BaseAlertView ()

@property (nonatomic, strong) UIStackView *alertStackView;

@end

@implementation AC_BaseAlertView

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self.contentView setCornerRadius:15 rectCorner:UIRectCornerTopLeft|UIRectCornerTopRight];
    self.contentView.backgroundColor = HEXCOLOR(@"#151419");
    [self.contentView addSubview:self.alertStackView];
    [self.alertStackView mas_makeConstraints:^(MASConstraintMaker *make) {
            
    }];
}

- (void)addAlertCell:(__kindof AC_BaseAlertCell *)alertCell
{
    [self.alertStackView addArrangedSubview:alertCell];
}

#pragma mark - init

- (UIStackView *)alertStackView
{
    if (_alertStackView == nil){
        _alertStackView = [UIStackView new];
        _alertStackView.backgroundColor = HEXCOLOR(@"#151419");
        _alertStackView.distribution = UIStackViewDistributionEqualSpacing;
        _alertStackView.axis = UILayoutConstraintAxisVertical;
        _alertStackView.spacing = 1;
    }
    return _alertStackView;
}

@end
