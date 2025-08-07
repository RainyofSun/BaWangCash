//
//  HomePageSmallView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "HomePageSmallView.h"
#import "HomePageSmallTableViewCell.h"

@interface HomePageSmallView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic , strong) UIImageView *topImgView;

@property (nonatomic, strong) NSArray *productNum;

@end

@implementation HomePageSmallView

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self addSubview:self.topImgView];
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.mas_equalTo(self);
    }];
    
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.tableView registerClass:HomePageSmallTableViewCell.class forCellReuseIdentifier:HomePageSmallTableViewCell.className];
    self.tableView.backgroundColor = UIColor.clearColor;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImgView.mas_bottom);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    
    
}
- (void)setHomeModel:(HomePageSmallModel *)homeModel
{
    _homeModel = homeModel;
    
    for (PC_HomeSmallModel_Inserting *inserting in homeModel.pc_inserting) {
       self.productNum = inserting.pc_consists;
    }
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImgView.mas_bottom);
        make.left.right.equalTo(@0);
        make.height.equalTo(@(129*self.productNum.count));
        make.bottom.equalTo(@0);
    }];
    [self.tableView reloadData];
}


#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productNum.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageSmallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomePageSmallTableViewCell.className forIndexPath:indexPath];
    cell.homeModel = self.productNum[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 129.0;
}

#pragma mark - init

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView new];
        _tableView.autoresizingMask = UIViewAutoresizingNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIImageView *)topImgView {
    if (!_topImgView) {
        _topImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_small_tip"]];
    }
    
    return _topImgView;
}

@end
