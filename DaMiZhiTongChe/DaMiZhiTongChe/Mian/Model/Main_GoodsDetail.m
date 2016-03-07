//
//  Main_GoodsDetail.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/7/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Main_GoodsDetail.h"

@implementation Main_GoodsDetail

- (instancetype) initWithGoodsDetailInfo : (NSDictionary *) goodsDetailInfo {
    self = [super init];
    if (self) {
        self._id = goodsDetailInfo[@"id"];
        self.goods_name = goodsDetailInfo[@"goods_name"];
        self.market_price = goodsDetailInfo[@"market_price"];
        self.goods_price = goodsDetailInfo[@"goods_price"];
        self.farmer_name = goodsDetailInfo[@"farmer_name"];
        self.origin_name = goodsDetailInfo[@"origin_name"];
        self.detail_url = goodsDetailInfo[@"detail_url"];
        NSMutableArray *tmp = [[NSMutableArray alloc] initWithCapacity:1];
        if ([goodsDetailInfo[@"imgs"] isKindOfClass:[NSArray class]] && [goodsDetailInfo[@"imgs"] count]) {
            for (NSString *urlString in goodsDetailInfo[@"imgs"]) {
                [tmp addObject:urlString];
            }
        }
        self.imgs = [tmp copy];
    }
    return self;
}

@end
