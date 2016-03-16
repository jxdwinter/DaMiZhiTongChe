//
//  CartAddressListViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/10/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "CartAddressListViewController.h"
#import "CartAddressAddViewController.h"
#import "Cart_address.h"
#import "Cart_AddressTableViewCell.h"
#import <MJRefresh.h>
#import "Cart_getAddressListApi.h"
#import "CartSettlementViewController.h"
#import "CartAddressEditViewController.h"
#import "Cart_deleteAddressApi.h"

@interface CartAddressListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIButton *addButton;

@end

@implementation CartAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"RELOADADDRESS" object:nil];
    self.backButton.hidden = NO;
    self.title = @"收货地址";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.addButton];
    
    self.dataSource = [[NSMutableArray alloc] initWithCapacity:1];
    [self.view addSubview:self.tableView];
    
    [self getAddressDataWithShowShouldShowHUD:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RELOADADDRESS" object:nil];
}

#pragma mark - privete method

- (void) addAddress {
    CartAddressAddViewController *cartAddressAddViewController = [[CartAddressAddViewController alloc] init];
    [self.navigationController pushViewController:cartAddressAddViewController animated:YES];
}


- (void) getAddressDataWithShowShouldShowHUD : (BOOL) shouldShowHUD{
    Cart_getAddressListApi *api = [[Cart_getAddressListApi alloc] init];
    if (shouldShowHUD){
        RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
        [api addAccessory:accessory];
    }
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
        if (dic) {
            if ([dic[@"result"] isEqualToString:@"0"]) {
                [self configDataWithCartData:dic[@"data"]];
            }else if ([dic[@"result"] isEqualToString:@"1"]) {
                [self configDataWithCartData:nil];
            }else{
                [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
            }
        }
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

- (void) configDataWithCartData : (NSArray *) data{
    if (data && [data count]) {
        NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithCapacity:1];
        for (NSDictionary *dic in data) {
            Cart_address *cart_address = [[Cart_address alloc] initWithCart_addressInfo:dic];
            if (cart_address) {
                [tmpArray addObject:cart_address];
            }
        }
        self.dataSource = nil;
        self.dataSource  = [tmpArray mutableCopy];
    }else{
        [self.dataSource removeAllObjects];
    }
    [self configUI];
}

- (void) configUI {
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

- (void) reloadData {
    [self getAddressDataWithShowShouldShowHUD:NO];
}

- (void) loadData {
    [self getAddressDataWithShowShouldShowHUD:NO];
}

- (void)deleteAddress : (Cart_address *) address withIndexPath : (NSIndexPath *) indexPath{
    Cart_deleteAddressApi *api = [[Cart_deleteAddressApi alloc] initWithId:address._id];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
        if (dic) {
            if ([dic[@"result"] isEqualToString:@"0"]) {
                [self.tableView beginUpdates];
                [self.dataSource removeObjectAtIndex:indexPath.row];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView endUpdates];
            }else {
                [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
            }
        }
    } failure:^(YTKBaseRequest *request) {
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CART_ADDRESSTABLEVIEWCELL = @"CART_ADDRESSTABLEVIEWCELL";
    Cart_AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CART_ADDRESSTABLEVIEWCELL];
    if(cell == nil){
        cell = [[Cart_AddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CART_ADDRESSTABLEVIEWCELL];
    }
    Cart_address *cart_address = self.dataSource[indexPath.row];
    if ([cart_address.flag isEqualToString:@"Y"]) {
        cell.iconImageView.image = [UIImage imageNamed:@"mine_loacation"];
    }else if ([cart_address.flag isEqualToString:@"N"]){
        cell.iconImageView.image = [UIImage imageNamed:@"goods_origin"];
    }
    cell.nameLabel.text = [NSString stringWithFormat:@"收货人:%@",cart_address.name];
    cell.phoneLabel.text = cart_address.mobile;
    cell.addressLabel.text = cart_address.address;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Cart_address *cart_address = self.dataSource[indexPath.row];
    if (self.type == 0) {
        [self.selectAddressDelegate setDefaultAdressWithAddress:cart_address];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (self.type == 1) {
        CartAddressEditViewController *cartAddressEditViewController = [[CartAddressEditViewController alloc] init];
        cartAddressEditViewController.address = cart_address;
        [self.navigationController pushViewController:cartAddressEditViewController animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle ==  UITableViewCellEditingStyleDelete) {
        Cart_address *cart_address = self.dataSource[indexPath.row];
        [self deleteAddress:cart_address withIndexPath:indexPath];
    }
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

#pragma mark - getter and setter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH,SCREEN_HEIGHT - NAVIGATIONBARHEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundView = nil;
        _tableView.backgroundColor = DEFAULTLIGHTGRAYCOLOR;
        _tableView.rowHeight = 80;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"好大米马上来..." forState:MJRefreshStateRefreshing];
        header.stateLabel.font = [UIFont systemFontOfSize:14];
        header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:10];
        header.stateLabel.textColor = DEFAULTBROWNCOLOR;
        header.lastUpdatedTimeLabel.textColor = DEFAULTBROWNCOLOR;
        header.lastUpdatedTimeLabel.hidden = YES;
        _tableView.mj_header = header;
    }
    return _tableView;
}

- (UIButton *) addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
        [_addButton addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
        [_addButton setImage:[UIImage imageNamed:@"cart_add"] forState:UIControlStateNormal];
    }
    return _addButton;
}

@end
