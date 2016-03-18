//
//  MineOrderSentViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/15/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "MineOrderSentViewController.h"
#import "Mine_getOrderListApi.h"
#import "Mine_getOrderListApi.h"
#import <MJRefresh.h>
#import "Mine_order.h"
#import "Mine_order_goods.h"
#import "Mine_OrderTableViewCell.h"
#import "Cart_goods.h"
#import "Mine_OrderHeaderView.h"
#import "Mine_OrderFooterView.h"
#import "Cart_confirmReceiptApi.h"
#import <JGActionSheet.h>

#define ORDER_STATUS @"2"

@interface MineOrderSentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MineOrderSentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderData) name:@"SENTRELOAD" object:nil];
    // Do any additional setup after loading the view.
    self.dataSource = [[NSMutableArray alloc] initWithCapacity:1];
    [self.view addSubview:self.tableView];
    
    [self getOrderData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SENTRELOAD" object:nil];
}

#pragma mark - privete method

- (void) getOrderData {
    Mine_getOrderListApi *api = [[Mine_getOrderListApi alloc] initWithOrder_status:ORDER_STATUS];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
        if (dic) {
            if ([dic[@"result"] isEqualToString:@"0"]) {
                [self configDataWithCartData:dic[@"data"]];
            }else if ([dic[@"result"] isEqualToString:@"1"]){
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
        for (NSDictionary *cartDic in data) {
            Mine_order *order = [[Mine_order alloc] initWithOrderInfo:cartDic];
            if (order) {
                [tmpArray addObject:order];
            }
        }
        self.dataSource = nil;
        self.dataSource  = [tmpArray mutableCopy];
    }else {
        [self.dataSource removeAllObjects];
    }
    [self configUI];
}

- (void) configUI {
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}


- (void) receivedWithButton : (UIButton *) button {
    JGActionSheetSection *section = [JGActionSheetSection sectionWithTitle:@"确认收货吗?" message:@"" buttonTitles:@[@"确认"] buttonStyle:JGActionSheetButtonStyleDefault];
    section.titleLabel.textColor = DEFAULTTEXTCOLOR;
    section.titleLabel.font = DEFAULFONT;
    JGActionSheetSection *cancelSection = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleCancel];
    NSArray *sections = @[section, cancelSection];
    JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
    [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
        [sheet dismissAnimated:YES];
        if (indexPath.section == 0 && indexPath.row == 0) {
            Mine_order *order = self.dataSource[button.tag];
            NSArray *tmpArray = order.goods_list;
            NSMutableString *tmpString = [[NSMutableString alloc] initWithCapacity:1];;
            for (Mine_order_goods *order_goods in tmpArray) {
                [tmpString appendString:order_goods.ent_id];
                [tmpString appendString:@","];
            }
            NSString *ent_ids;
            if ([tmpString length] > 0) {
                ent_ids = [tmpString substringToIndex:[tmpString length] - 1];
            }
            [self receivedOrder:order withEnt_ids:ent_ids withIndex:button.tag];
        }
    }];
    [sheet showInView:self.navigationController.view animated:YES];
}

- (void)receivedOrder : (Mine_order *) order withEnt_ids : (NSString *) ent_ids withIndex  : (NSInteger) index{
    Cart_confirmReceiptApi *api = [[Cart_confirmReceiptApi alloc] initWithOrder_sn:order.order_sn withEnt_id:ent_ids];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
        if (dic) {
            if ([dic[@"result"] isEqualToString:@"0"]) {
                [self.dataSource removeObjectAtIndex:index];
                [self.tableView reloadData];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RECEIVEDRELOAD" object:nil];
            }else {
                [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
            }
        }
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dataSource[section] goods_list] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    Mine_OrderHeaderView *headerView = [[Mine_OrderHeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 35.0)];
    headerView.button.hidden = YES;
    headerView.orderNumberLabel.text = [NSString stringWithFormat:@"订单编号:%@",[self.dataSource[section] order_sn]];
    headerView.addressLabel.text = [NSString stringWithFormat:@"收货信息:%@ %@ %@",[self.dataSource[section] name],[self.dataSource[section] mobile],[self.dataSource[section] address]];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    Mine_OrderFooterView *footerView = [[Mine_OrderFooterView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 35.0)];
    [footerView.button setTitle:@"确认收货" forState:UIControlStateNormal];
    footerView.button.tag = section;
    [footerView.button addTarget:self action:@selector(receivedWithButton:) forControlEvents:UIControlEventTouchUpInside];
    footerView.priceLabel.text = [NSString stringWithFormat:@"订单总价:%@",[self.dataSource[section] total_amount]];
    return footerView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 35.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CELL = @"CELL";
    Mine_OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL];
    if(cell == nil){
        cell = [[Mine_OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL];
    }
    Mine_order_goods *order_goods = [self.dataSource[indexPath.section] goods_list][indexPath.row];
    
    cell.linkmodeLabel.text = [NSString stringWithFormat:@"电话:%@",order_goods.linkmode];
    cell.ent_nameLabel.text = [NSString stringWithFormat:@"商家:%@",order_goods.ent_name];
    [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:order_goods.cart_goods.goods.imgurl] placeholderImage:nil];
    cell.goods_nameLabel.text = order_goods.cart_goods.goods.goods_name;
    cell.farmer_nameLabel.text = order_goods.cart_goods.goods.farmer_name;
    cell.origin_nameLabel.text = order_goods.cart_goods.goods.origin_name;
    cell.numberLabel.text = [NSString stringWithFormat:@"x%@",order_goods.cart_goods.counts];
    cell.priceLabel.text =  order_goods.cart_goods.goods.goods_price;
    cell.logistics_snLabel.text = [NSString stringWithFormat:@"%@",order_goods.logistics_info];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - getter and setter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH,SCREEN_HEIGHT - NAVIGATIONBARHEIGHT - 40.0) style:UITableViewStyleGrouped];
        _tableView.backgroundView = nil;
        _tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 145;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(getOrderData)];
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

@end
