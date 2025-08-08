//
//  DateOfBirthdayConfirmView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "DateOfBirthdayConfirmView.h"

@interface DateOfBirthdayConfirmView ()

@property (nonatomic, strong) UIDatePicker *pickerView;

@property (nonatomic, strong) NSMutableArray *years;
@property (nonatomic, strong) NSArray *months;
@property (nonatomic, strong) NSMutableArray *days;

@property (nonatomic, assign) NSInteger selectedYear;
@property (nonatomic, assign) NSInteger selectedMonth;
@property (nonatomic, assign) NSInteger selectedDay;

@property (nonatomic, strong) AC_BaseView *selectView;

@end

@implementation DateOfBirthdayConfirmView

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.contentView.backgroundColor = UIColor.clearColor;
    ImgViewWithName(contentbk, @"bankcard_bk");
    contentbk.userInteractionEnabled = YES;
    [self.contentView insertSubview:contentbk atIndex:0];
    [contentbk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    self.title = @"Please select a time";
    
    [self.stackView addArrangedSubview:self.pickerView];
    

}

- (void)dateChanged:(UIDatePicker *)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *text = [formatter stringFromDate:sender.date];
    if (self.didSelctRowBlock) self.didSelctRowBlock(text);
}


#pragma mark - init

- (UIDatePicker *)pickerView
{
    if (_pickerView == nil) {
        _pickerView = [UIDatePicker new];
        _pickerView.datePickerMode = UIDatePickerModeDate;
        _pickerView.preferredDatePickerStyle = UIDatePickerStyleWheels;
        [_pickerView addTarget:self action:@selector(dateChanged:)
        forControlEvents:UIControlEventValueChanged];
        
    }
    return _pickerView;
    
}

- (AC_BaseView *)selectView
{
    if (_selectView == nil) {
        _selectView = [AC_BaseView new];
        _selectView.backgroundColor = HEXCOLOR(@"#9471F3");
    }
    return _selectView;
}

@end
