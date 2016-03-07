//
//  Main_getGoodsApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/7/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Main_getGoodsApi.h"

@interface Main_getGoodsApi ()

@property (nonatomic, copy) NSString *goods_id;

@end

@implementation Main_getGoodsApi

- (instancetype) initWithGoods_id : (NSString *) goods_id {
    self = [super init];
    if (self) {
        self.goods_id = goods_id;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/Goods";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"getGoods",
                                            @"goods_id" : self.goods_id
                                            }];
}

- (NSInteger)cacheTimeInSeconds {
    // 3分钟 = 180 秒
    return 60 * 3;
}

@end
