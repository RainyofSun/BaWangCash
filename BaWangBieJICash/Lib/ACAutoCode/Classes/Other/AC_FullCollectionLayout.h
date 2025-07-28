//
//  AC_FullCollectionLayout.h
//  ACAutoCode
//
//  Created by Acery on 2024/7/11.
//
//
//       ,---,
//      '  .' \
//     /  ;    '.                          __  ,-.
//    :  :       \                       ,' ,'/ /|
//    :  |   /\   \     ,---.     ,---.  '  | |' |   .--,
//    |  :  ' ;.   :   /     \   /     \ |  |   ,' /_ ./|
//    |  |  ;/  \   \ /    / '  /    /  |'  :  /, ' , ' :
//    '  :  | \  \ ,'.    ' /  .    ' / ||  | '/___/ \: |
//    |  |  '  '--'  '   ; :__ '   ;   /|;  : | .  \  ' |
//    |  :  :        '   | '.'|'   |  / ||  , ;  \  ;   :
//    |  | ,'        |   :    :|   :    | ---'    \  \  ;
//    `--''           \   \  /  \   \  /           :  \  \
//                     `----'    `----'             \  ' ;
//                                                   `--`


/**
 *  可以动态获取 UICollectionView  的内容大小，使cell全部展示出来
 *  子类需要在``layoutAttributesForItemAtIndexPath``中手动调用 ``remakeContentSizeWithIndexPath``
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AC_FullCollectionLayout;

typedef void(^AC_FullCollectionLayout_NeedResize)(CGSize newSize , __kindof AC_FullCollectionLayout *layout);

@interface AC_FullCollectionLayout : UICollectionViewFlowLayout

@property (nonatomic, copy) AC_FullCollectionLayout_NeedResize frameNeedChangeBlock;

/// 重新计算``UICollectionView``的大小
/// - Parameters:
///   - indexPath: 当前cell的indexPath
///   - attributes: 当前cell布局的属性
- (void)remakeContentSizeWithIndexPath:(NSIndexPath *)indexPath Attributes:(UICollectionViewLayoutAttributes *)attributes;

- (NSMutableArray *)pageAttributes;

@end

NS_ASSUME_NONNULL_END
