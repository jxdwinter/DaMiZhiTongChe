//
//  Cart_payOrderApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/18/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Cart_payOrderApi.h"
#import "User.h"

@interface Cart_payOrderApi ()

@property (nonatomic, copy) NSString *pay_id;
@property (nonatomic, copy) NSString *order_sn;

@end

@implementation Cart_payOrderApi

- (instancetype) initWithOrder_sn : (NSString *) order_sn withPay_id : (NSString *) pay_id {
    self = [super init];
    if (self) {
        self.order_sn = order_sn;
        self.pay_id = pay_id;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/Cart";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"payOrder",
                                            @"uid" : [[[AccountManager sharedAccountManager] getCurrentUser] uid],
                                            @"pay_id" : self.pay_id,
                                            @"order_sn" : self.order_sn
                                            }];
}

@end
