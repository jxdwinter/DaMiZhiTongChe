//
//  MineViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 2/23/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "MineViewController.h"
#import "MineOrderViewController.h"
#import "Mine_TableViewCell.h"
#import "HeaderView.h"
#import "FooterView.h"
#import "AccountManager.h"
#import "User.h"
#import "CartAddressListViewController.h"
#import "MineEditInformationViewController.h"
#import "AccountManager.h"
#import <JGActionSheet.h>
#import "MineAboutUSViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *iconDataSource;
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) FooterView *footerView;

@end

@implementation MineViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的";
    self.iconDataSource = @[
                            @[@"mine_order",@"mine_loacation"],
                            @[@"mine_contact",@"mine_about"],
                            ];
    self.dataSource = @[
                        @[@"我的订单",@"地址管理"],
                        @[@"联系客服",@"关于我们"],
                        ];
    [self.view addSubview:self.tableView];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    if (self.headerView) {
        [self.headerView.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[[[AccountManager sharedAccountManager] getCurrentUser] headimg]]
                                           placeholderImage:[UIImage imageNamed:@"mine_headerImage"]];
        self.headerView.nameLabel.text = [NSString stringWithFormat:@"%@",[[[AccountManager sharedAccountManager] getCurrentUser] nickname]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - privete method

- (void) headerViewTouched {
    MineEditInformationViewController *mineEditInformationViewController = [[MineEditInformationViewController alloc] init];
    mineEditInformationViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mineEditInformationViewController animated:YES];
}

- (void) logout {
    JGActionSheetSection *section = [JGActionSheetSection sectionWithTitle:@"确认退出吗?" message:@"" buttonTitles:@[@"确认"] buttonStyle:JGActionSheetButtonStyleRed];
    section.titleLabel.textColor = DEFAULTTEXTCOLOR;
    section.titleLabel.font = DEFAULFONT;
    JGActionSheetSection *cancelSection = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleCancel];
    NSArray *sections = @[section, cancelSection];
    JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
    [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
        [sheet dismissAnimated:YES];
        if (indexPath.section == 0 && indexPath.row == 0) {
            [self exit];
        }
    }];
    [sheet showInView:self.view animated:YES];
}

- (void) exit {
    [[AccountManager sharedAccountManager] userLogout];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.tabBarController setSelectedIndex:0];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 35.0)];
        imageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        return imageView;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 35.0;
    }else{
        return 0.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CELL = @"CELL";
    Mine_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL];
    if(cell == nil){
        cell = [[Mine_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL];
    }
    cell.titleLabel.text = self.dataSource[indexPath.section][indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:self.iconDataSource[indexPath.section][indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MineOrderViewController *mineOrderViewController = [[MineOrderViewController alloc] init];
            mineOrderViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:mineOrderViewController animated:YES];
        }else if (indexPath.row == 1){
            CartAddressListViewController *cartAddressListViewController = [[CartAddressListViewController alloc] init];
            cartAddressListViewController.type = 1;
            cartAddressListViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cartAddressListViewController animated:YES];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            
        }else if (indexPath.row == 1){
            MineAboutUSViewController *mineAboutUSViewController = [[MineAboutUSViewController alloc] init];
            mineAboutUSViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:mineAboutUSViewController animated:YES];
        }
    }
}

#pragma mark - getter and setter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH,SCREEN_HEIGHT - NAVIGATIONBARHEIGHT - TABBARHEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundView = nil;
        _tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = self.footerView;
    }
    return _tableView;
}

- (HeaderView *) headerView{
    if (!_headerView) {
        _headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 95.0)];
        [_headerView.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[[[AccountManager sharedAccountManager] getCurrentUser] headimg]]
                                       placeholderImage:[UIImage imageNamed:@"mine_headerImage"]];
        _headerView.nameLabel.text = [NSString stringWithFormat:@"%@",[[[AccountManager sharedAccountManager] getCurrentUser] nickname]];
        [_headerView addTarget:self action:@selector(headerViewTouched) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}

- (FooterView *) footerView {
    if (!_footerView) {
        _footerView = [[FooterView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 80.0)];
        [_footerView.logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

@end
