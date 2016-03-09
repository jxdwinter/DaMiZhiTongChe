//
//  Cart_goods.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/9/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Cart_goods.h"

@implementation Cart_goods

- (instancetype) initWithCartGoodsInfo : (NSDictionary *) cartGoodsInfo {
    self = [super init];
    if (self) {
        self.goods = [[Main_Goods alloc] initWithGoodsInfo:cartGoodsInfo];
        self.counts = cartGoodsInfo[@"counts"];
    }
    return self;
}

@end
