//
//  CategoryCollectionViewCell.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "CategoryCollectionViewCell.h"

@interface CategoryCollectionViewCell ()

@property (nonatomic , strong) UIImageView *imgView;

@end

@implementation CategoryCollectionViewCell

- (void)initializeViews
{
    [super initializeViews];
    
    [NSLayoutConstraint deactivateConstraints:@[self.titleLabelCenterX, self.titleLabelCenterY]];
    [self.titleLabel removeConstraints:self.titleLabel.constraints];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.height.equalTo(@17);
        make.centerX.equalTo(@0);
    }];
    
    [self.contentView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@28);
        make.top.equalTo(@0);
        make.centerX.equalTo(@0);
    }];
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel
{
    [super reloadData:cellModel];
    
    JXCategoryTitleCellModel *myCellModel = (JXCategoryTitleCellModel *)cellModel;
    if ([myCellModel.title isEqualToString:@"Apply"]) {
        self.imgView.image = IMAGE(@"order_apply");
    }
    
    if ([myCellModel.title isEqualToString:@"Repayment"]) {
        self.imgView.image = IMAGE(@"order_repay");
    }
    
    if ([myCellModel.title isEqualToString:@"Finished"]) {
        self.imgView.image = IMAGE(@"order_finish");
    }
}

#pragma mark - Init

- (UIImageView *)imgView
{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
    }
    return _imgView;
}

@end
