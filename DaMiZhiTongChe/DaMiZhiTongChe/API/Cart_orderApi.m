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

@end

@implementation Cart_orderApi

- (instancetype) initWithPay_id : (NSString *) pay_id {
    self = [super init];
    if (self) {
        self.pay_id = pay_id;
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
                                            @"pay_id" : self.pay_id
                                            }];
}

@end
