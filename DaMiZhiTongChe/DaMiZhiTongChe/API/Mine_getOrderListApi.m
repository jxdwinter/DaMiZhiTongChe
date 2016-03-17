//
//  Mine_getOrderListApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/17/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Mine_getOrderListApi.h"
#import "User.h"

@implementation Mine_getOrderListApi

- (instancetype) initWithOrder_status : (NSString *) order_status {
    self = [super init];
    if (self) {
        self.order_status = order_status;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/Cart";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"getOrderList",
                                            @"uid" : [[[AccountManager sharedAccountManager] getCurrentUser] uid],
                                            @"order_status" : self.order_status
                                            }];
}

@end
