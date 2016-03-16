//
//  Main_GoodsDetail.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/7/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Main_Goods.h"

@interface Main_GoodsDetail : NSObject

@property (nonatomic, strong) Main_Goods *goods;
@property (nonatomic, copy)   NSArray *imgs;
@property (nonatomic, copy)   NSString *detail_url;
@property (nonatomic, copy)   NSString *share_url;

- (instancetype) initWithGoodsDetailInfo : (NSDictionary *) goodsDetailInfo;

@end
