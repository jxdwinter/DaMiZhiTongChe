//
//  Mine_enterprise.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/17/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Mine_enterprise.h"
#import "Cart_goods.h"

@implementation Mine_enterprise

- (instancetype) initWitEnterpriseInfo : (NSDictionary *) enterpriseInfo {
    self = [super init];
    if (self) {
        self._id = enterpriseInfo[@"id"];
        self.name = enterpriseInfo[@"name"];
        self.linkmode = enterpriseInfo[@"linkmode"];
        NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithCapacity:1];
        for (NSDictionary *dic in enterpriseInfo[@"goods_list"]) {
            Cart_goods *cart_goods = [[Cart_goods alloc] initWithCartGoodsInfo:dic];
            if (cart_goods) {
                [tmpArray addObject:cart_goods];
            }
        }
        self.goods_list = [tmpArray copy];
    }
    return self;
}

@end
