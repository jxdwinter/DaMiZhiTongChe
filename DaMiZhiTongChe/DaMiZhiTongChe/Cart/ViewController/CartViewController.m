//
//  CartViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 2/23/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "CartViewController.h"
#import <MJRefresh.h>
#import "Cart_GoodsTableViewCell.h"
#import "Main_GoodsDetailViewController.h"
#import "Cart_getListApi.h"
#import "Cart_goods.h"
#import "Cart_deleteApi.h"

@interface CartViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *checkStatusDataSource;
@property (nonatomic, strong) UIButton *allCheckButton;
@property (nonatomic, strong) UIButton *buyButton;
@property (nonatomic, strong) UILabel *allPriceLabel;
@property (nonatomic, assign) BOOL isAllChecked;
@property (nonatomic, assign) float allPrice;

@end

@implementation CartViewController


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"RELOADCART" object:nil];
    self.title = @"购物车";
    
    self.dataSource = [[NSMutableArray alloc] initWithCapacity:1];
    self.checkStatusDataSource = [[NSMutableArray alloc] initWithCapacity:1];
    self.isAllChecked = NO;
    self.allPrice = 0.00;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.allCheckButton];
    [self.allCheckButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-7.5);
        make.left.equalTo(self.view.mas_left).with.offset(10.0);
        make.width.equalTo(@35.0);
        make.height.equalTo(@35.0);
    }];
    
    UILabel *allCheckLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    allCheckLabel.text = @"全选";
    [allCheckLabel sizeToFit];
    allCheckLabel.textColor = DEFAULTTEXTCOLOR;
    allCheckLabel.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:allCheckLabel];
    [allCheckLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-15.0);
        make.left.equalTo(self.allCheckButton.mas_right).with.offset(10.0);
        make.height.equalTo(@20.0);
    }];
    
    [self.view addSubview:self.buyButton];
    [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.width.equalTo(@120.0);
        make.height.equalTo(@50.0);
    }];
    
    [self.view addSubview:self.allPriceLabel];
    [self.allPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0);
        make.left.equalTo(allCheckLabel.mas_right).with.offset(5.0);
        make.right.equalTo(self.buyButton.mas_left).with.offset(-5.0);
        make.height.equalTo(@50.0);
    }];
    
    [self getCartDataWithShowShouldShowHUD:YES];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.allPrice = 0.00;
    self.isAllChecked = NO;
    self.allPriceLabel.text = [NSString stringWithFormat:@"合计:￥%0.2f",self.allPrice];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    for (Cart_goods *cart_goods in self.dataSource) {
        cart_goods.isChecked = NO;
    }
    [self.tableView reloadData];
    [self.allCheckButton setImage:[UIImage imageNamed:@"cart_uncheck"] forState:UIControlStateNormal];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RELOADCART" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - privete method

- (void) getCartDataWithShowShouldShowHUD : (BOOL) shouldShowHUD{
    Cart_getListApi *api = [[Cart_getListApi alloc] init];
    if (shouldShowHUD){
        RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
        [api addAccessory:accessory];
    }
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
        if (dic) {
            if ([dic[@"result"] isEqualToString:@"0"]) {
                [self configDataWithCartData:dic[@"data"]];
            }else{
                [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
            }
        }
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

- (void) configDataWithCartData : (NSArray *) data{
    if ([data count]) {
        NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithCapacity:1];
        for (NSDictionary *cartGoodsDic in data) {
            Cart_goods *cartGoods = [[Cart_goods alloc] initWithCartGoodsInfo:cartGoodsDic];
            if (cartGoods) {
                [tmpArray addObject:cartGoods];
            }
        }
        self.dataSource = nil;
        self.dataSource  = [tmpArray mutableCopy];
    }
    [self configUI];
}

- (void) configUI {
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.allCheckButton setImage:[UIImage imageNamed:@"cart_uncheck"] forState:UIControlStateNormal];
    self.allPrice = 0.00;
    self.allPriceLabel.text = [NSString stringWithFormat:@"合计:￥%0.2f",self.allPrice];
}

- (void) reloadData {
    [self getCartDataWithShowShouldShowHUD:NO];
}

- (void) loadData {
    [self getCartDataWithShowShouldShowHUD:NO];
}

- (void) buy {
    
}

- (void) check : (UIButton *) button {
    CGPoint buttonPosition = [button convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    Cart_goods *cart_goods = self.dataSource[indexPath.row];
    cart_goods.isChecked = !cart_goods.isChecked;
    if (cart_goods.isChecked) {
        [button setImage:[UIImage imageNamed:@"cart_cell_check"] forState:UIControlStateNormal];
        BOOL isAllChecked = YES;
        for (Cart_goods *cart_goods in self.dataSource) {
            if (!cart_goods.isChecked) {
                isAllChecked = NO;
            }
        }
        if (isAllChecked) {
            self.isAllChecked = YES;
            [self.allCheckButton setImage:[UIImage imageNamed:@"cart_check"] forState:UIControlStateNormal];
        }else{
            self.isAllChecked = NO;
            [self.allCheckButton setImage:[UIImage imageNamed:@"cart_uncheck"] forState:UIControlStateNormal];
        }
        self.allPrice += [cart_goods.goods.goods_price floatValue] * [cart_goods.counts integerValue];
    }else{
        [button setImage:[UIImage imageNamed:@"cart_cell_uncheck"] forState:UIControlStateNormal];
        self.isAllChecked = NO;
        [self.allCheckButton setImage:[UIImage imageNamed:@"cart_uncheck"] forState:UIControlStateNormal];
        self.allPrice -= [cart_goods.goods.goods_price floatValue] * [cart_goods.counts integerValue];
    }
    self.allPriceLabel.text = [NSString stringWithFormat:@"合计:￥%0.2f",self.allPrice];
}

- (void) allCheckWithButton : (UIButton *) button {
    if (self.isAllChecked) {
        self.isAllChecked = NO;
        [button setImage:[UIImage imageNamed:@"cart_uncheck"] forState:UIControlStateNormal];
        for (Cart_goods *cart_goods in self.dataSource) {
            cart_goods.isChecked = NO;
        }
        self.allPrice = 0.00;
    }else{
        self.isAllChecked = YES;
        [button setImage:[UIImage imageNamed:@"cart_check"] forState:UIControlStateNormal];
        for (Cart_goods *cart_goods in self.dataSource) {
            if (!cart_goods.isChecked) {
                cart_goods.isChecked = YES;
                self.allPrice += [cart_goods.goods.goods_price floatValue] * [cart_goods.counts integerValue];
            }
        }
    }
    [self.tableView reloadData];
    self.allPriceLabel.text = [NSString stringWithFormat:@"合计:￥%0.2f",self.allPrice];
}

- (void)deleteCartGoods : (Cart_goods *) cartGood withIndexPath : (NSIndexPath *) indexPath{
    Cart_deleteApi *api = [[Cart_deleteApi alloc] initWithGoods_id:cartGood.goods._id];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
        if (dic) {
            if ([dic[@"result"] isEqualToString:@"0"]) {
                if (cartGood.isChecked) {
                    self.allPrice -= [cartGood.goods.goods_price floatValue] * [cartGood.counts integerValue];
                    self.allPriceLabel.text = [NSString stringWithFormat:@"合计:￥%0.2f",self.allPrice];
                }
                [self.tableView beginUpdates];
                [self.dataSource removeObjectAtIndex:indexPath.row];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView endUpdates];
                if ([self.dataSource count] == 0) {
                    self.isAllChecked = NO;
                    [self.allCheckButton setImage:[UIImage imageNamed:@"cart_uncheck"] forState:UIControlStateNormal];
                    return;
                }
                BOOL isAllChecked = YES;
                for (Cart_goods *cart_goods in self.dataSource) {
                    if (!cart_goods.isChecked) {
                        isAllChecked = NO;
                    }
                }
                if (isAllChecked) {
                    self.isAllChecked = YES;
                    [self.allCheckButton setImage:[UIImage imageNamed:@"cart_check"] forState:UIControlStateNormal];
                }else{
                    self.isAllChecked = NO;
                    [self.allCheckButton setImage:[UIImage imageNamed:@"cart_uncheck"] forState:UIControlStateNormal];
                }
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
    static NSString *CELL = @"CELL";
    Cart_GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL];
    if(cell == nil){
        cell = [[Cart_GoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL];
    }
    Cart_goods *cart_goods = self.dataSource[indexPath.row];
    if (cart_goods.isChecked) {
        [cell.checkBoxButton setImage:[UIImage imageNamed:@"cart_cell_check"] forState:UIControlStateNormal];
    }else{
        [cell.checkBoxButton setImage:[UIImage imageNamed:@"cart_cell_uncheck"] forState:UIControlStateNormal];
    }
    [cell.checkBoxButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [cell.checkBoxButton addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
    [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:cart_goods.goods.imgurl] placeholderImage:nil];
    cell.goods_nameLabel.text = cart_goods.goods.goods_name;
    cell.farmer_nameLabel.text = cart_goods.goods.farmer_name;
    cell.origin_nameLabel.text = cart_goods.goods.origin_name;
    cell.numberLabel.text = [NSString stringWithFormat:@"x%@",cart_goods.counts];
    cell.priceLabel.text =  cart_goods.goods.goods_price;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Cart_goods *cart_goods = self.dataSource[indexPath.row];
    Main_GoodsDetailViewController *main_GoodsDetailViewController = [[Main_GoodsDetailViewController alloc] init];
    main_GoodsDetailViewController.title = cart_goods.goods.goods_name;
    main_GoodsDetailViewController.goods_id = cart_goods.goods._id;
    [self.navigationController pushViewController:main_GoodsDetailViewController animated:YES];
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
        Cart_goods *cart_goods = self.dataSource[indexPath.row];
        [self deleteCartGoods:cart_goods withIndexPath:indexPath];
    }
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

#pragma mark - getter and setter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH,SCREEN_HEIGHT - NAVIGATIONBARHEIGHT - TABBARHEIGHT - 50.0)
                                                  style:UITableViewStylePlain];
        _tableView.backgroundView = nil;
        _tableView.backgroundColor = DEFAULTLIGHTGRAYCOLOR;
        _tableView.rowHeight = 100;
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

- (UIButton *) allCheckButton {
    if (!_allCheckButton) {
        _allCheckButton = [[UIButton alloc] init];
        [_allCheckButton setImage:[UIImage imageNamed:@"cart_uncheck"] forState:UIControlStateNormal];
        [_allCheckButton addTarget:self action:@selector(allCheckWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allCheckButton;
}

- (UIButton *) buyButton {
    if (!_buyButton) {
        _buyButton = [[UIButton alloc] init];
        [_buyButton addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
        _buyButton.titleLabel.font = DEFAULFONT;
        _buyButton.backgroundColor = DEFAULTBROWNCOLOR;
        [_buyButton setTitle:@"结算" forState:UIControlStateNormal];
    }
    return _buyButton;
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
