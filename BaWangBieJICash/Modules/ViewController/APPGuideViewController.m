//
//  APPGuideViewController.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "APPGuideViewController.h"
#import "BaseTabViewController.h"

@interface APPGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic ,strong) UIImageView *imageView;

@end

@implementation APPGuideViewController

- (void)setUpSubView
{
    [super setUpSubView];

    self.imageArray = @[@"guide_one",@"guide_two",@"guide_three"];
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * 3, kScreenHeight);
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];

    
    for (int i = 0; i < self.imageArray.count; i ++) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight)];
        self.imageView.userInteractionEnabled = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill; // 根据需要调整
        self.imageView.image = [UIImage imageNamed:self.imageArray[i]];
        [self.scrollView addSubview:self.imageView];
        
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        pageControl.numberOfPages = self.imageArray.count;
        pageControl.pageIndicatorTintColor = [UIColor colorWithRGB:0x9471F3 alpha:0.2];
        pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#9471F3"];
        pageControl.currentPage = i;
        
        [self.imageView addSubview:pageControl];
        
        AC_BaseButton *nextBtn = [AC_BaseButton TextBtnWithTitle:@"Next" titleColor:@"#000000" font:Semibold(18)];
        [nextBtn setBackgroundColor:[UIColor colorWithHexString:@"#9471F3"]];
        [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        nextBtn.layer.cornerRadius = 27;
        nextBtn.clipsToBounds = YES;
        [nextBtn addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
        [self.imageView addSubview:nextBtn];
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@32);
            make.right.equalTo(@-32);
            make.bottom.equalTo(@-48);
            make.height.equalTo(@54);
        }];
        
        [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(nextBtn);
            make.bottom.equalTo(nextBtn.mas_top).offset(-30);
        }];
    }
}

- (void)nextPage
{
    CGFloat offsetX = self.scrollView.contentOffset.x + self.view.frame.size.width;
    if (offsetX > (self.scrollView.contentSize.width - self.view.frame.size.width)) {
        offsetX = self.scrollView.contentSize.width - self.view.frame.size.width;
        [self jumpToLogin];
    }
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)jumpToLogin
{
    [UserDefaultsObj setValue:@(true) forKey:@"needJumpGuide"];
    [UserDefaultsObj synchronize];
    BaseTabViewController *tabVC = [BaseTabViewController new];
    UIViewController.nowWindow.rootViewController = tabVC;
}

@end
