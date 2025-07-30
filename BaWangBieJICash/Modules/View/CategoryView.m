//
//  CategoryView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "CategoryView.h"
#import "CategoryCollectionViewCell.h"

@implementation CategoryView

- (Class)preferredCellClass
{
    return [CategoryCollectionViewCell class];
}

@end
