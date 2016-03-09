//
//  Cart_getListApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/9/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Cart_getListApi.h"
#import "User.h"

@implementation Cart_getListApi

- (NSString *)requestUrl {
    return @"/Cart";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"getList",
                                            @"uid" : [[[AccountManager sharedAccountManager] getCurrentUser] uid]
                                            }];
}

@end
