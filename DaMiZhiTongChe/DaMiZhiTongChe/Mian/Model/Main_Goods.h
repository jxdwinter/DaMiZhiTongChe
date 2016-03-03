//
//  Main_Goods.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/3/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 商品
 */
@interface Main_Goods : NSObject

/*
 "id": "商品ID",
 "imgurl": "商品图片",
 "goods_name": "商品名称",
 "market_price": "市场售价",
 "goods_price": "店铺售价",
 "farmer_name": "农户名",
 "origin_name": "产地名"
 */

@property (nonatomic, copy)   NSString *_id;
@property (nonatomic, copy)   NSString *imgurl;
@property (nonatomic, copy)   NSString *goods_name;
@property (nonatomic, copy)   NSString *market_price;
@property (nonatomic, copy)   NSString *goods_price;
@property (nonatomic, copy)   NSString *farmer_name;
@property (nonatomic, copy)   NSString *origin_name;

- (instancetype) initWithGoodsInfo : (NSDictionary *) goodsInfo;

@end
