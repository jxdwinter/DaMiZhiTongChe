//
//  CartSettlementViewController.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/10/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "BaseViewController.h"

@interface CartSettlementViewController : BaseViewController

//从哪个页面过来,控制付款后转跳
//0从购物车
//1从商品详情
//2从订单页面
@property (nonatomic, assign) int type;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) float allPrice;

//从订单页面过来,带订单编号
@property (nonatomic, copy) NSString *order_sn;

@end
