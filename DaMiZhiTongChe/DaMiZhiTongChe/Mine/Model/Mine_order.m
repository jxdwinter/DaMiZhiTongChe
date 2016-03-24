//
//  Mine_order.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/17/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Mine_order.h"
#import "Mine_order_goods.h"

@implementation Mine_order

- (instancetype) initWithOrderInfo : (NSDictionary *) orderInfo {
    self = [super init];
    if (self) {
        self.order_sn = orderInfo[@"order_sn"];
        self.total_amount = orderInfo[@"total_amount"];
        self.name = orderInfo[@"name"];
        self.address = orderInfo[@"address"];
        self.zipcode = orderInfo[@"zipcode"];
        self.mobile = orderInfo[@"mobile"];
        self.add_time = orderInfo[@"add_time"];
        NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithCapacity:1];
        for (NSDictionary *dic in orderInfo[@"goods_list"]) {
            Mine_order_goods *mine_order_goods = [[Mine_order_goods alloc] initWithMine_order_goodsInfo:dic];
            if (mine_order_goods) {
                [tmpArray addObject:mine_order_goods];
            }
        }
        self.goods_list = [tmpArray copy];
    }
    return self;
}

@end
