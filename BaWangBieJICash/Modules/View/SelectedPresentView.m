//
//  SelectedPresentView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "SelectedPresentView.h"
#import "AuthSelectedTableViewCell.h"
#import "PickerCellModel.h"

@interface SelectedPresentView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;
 
@property (nonatomic, strong) AC_BaseButton *nextBtn;

@end

@implementation SelectedPresentView

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28);
        make.right.equalTo(@-28);
        make.top.equalTo(@153);
    }];
   
    ImgViewWithName(contentbk, @"logoff_bk");
    contentbk.userInteractionEnabled = YES;
    [self.contentView addSubview:contentbk];
    [contentbk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    UILabel *lab = [UILabel LabelWithFont:Semibold(17) TextColor:@"#000000" Text:@"Select"];
    [contentbk addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@17);
        make.centerX.equalTo(@0);
        make.top.equalTo(@24);
    }];
  
    
    [contentbk addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(lab.mas_bottom).offset(16);
    }];
    
    [self.tableView registerClass:[AuthSelectedTableViewCell class] forCellReuseIdentifier:AuthSelectedTableViewCell.className];
    
    [contentbk addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.height.equalTo(@52);
        make.top.equalTo(self.tableView.mas_bottom).offset(20);
        make.right.equalTo(@-24);
        make.bottom.equalTo(@-16);
    }];
    
    UIButton *btn = [UIButton ImageBtnWithImgName:@"present_close"];
    [btn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.contentView.mas_bottom).offset(16);
        make.height.equalTo(btn.mas_width).multipliedBy(24.0/24.0);
    }];
}

- (void)nextBtnCall
{
    [self disMiss];
    if (self.didSelctRowBlock) self.didSelctRowBlock(self.models[self.selectedIndex]);
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AuthSelectedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AuthSelectedTableViewCell.className];
    if (!cell) {
        cell = [[AuthSelectedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AuthSelectedTableViewCell.className];
        cell.backgroundColor = UIColor.clearColor;
        cell.contentView.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = self.models[indexPath.row].title;
    cell.textLabel.textColor = HEXCOLOR(@"#13253B");
    cell.textLabel.font = Regular(14);
    cell.layer.cornerRadius = 0;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
    
    // 选中状态样式
    if (indexPath.row == self.selectedIndex) {
        cell.backgroundColor = HEXCOLOR(@"#9471F3");
        cell.textLabel.textColor = HEXCOLOR(@"#FFFFFF");
        cell.textLabel.font = Semibold(16);
    } else {
        cell.backgroundColor = UIColor.clearColor;
        cell.textLabel.textColor = HEXCOLOR(@"#13253B");
        cell.textLabel.font = Regular(14);
    }
    
    return cell;
}



#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    NSInteger previousIndex = self.selectedIndex;
   
    self.selectedIndex = indexPath.row;
    
    // 创建需要刷新的indexPaths数组
    NSMutableArray *indexPaths = [NSMutableArray array];
    if (previousIndex != NSNotFound) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:previousIndex inSection:0]];
    }
    [indexPaths addObject:indexPath];
    
    // 带有动画的局部刷新
    [tableView beginUpdates];
    [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView endUpdates];
    
    // 自动滚动到选中位置（可选）
    [tableView scrollToRowAtIndexPath:indexPath
                     atScrollPosition:UITableViewScrollPositionMiddle
                             animated:YES];

//    if (self.didSelctRowBlock) self.didSelctRowBlock(self.models[indexPath.row]);
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


- (AC_BaseButton *)nextBtn
{
    if (_nextBtn == nil) {
        _nextBtn = [AC_BaseButton TextBtnWithTitle:@"Next" titleColor:@"#FFFFFF" font:Semibold(16)];
        [_nextBtn setBackgroundImage:IMAGE(@"next_btn") forState:UIControlStateNormal];
  
        [_nextBtn addTarget:self action:@selector(nextBtnCall) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

@end
