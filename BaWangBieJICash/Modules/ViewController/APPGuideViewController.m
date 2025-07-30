//
//  APPGuideViewController.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "APPGuideViewController.h"
#import "BaseTabViewController.h"

@interface APPGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic ,strong) UIImageView *imageView;

@end

@implementation APPGuideViewController

- (void)setUpSubView
{
    [super setUpSubView];
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * 3, kScreenHeight);
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    

    self.imageArray = @[@"bianzu_one",@"bianzu_two",@"bianzu_three"];
    
    for (int i = 0; i < self.imageArray.count; i ++) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight)];
        self.imageView.userInteractionEnabled = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill; // 根据需要调整
        self.imageView.image = [UIImage imageNamed:self.imageArray[i]];
        [self.scrollView addSubview:self.imageView];
        
        AC_BaseButton *nextBtn = [AC_BaseButton TextBtnWithTitle:@"Next" titleColor:@"#000000" font:Semibold(18)];
        [nextBtn setBackgroundImage:IMAGE(@"guide_next") forState:UIControlStateNormal];
        [nextBtn addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
        [self.imageView addSubview:nextBtn];
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@32);
            make.right.equalTo(@-32);
            make.bottom.equalTo(@-48);
            make.height.equalTo(@54);
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
    [UserDefaultsObj setValue:@(true) forKey:@"com.acery.needJumpGuide"];
    [UserDefaultsObj synchronize];
    BaseTabViewController *tabVC = [BaseTabViewController new];
    UIViewController.nowWindow.rootViewController = tabVC;
}

@end
