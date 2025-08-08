//
//  AddressPresentView.m
//  BaWangBieJICash
//
//  Created by 一刻 on 2025/7/29.
//

#import "AddressPresentView.h"
#import "AddressTableViewCell.h"
#import "AddressTool.h"

@interface AddressPresentView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) UIStackView *stackView;

@property (nonatomic ,strong) AC_BaseButton *addressTopBtn;
@property (nonatomic ,strong) AC_BaseButton *closeBtn;

@property (nonatomic ,strong) AddressModel * addressModel;

@property (nonatomic, strong) NSArray <PC_AdressModel_Inserting *> *models;

@property (nonatomic, copy) NSString *adressCode;
@property (nonatomic, copy) NSString *adress;

@end

@implementation AddressPresentView

- (void)setUpSubView
{
    [super setUpSubView];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@471);
    }];
    
    ImgViewWithName(contentbk, @"address_bk");
    contentbk.userInteractionEnabled = YES;
    [self.contentView addSubview:contentbk];
    [contentbk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    AC_BaseView *topSelectView = [AC_BaseView new];
    topSelectView.backgroundColor = UIColor.clearColor;
    [contentbk addSubview:topSelectView];
    [topSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@58);
        make.left.top.equalTo(@0);
        make.width.equalTo(@300);
    }];
    
    [topSelectView addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.height.equalTo(@18);
        make.top.equalTo(@19);
        make.bottom.equalTo(@-21);
    }];
    
    [contentbk addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@26);
        make.right.equalTo(@-18);
        make.width.height.equalTo(@15);
    }];
    
    [contentbk addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(topSelectView.mas_bottom);
        make.bottom.equalTo(@(kBottomHeight * -1));
    }];
    
    [self.tableView registerClass:[AddressTableViewCell class] forCellReuseIdentifier:AddressTableViewCell.className];
    
    self.addressModel = AddressTool.tool.addressModel;
    self.models = self.addressModel.pc_inserting;
    [self.tableView reloadData];
    self.adressCode = @"";
    self.adress = @"";
}

- (void)addressTopBtnCall
{
    if (self.selectedIndex > self.models.count) return;
    PC_AdressModel_Inserting *curModel = self.models[self.selectedIndex];
    if (curModel.pc_inserting == nil){
        self.adressCode = [self.adressCode stringByAppendingFormat:@"|%@",curModel.pc_shoot];
        self.adress = [self.adress stringByAppendingFormat:@" %@",curModel.pc_shoot];
        
        self.adressCode = [self.adressCode substringWithRange:NSMakeRange(1, self.adressCode.length-1)];
        self.adress = [self.adress substringWithRange:NSMakeRange(1, self.adress.length-1)];
        if (self.didSelectFinish) self.didSelectFinish(self.adressCode, self.adress);
        [self disMiss];
        return;
    }
    
    NSString *title = curModel.pc_shoot;
    self.adressCode = [self.adressCode stringByAppendingFormat:@"|%@",curModel.pc_shoot];
    self.adress = [self.adress stringByAppendingFormat:@" %@",curModel.pc_shoot];
    UILabel *label = [UILabel LabelWithFont:Regular(14) TextColor:@"#000000" Text:title];
    [self.stackView insertArrangedSubview:label atIndex:self.stackView.arrangedSubviews.count-1];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@18);
    }];
    
    self.models = curModel.pc_inserting;
    [self.tableView reloadData];
}

- (void)closeBtnCall
{
    [self removeFromSuperview];
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddressTableViewCell.className];
    cell.addressModel = self.models[indexPath.row];
    
    // 选中状态样式
    if (indexPath.row == self.selectedIndex) {
        cell.selectBtn.hidden = NO;
        cell.addressTitle.textColor = MAIN_COLOR;
    }else {
        cell.selectBtn.hidden = YES;
        cell.addressTitle.textColor = HEXCOLOR(@"#0A0220");
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
    [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [tableView endUpdates];
    
    PC_AdressModel_Inserting *curModel = self.models[self.selectedIndex];
    if (curModel.pc_inserting == nil){
        self.adressCode = [self.adressCode stringByAppendingFormat:@"|%@",curModel.pc_shoot];
        self.adress = [self.adress stringByAppendingFormat:@" %@",curModel.pc_shoot];
        
        self.adressCode = [self.adressCode substringWithRange:NSMakeRange(1, self.adressCode.length-1)];
        self.adress = [self.adress substringWithRange:NSMakeRange(1, self.adress.length-1)];
        if (self.didSelectFinish) self.didSelectFinish(self.adressCode, self.adress);
        [self disMiss];
        return;
    }
    
    NSString *title = curModel.pc_shoot;
    self.adressCode = [self.adressCode stringByAppendingFormat:@"|%@",curModel.pc_shoot];
    self.adress = [self.adress stringByAppendingFormat:@" %@",curModel.pc_shoot];
    UILabel *label = [UILabel LabelWithFont:Regular(14) TextColor:@"#000000" Text:title];
    [self.stackView insertArrangedSubview:label atIndex:self.stackView.arrangedSubviews.count-1];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@18);
    }];
    
    self.models = curModel.pc_inserting;
    [self.tableView reloadData];
    
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

- (AC_BaseButton *)addressTopBtn
{
    if (_addressTopBtn == nil) {
        _addressTopBtn = [AC_BaseButton TextBtnWithTitle:@"Select" titleColor:@"#9471F3" font:Semibold(14)];
        [_addressTopBtn addTarget:self action:@selector(addressTopBtnCall) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressTopBtn;
}

- (AC_BaseButton *)closeBtn
{
    if (_closeBtn == nil) {
        _closeBtn = [AC_BaseButton ImageBtnWithImgName:@"address_icon_close"];
        [_closeBtn addTarget:self action:@selector(closeBtnCall) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UIStackView *)stackView
{
    if (_stackView == nil) {
        _stackView = [UIStackView new];
        _stackView.spacing = 11;
        _stackView.distribution = UIStackViewDistributionEqualSpacing;
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        
        [_stackView addArrangedSubview:self.addressTopBtn];
        [self.addressTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@18);
        }];
        
    }
    return _stackView;
}

@end
