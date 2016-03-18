//
//  CartSettlementViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/10/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "CartSettlementViewController.h"
#import "Cart_goods.h"
#import "Cart_SettlementTableViewCell.h"
#import "Cart_PaymentTableViewCell.h"
#import "Cart_AddressTableViewCell.h"
#import "CartAddressListViewController.h"
#import "Cart_orderApi.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "MineOrderViewController.h"
#import "Cart_getDefaultAddressApi.h"
#import "Cart_address.h"
#import "CartAddressListViewController.h"
#import "Cart_payOrderApi.h"
#import "Cart_getOrderAddressApi.h"

@interface CartSettlementViewController () <UITableViewDelegate,UITableViewDataSource,SelectAddressDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *settlementButton;
@property (nonatomic, strong) UILabel *allPriceLabel;

@property (nonatomic, strong) UIButton *weixinButton;
@property (nonatomic, assign) BOOL isCheckedWeixin;
@property (nonatomic, strong) UIButton *alipayButton;
@property (nonatomic, assign) BOOL isCheckedAlipay;

@property (nonatomic, strong) Cart_address *address;

@end

@implementation CartSettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //支付成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:@"MINEPAYED" object:nil];
    //支付失败
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail) name:@"MINEUNPAYED" object:nil];
    
    self.backButton.hidden = NO;
    self.title = @"确认订单";
    
    self.isCheckedWeixin = NO;
    self.isCheckedAlipay = NO;
    
    [self.view addSubview:self.settlementButton];
    [self.settlementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.width.equalTo(@120.0);
        make.height.equalTo(@50.0);
    }];
    
    [self.view addSubview:self.allPriceLabel];
    [self.allPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0);
        make.left.equalTo(self.view.mas_left).with.offset(5.0);
        make.right.equalTo(self.settlementButton.mas_left).with.offset(-5.0);
        make.height.equalTo(@50.0);
    }];
    
    [self.view addSubview:self.tableView];
    
    if (self.type == 0 && self.type == 1) {
        [self getDefaultAddress];
    }else if (self.type == 2){
        [self getOrderAddress];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MINEPAYED" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MINEUNPAYED" object:nil];
}

#pragma mark - privete method

- (void) getDefaultAddress {
    Cart_getDefaultAddressApi *api = [[Cart_getDefaultAddressApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
        if (dic) {
            if ([dic[@"result"] isEqualToString:@"0"]) {
                Cart_address *cart_address = [[Cart_address alloc] initWithCart_addressInfo:dic[@"data"]];
                self.address = cart_address;
                NSArray* rowsToReload = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil];
                [self.tableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
            }
        }
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

- (void) getOrderAddress {
    Cart_getOrderAddressApi *api = [[Cart_getOrderAddressApi alloc] initWithOrder_sn:self.order_sn];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
        if (dic) {
            if ([dic[@"result"] isEqualToString:@"0"]) {
                Cart_address *cart_address = [[Cart_address alloc] initWithCart_addressInfo:dic[@"data"]];
                self.address = cart_address;
                NSArray* rowsToReload = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil];
                [self.tableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
            }
        }
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

- (void) payFail {
    [self.navigationController popViewControllerAnimated:YES];
    if (self.type == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CARTFAIL" object:nil];
    }else if (self.type == 1){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GOODDETAILCARTFAIL" object:nil];
    }else if (self.type == 2){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ORDERFAIL" object:nil];
    }
}

- (void) paySuccess {
    [self.navigationController popViewControllerAnimated:YES];
    if (self.type == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CARTSUCCESS" object:nil];
    }else if (self.type == 1){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GOODDETAILSUCCESS" object:nil];
    }else if (self.type == 2){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ORDERSUCCESS" object:nil];
    }
}

- (void) settlement {
    if (self.address) {
        //从订单页面过来
        if (self.type == 2) {
            Cart_payOrderApi *api;
            if (self.isCheckedAlipay) {
                api = [[Cart_payOrderApi alloc] initWithOrder_sn:self.order_sn withPay_id:@"2"];
            }else if (self.isCheckedWeixin){
                api = [[Cart_payOrderApi alloc] initWithOrder_sn:self.order_sn withPay_id:@"1"];
                if (![WXApi isWXAppInstalled]) {
                    [MBProgressHUD showHUDwithSuccess:NO WithTitle:@"没有安装微信" withView:self.navigationController.view];
                    return;
                }
            }else{
                [MBProgressHUD showHUDwithSuccess:NO WithTitle:@"请选择一种支付方式" withView:self.navigationController.view];
                return;
            }
            RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
            [api addAccessory:accessory];
            [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
                NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
                if (dic) {
                    if ([dic[@"result"] isEqualToString:@"0"]) {
                        if (self.isCheckedAlipay) {
                            [[AlipaySDK defaultService] payOrder:[dic[@"data"] objectForKey:@"para"] fromScheme:@"damizhitongche" callback:^(NSDictionary *resultDic) {
                                if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                                    [self paySuccess];
                                }else{
                                    [self payFail];
                                }
                            }];
                        }else if (self.isCheckedWeixin){
                            PayReq* req             = [[PayReq alloc] init];
                            req.partnerId           = [dic[@"data"] objectForKey:@"partnerid"];
                            req.prepayId            = [dic[@"data"] objectForKey:@"prepayid"];
                            req.nonceStr            = [dic[@"data"] objectForKey:@"noncestr"];
                            req.timeStamp           = [[dic[@"data"] objectForKey:@"timestamp"] intValue];
                            req.package             = [dic[@"data"] objectForKey:@"package"];
                            req.sign                = [dic[@"data"] objectForKey:@"sign"];
                            [WXApi sendReq:req];
                        }
                        //通知购物车刷新
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"RELOADCART" object:nil];
                    }else{
                        [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
                    }
                }
            } failure:^(YTKBaseRequest *request) {
                
            }];
        }else{
            NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithCapacity:1];
            for (Cart_goods *cart_goods in self.dataSource) {
                NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithCapacity:1];
                [tmpDic setValue:cart_goods.goods._id forKey:@"id"];
                [tmpDic setValue:cart_goods.counts forKey:@"count"];
                [tmpArray addObject:tmpDic];
            }
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tmpArray options:NSJSONWritingPrettyPrinted error:&error];
            if (error) {
                return;
            }
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSString *is_cart;
            //购物车
            if (self.type == 0) {
                is_cart = @"1";
            }else if (self.type == 1){
                is_cart = @"0";
            }
            Cart_orderApi *api;
            if (self.isCheckedAlipay) {
                api = [[Cart_orderApi alloc] initWithPay_id:@"2" withGoods:jsonString withAddress_id:self.address._id withIs_cart:is_cart];
            }else if (self.isCheckedWeixin){
                api = [[Cart_orderApi alloc] initWithPay_id:@"1" withGoods:jsonString withAddress_id:self.address._id withIs_cart:is_cart];
                if (![WXApi isWXAppInstalled]) {
                    [MBProgressHUD showHUDwithSuccess:NO WithTitle:@"没有安装微信" withView:self.navigationController.view];
                    return;
                }
            }else{
                [MBProgressHUD showHUDwithSuccess:NO WithTitle:@"请选择一种支付方式" withView:self.navigationController.view];
                return;
            }
            RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
            [api addAccessory:accessory];
            [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
                NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
                if (dic) {
                    if ([dic[@"result"] isEqualToString:@"0"]) {
                        if (self.isCheckedAlipay) {
                            [[AlipaySDK defaultService] payOrder:[dic[@"data"] objectForKey:@"para"] fromScheme:@"damizhitongche" callback:^(NSDictionary *resultDic) {
                                if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                                    [self paySuccess];
                                }else{
                                    [self payFail];
                                }
                            }];
                        }else if (self.isCheckedWeixin){
                            PayReq* req             = [[PayReq alloc] init];
                            req.partnerId           = [dic[@"data"] objectForKey:@"partnerid"];
                            req.prepayId            = [dic[@"data"] objectForKey:@"prepayid"];
                            req.nonceStr            = [dic[@"data"] objectForKey:@"noncestr"];
                            req.timeStamp           = [[dic[@"data"] objectForKey:@"timestamp"] intValue];
                            req.package             = [dic[@"data"] objectForKey:@"package"];
                            req.sign                = [dic[@"data"] objectForKey:@"sign"];
                            [WXApi sendReq:req];
                        }
                        //通知购物车刷新
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"RELOADCART" object:nil];
                    }else{
                        [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
                    }
                }
            } failure:^(YTKBaseRequest *request) {
                
            }];
        }
    }else{
        [MBProgressHUD showHUDwithSuccess:NO WithTitle:@"请选择收货地址" withView:self.navigationController.view];
    }
}

- (void) alipay {
    [self.alipayButton setImage:[UIImage imageNamed:@"cart_check"] forState:UIControlStateNormal];
    self.isCheckedAlipay = YES;
    [self.weixinButton setImage:[UIImage imageNamed:@"cart_uncheck"] forState:UIControlStateNormal];
    self.isCheckedWeixin = NO;
}

- (void) weixin {
    [self.alipayButton setImage:[UIImage imageNamed:@"cart_uncheck"] forState:UIControlStateNormal];
    self.isCheckedWeixin = YES;
    [self.weixinButton setImage:[UIImage imageNamed:@"cart_check"] forState:UIControlStateNormal];
    self.isCheckedAlipay = NO;
}

#pragma mark - SelectAddressDelegate

- (void) setDefaultAdressWithAddress:(Cart_address *)address {
    self.address = address;
    NSArray* rowsToReload = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil];
    [self.tableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 2;
    }else return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *CART_ADDRESSTABLEVIEWCELL = @"CART_ADDRESSTABLEVIEWCELL";
        Cart_AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CART_ADDRESSTABLEVIEWCELL];
        if(cell == nil){
            cell = [[Cart_AddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CART_ADDRESSTABLEVIEWCELL];
        }
        cell.iconImageView.image = [UIImage imageNamed:@"mine_loacation"];
        cell.nameLabel.text = self.address.name?[NSString stringWithFormat:@"收货人:%@",self.address.name]:@"";
        cell.phoneLabel.text = self.address.mobile?self.address.mobile:@"";
        cell.addressLabel.text = self.address.address?self.address.address:@"";
        if (self.type == 0 || self.type == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        static NSString *CART_PAYMENTTABLEVIEWCELL = @"CART_PAYMENTTABLEVIEWCELL";
        Cart_PaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CART_PAYMENTTABLEVIEWCELL];
        if(cell == nil){
            cell = [[Cart_PaymentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CART_PAYMENTTABLEVIEWCELL];
        }
        if (indexPath.row == 0) {
            cell.iconImagView.image = [UIImage imageNamed:@"alipay"];
            cell.nameLabel.text = @"支付宝支付";
            [cell.checkBoxButton setImage:[UIImage imageNamed:@"cart_uncheck"] forState:UIControlStateNormal];
            [cell.checkBoxButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
            [cell.checkBoxButton addTarget:self action:@selector(alipay) forControlEvents:UIControlEventTouchUpInside];
            self.alipayButton = cell.checkBoxButton;
        }else if (indexPath.row == 1){
            cell.iconImagView.image = [UIImage imageNamed:@"weixin"];
            cell.nameLabel.text = @"微信支付";
            [cell.checkBoxButton setImage:[UIImage imageNamed:@"cart_uncheck"] forState:UIControlStateNormal];
            [cell.checkBoxButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
            [cell.checkBoxButton addTarget:self action:@selector(weixin) forControlEvents:UIControlEventTouchUpInside];
            self.weixinButton = cell.checkBoxButton;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *CELL = @"CELL";
        Cart_SettlementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL];
        if(cell == nil){
            cell = [[Cart_SettlementTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL];
        }
        Cart_goods *cart_goods = self.dataSource[indexPath.row];
        [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:cart_goods.goods.imgurl] placeholderImage:nil];
        cell.goods_nameLabel.text = cart_goods.goods.goods_name;
        cell.farmer_nameLabel.text = cart_goods.goods.farmer_name;
        cell.origin_nameLabel.text = cart_goods.goods.origin_name;
        cell.numberLabel.text = [NSString stringWithFormat:@"x%@",cart_goods.counts];
        cell.priceLabel.text =  cart_goods.goods.goods_price;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80.0;
    }else if (indexPath.section == 1) {
        return 50.0;
    }else return 100.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 0 && self.type == 1) {
        if (indexPath.section == 0 || indexPath.row == 0) {
            CartAddressListViewController *cartAddressListViewController = [[CartAddressListViewController alloc] init];
            cartAddressListViewController.type = 0;
            cartAddressListViewController.selectAddressDelegate = self;
            [self.navigationController pushViewController:cartAddressListViewController animated:YES];
        }
    }else{
        
    }
}

#pragma mark - getter and setter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH,SCREEN_HEIGHT - NAVIGATIONBARHEIGHT - 50.0) style:UITableViewStyleGrouped];
        _tableView.backgroundView = nil;
        _tableView.backgroundColor = DEFAULTLIGHTGRAYCOLOR;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    }
    return _tableView;
}

- (UIButton *) settlementButton {
    if (!_settlementButton) {
        _settlementButton = [[UIButton alloc] init];
        [_settlementButton addTarget:self action:@selector(settlement) forControlEvents:UIControlEventTouchUpInside];
        _settlementButton.titleLabel.font = DEFAULFONT;
        _settlementButton.backgroundColor = DEFAULTBROWNCOLOR;
        [_settlementButton setTitle:@"确认" forState:UIControlStateNormal];
    }
    return _settlementButton;
}

- (UILabel *) allPriceLabel {
    if (!_allPriceLabel) {
        _allPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _allPriceLabel.text = [NSString stringWithFormat:@"合计:￥%0.2f",self.allPrice];
        _allPriceLabel.textColor = DEFAULTTEXTCOLOR;
        _allPriceLabel.font = [UIFont systemFontOfSize:12.0];
        _allPriceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _allPriceLabel;
}

@end
