//
//  Cart_goods.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/9/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Main_Goods.h"

@interface Cart_goods : NSObject

@property (nonatomic, strong) Main_Goods *goods;
@property (nonatomic, copy)   NSString *counts;

- (instancetype) initWithCartGoodsInfo : (NSDictionary *) cartGoodsInfo;

@end
