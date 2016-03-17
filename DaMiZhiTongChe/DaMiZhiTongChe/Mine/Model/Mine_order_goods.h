//
//  Mine_order_goods.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/17/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Cart_goods;

@interface Mine_order_goods : NSObject

@property (nonatomic, copy)   NSString *ent_id;
@property (nonatomic, copy)   NSString *ent_name;
@property (nonatomic, copy)   NSString *linkmode;
@property (nonatomic, copy)   NSString *logistics_sn;
@property (nonatomic, strong) Cart_goods *cart_goods;

- (instancetype) initWithMine_order_goodsInfo : (NSDictionary *) mine_order_goodsInfo;

@end
