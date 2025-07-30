//
//  BasePickerView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "BasePickerView.h"

@interface BasePickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, assign) bool isAllreadySelected;

@end

@implementation BasePickerView

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.backgroundColor = [HEXCOLOR(@"#000000") colorWithAlphaComponent:0.75];
    
    self.contentView.backgroundColor = HEXCOLOR(@"#EEEEEE");
    [self.contentView addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.height.equalTo(@471);
    }];
}


- (void)setModels:(NSArray<PickerCellModel *> *)models
{
    _models = models;
    [self.pickerView reloadAllComponents];
}

#pragma mark - IPickerViewDataSource,UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.models.count;
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (!self.isAllreadySelected && self.didSelctRowBlock) self.didSelctRowBlock(self.models[0]);
    NSDictionary *attr = @{NSFontAttributeName:Medium(16),NSForegroundColorAttributeName:UIColor.blackColor};
    NSString *title = self.models[row].title;
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:title attributes:attr];
    return attrStr;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.isAllreadySelected = true;
    if (self.didSelctRowBlock) self.didSelctRowBlock(self.models[row]);
}

#pragma mark - Init

- (UIPickerView *)pickerView
{
    if (_pickerView == nil){
        _pickerView = [UIPickerView new];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        
    }
    return _pickerView;
}

@end
