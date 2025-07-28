//
//  AC_FullCollectionLayout.m
//  ACAutoCode
//
//  Created by Acery on 2024/7/11.
//

#import "AC_FullCollectionLayout.h"

@interface AC_FullCollectionLayout ()

@property (nonatomic,strong) NSMutableArray * pageAttributes;

@end

@implementation AC_FullCollectionLayout

- (void)prepareLayout
{
    [super prepareLayout];
    [self.pageAttributes removeAllObjects];
    
    NSInteger sections = [self.collectionView numberOfSections];
    for (NSInteger sectionIdx = 0; sectionIdx < sections; sectionIdx++ ) {
        NSInteger rows = [self.collectionView numberOfItemsInSection:sectionIdx];
        for (NSInteger rowIdx = 0; rowIdx < rows; rowIdx++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIdx inSection:sectionIdx];
            [self.pageAttributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
    }
}

- (void)remakeContentSizeWithIndexPath:(NSIndexPath *)indexPath Attributes:(UICollectionViewLayoutAttributes *)attributes
{
    // 获取最后一个cell
    
    NSInteger sections = [self.collectionView numberOfSections];
    NSInteger rows = [self.collectionView numberOfItemsInSection:sections-1];
    
    if (indexPath.row == rows-1 && indexPath.section == sections-1) {
        CGSize size = CGSizeMake(self.collectionView.bounds.size.width, attributes.frame.origin.y+attributes.frame.size.height);
        if (self.frameNeedChangeBlock) self.frameNeedChangeBlock(size,self);
    }
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.pageAttributes;
}

#pragma mark - init

- (NSMutableArray *)pageAttributes
{
    if (_pageAttributes == nil){
        _pageAttributes = [NSMutableArray new];
    }
    return _pageAttributes;
}

@end
