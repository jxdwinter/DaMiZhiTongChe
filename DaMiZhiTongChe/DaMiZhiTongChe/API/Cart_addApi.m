//
//  Cart_addApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/9/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Cart_addApi.h"
#import "User.h"

@interface Cart_addApi ()

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *counts;

@end

@implementation Cart_addApi

- (instancetype) initWithGoods_id : (NSString *) goods_id withCounts : (NSString *) counts {
    if (self) {
        self.goods_id = goods_id;
        self.counts = counts;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/Cart";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"add",
                                            @"uid" : [[[AccountManager sharedAccountManager] getCurrentUser] uid],
                                            @"goods_id" : self.goods_id,
                                            @"counts" : self.counts
                                            }];
}

@end
