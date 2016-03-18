//
//  Mine_order_goods.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/17/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Mine_order_goods.h"
#import "Cart_goods.h"

@implementation Mine_order_goods

- (instancetype) initWithMine_order_goodsInfo : (NSDictionary *) mine_order_goodsInfo {
    self = [super init];
    if (self) {
        self.ent_id = mine_order_goodsInfo[@"ent_id"];
        self.ent_name = mine_order_goodsInfo[@"ent_name"];
        self.linkmode = mine_order_goodsInfo[@"linkmode"];
        self.logistics_info = mine_order_goodsInfo[@"logistics_info"];
        self.cart_goods = [[Cart_goods alloc] initWithCartGoodsInfo:mine_order_goodsInfo];
    }
    return self;
}

@end
