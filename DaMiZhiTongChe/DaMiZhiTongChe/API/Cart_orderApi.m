//
//  Cart_orderApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/11/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Cart_orderApi.h"
#import "User.h"

@implementation Cart_orderApi

- (NSString *)requestUrl {
    return @"/Cart";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"order",
                                            @"uid" : [[[AccountManager sharedAccountManager] getCurrentUser] uid]
                                            }];
}

@end
