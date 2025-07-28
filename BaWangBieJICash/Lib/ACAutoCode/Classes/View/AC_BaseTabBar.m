//
//  AC_BaseTabBar.m
//  ACAuotCode
//
//  Created by Acery on 2023/4/26.
//

#import "AC_BaseTabBar.h"

@interface AC_BaseTabBar ()

/// content view
@property(nonatomic, strong) UIView *contentView;

/// shadow view
@property(nonatomic, strong) UIView *shadowView;

/// ite btns
@property(nonatomic, strong) NSMutableArray <__kindof UIButton *>* itemBtns;

/// item count
@property(nonatomic, assign) NSInteger itemCount;

/// specia item index
@property(nonatomic, assign) bool hasSpecialItem;
@property(nonatomic, assign) NSInteger specialItemIndex;

/// tabbar controller
@property(nonatomic, weak) __kindof UITabBarController *tabbarController;

@end

@implementation AC_BaseTabBar

- (instancetype)initWithCoder:(NSCoder *)coder
{
    return [self init];
}

- (instancetype)initWithTabbarController:(__kindof UITabBarController *)tabbarController
{
    self = [self init];
    if (self) {
        self.tabbarController = tabbarController;
        [self contentView];
        [self shadowView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubView];
    }
    return self;
}

#pragma mark - set up

- (void)setUpSubView
{
    self.backgroundColor = UIColor.clearColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *subView in self.subviews) {
        if (
            subView == self.shadowView ||
            subView == self.contentView ||
            [subView isMemberOfClass:UIButton.class]) {
            continue;
        }
        subView.hidden = true;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // 如果tabbar 被隐藏了直接调用父类返回
    if (self.isHidden) {
        return [super hitTest:point withEvent:event];
    }
    
    CGFloat contentViewMinY = CGRectGetMinY(self.shadowView.frame);
    CGRect touchRect = CGRectZero;
    CGFloat specialItemTopSpacing = 0.0;
    if ([self.ATdelegate respondsToSelector:@selector(ATD_SpecialItemTopSpacingWithTabBar:)]) {
        specialItemTopSpacing = [self.ATdelegate ATD_SpecialItemTopSpacingWithTabBar:self];
        touchRect = CGRectMake(self.frame.origin.x,
                               self.frame.origin.y + contentViewMinY - specialItemTopSpacing,
                               self.frame.size.width,
                               self.frame.size.height - contentViewMinY + specialItemTopSpacing);
    }else{
        touchRect = CGRectMake(self.frame.origin.x,
                               self.frame.origin.y + contentViewMinY,
                               self.frame.size.width,
                               self.frame.size.height - contentViewMinY);
    }
    
    CGPoint convertPoint = [self convertPoint:point toView:UIApplication.sharedApplication.keyWindow];
    
    if (CGRectContainsPoint(touchRect, convertPoint)) {
        
        // 判断item
        for (UIButton *item in self.itemBtns) {
            NSInteger index = [self.itemBtns indexOfObject:item];
            CGRect itemRect = CGRectZero;
            if (self.hasSpecialItem && index == self.specialItemIndex) {
                itemRect = CGRectMake(item.frame.origin.x,touchRect.origin.y, item.frame.size.width, touchRect.size.height);
            }else{
                itemRect = CGRectMake(item.frame.origin.x,touchRect.origin.y + specialItemTopSpacing , item.frame.size.width, touchRect.size.height - specialItemTopSpacing);
            }
            
            if (CGRectContainsPoint(itemRect, convertPoint)) return item;
        }
        
        return self;
    }
    return [super hitTest:point withEvent:event];
}

- (void)setUpDelegate
{
    // contet view set
    if ([self.ATdelegate respondsToSelector:@selector(ATD_LayoutContent:TabBar:)]) {
        [self.ATdelegate ATD_LayoutContent:self.contentView TabBar:self];
    }else{
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    
    // shandow view set
    if ([self.ATdelegate respondsToSelector:@selector(ATD_LayoutShadow:TabBar:)]) {
        [self.ATdelegate ATD_LayoutShadow:self.shadowView TabBar:self];
    }else{
        [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    
    
    
    // item set
    if ([self.ATdelegate respondsToSelector:@selector(ATD_IndexofTabBar:)]) {
        NSInteger itemCount = [self.ATdelegate ATD_IndexofTabBar:self];
        self.itemCount = itemCount;
        
        __kindof UIButton *lastItem = nil;
        for (NSInteger index = 0; index < itemCount; index++) {
            UIButton *item = [self makeItemWithIndex:index];
            [self layoutItem:item LastItem:lastItem Index:index];
            [self addItemContent:item Index:index];
            lastItem = item;
        }
    }
    
}

- (void)setCuurentIndex:(NSInteger)cuurentIndex
{
    UIButton *cuurentItem = self.itemBtns[cuurentIndex];
    [self itemBtnCall:cuurentItem];
}

#pragma mark - delegate func

- (__kindof UIButton *)makeItemWithIndex:(NSInteger)index
{
    UIButton *itemBtn = [UIButton new];
    [self.itemBtns addObject:itemBtn];
    
    if ([self.ATdelegate respondsToSelector:@selector(ATD_IsNormalItemWithIndex:TabBar:)]) {
        bool isNormalItem = [self.ATdelegate ATD_IsNormalItemWithIndex:index TabBar:self];
        if (isNormalItem) {
            [self.contentView addSubview:itemBtn];
        }else{
            // 存在一个异形 item button
            self.hasSpecialItem = true;
            self.specialItemIndex = index;
            [self.shadowView addSubview:itemBtn];
        }
    }else{
        [self.contentView addSubview:itemBtn];
    }
    
    [itemBtn addTarget:self action:@selector(itemBtnCall:) forControlEvents:UIControlEventTouchUpInside];
    
    return itemBtn;
}

- (void)layoutItem:(__kindof UIButton *)item LastItem:(__kindof UIButton *)lastItem Index:(NSInteger)index
{
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        if (lastItem == nil) {
            make.left.equalTo(@0);
        }else{
            make.left.equalTo(lastItem.mas_right);
            if ([self.ATdelegate respondsToSelector:@selector(ATD_ItemContentWidthOfIndex:TabBar:)]) {
                CGFloat itemWidth = [self.ATdelegate ATD_ItemContentWidthOfIndex:index TabBar:self];
                make.width.equalTo(@(itemWidth));
            }else{
                make.width.equalTo(lastItem);
            }
        }
        make.top.bottom.equalTo(self.contentView);
        
        if (index == self.itemCount - 1) {
            make.right.equalTo(@0);
        }
    }];
}

- (void)addItemContent:(__kindof UIButton *)item Index:(NSInteger)index
{
    if ([self.ATdelegate respondsToSelector:@selector(ATD_ItemContentOfIndex:TabBar:)]) {
        UIView *itemContent = [self.ATdelegate ATD_ItemContentOfIndex:index TabBar:self];
        itemContent.userInteractionEnabled = false;
        [item addSubview:itemContent];
        
        if ([self.ATdelegate respondsToSelector:@selector(ATD_LayoutItemContent:Index:TabBar:)]) {
            [self.ATdelegate ATD_LayoutItemContent:itemContent Index:index TabBar:self];
        }else{
            [itemContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(@0);
            }];
        }
    }
}

#pragma mark - set

- (void)setATdelegate:(id<AC_BaseTabBarDelegate>)ATDdelegate
{   _ATdelegate = ATDdelegate;
    [self setUpDelegate];
}

#pragma mark - init

- (NSMutableArray<__kindof UIButton *> *)itemBtns
{
    if (_itemBtns == nil) {
        _itemBtns = [NSMutableArray new];
    }
    return _itemBtns;
}

- (UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [UIView new];
        _contentView.backgroundColor = UIColor.whiteColor;
        
        [self addSubview:self.shadowView];
        [self.shadowView addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.shadowView);
        }];
    }
    return _contentView;
}

- (UIView *)shadowView
{
    if (_shadowView == nil) {
        _shadowView = [UIView new];
        _shadowView.backgroundColor = UIColor.clearColor;
    }
    return _shadowView;
}

#pragma mark - event handel

- (void)itemBtnCall:(UIButton *)btn
{
    NSInteger index = [self.itemBtns indexOfObject:btn];
    if ([self.ATdelegate respondsToSelector:@selector(ATD_ClickAtItemAtIndex:TabBar:)]){
        [self.ATdelegate ATD_ClickAtItemAtIndex:index TabBar:self];
    }
}

@end
