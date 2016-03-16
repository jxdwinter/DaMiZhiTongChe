//
//  Cart_orderApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/11/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Cart_orderApi.h"
#import "User.h"

@interface Cart_orderApi ()

@property (nonatomic, copy) NSString *pay_id;
@property (nonatomic, copy) NSString *goods;
@property (nonatomic, copy) NSString *address_id;

@end

@implementation Cart_orderApi

- (instancetype) initWithPay_id : (NSString *) pay_id withGoods : (NSString *) goods withAddress_id : (NSString *) address_id {
    self = [super init];
    if (self) {
        self.pay_id = pay_id;
        self.goods = goods;
        self.address_id = address_id;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/Cart";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"order",
                                            @"uid" : [[[AccountManager sharedAccountManager] getCurrentUser] uid],
                                            @"pay_id" : self.pay_id,
                                            @"goods" : self.goods,
                                            @"address_id" : self.address_id
                                            }];
}

@end
