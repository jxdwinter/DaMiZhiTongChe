//
//  Main_Goods.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/3/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Main_Goods.h"

@implementation Main_Goods


- (instancetype) initWithGoodsInfo : (NSDictionary *) goodsInfo {
    self = [super init];
    if (self) {
        self._id = goodsInfo[@"id"];
        self.imgurl = goodsInfo[@"imgurl"];
        self.goods_name = goodsInfo[@"goods_name"];
        self.market_price = goodsInfo[@"market_price"];
        self.goods_price = goodsInfo[@"goods_price"];
        self.farmer_name = goodsInfo[@"farmer_name"];
        self.origin_name = goodsInfo[@"origin_name"];
    }
    return self;
}


@end
