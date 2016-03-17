//
//  Mine_order.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/17/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Mine_order.h"
#import "Mine_enterprise.h"

@implementation Mine_order

- (instancetype) initWithOrderInfo : (NSDictionary *) orderInfo {
    self = [super init];
    if (self) {
        self.order_sn = orderInfo[@"order_sn"];
        NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithCapacity:1];
        for (NSDictionary *dic in orderInfo[@"enterprise"]) {
            Mine_enterprise *enterprise = [[Mine_enterprise alloc] initWitEnterpriseInfo:dic];
            if (enterprise) {
                [tmpArray addObject:enterprise];
            }
        }
        self.enterprise = [tmpArray copy];
    }
    return self;
}

@end
