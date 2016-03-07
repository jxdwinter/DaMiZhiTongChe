//
//  Main_GoodsDetail.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/7/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Main_GoodsDetail : NSObject
@property (nonatomic, copy)   NSString *_id;
@property (nonatomic, copy)   NSString *goods_name;
@property (nonatomic, copy)   NSString *market_price;
@property (nonatomic, copy)   NSString *goods_price;
@property (nonatomic, copy)   NSString *farmer_name;
@property (nonatomic, copy)   NSString *origin_name;
@property (nonatomic, copy)   NSArray *imgs;
@property (nonatomic, copy)   NSString *detail_url;

- (instancetype) initWithGoodsDetailInfo : (NSDictionary *) goodsDetailInfo;

@end
