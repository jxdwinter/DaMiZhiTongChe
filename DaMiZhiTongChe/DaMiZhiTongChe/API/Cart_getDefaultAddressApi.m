//
//  Cart_getDefaultAddressApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/15/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Cart_getDefaultAddressApi.h"
#import "User.h"

@implementation Cart_getDefaultAddressApi

- (NSString *)requestUrl {
    return @"/Address";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"getDefaultAddress",
                                            @"uid" : [[[AccountManager sharedAccountManager] getCurrentUser] uid]
                                            }];
}

@end
