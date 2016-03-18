//
//  Cart_cancelOrderApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/18/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Cart_cancelOrderApi.h"
#import "User.h"

@interface Cart_cancelOrderApi ()

@property (nonatomic, copy) NSString *order_sn;

@end

@implementation Cart_cancelOrderApi

- (instancetype) initWithOrder_sn : (NSString *) order_sn {
    self = [super init];
    if (self) {
        self.order_sn = order_sn;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/Cart";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"cancelOrder",
                                            @"uid" : [[[AccountManager sharedAccountManager] getCurrentUser] uid],
                                            @"order_sn" : self.order_sn
                                            }];
}

@end
