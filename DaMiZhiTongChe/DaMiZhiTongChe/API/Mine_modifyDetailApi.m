//
//  Mine_modifyDetailApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/16/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Mine_modifyDetailApi.h"
#import "User.h"

@implementation Mine_modifyDetailApi

- (NSString *)requestUrl {
    return @"/User";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"modifyDetail",
                                            @"id" : [[[AccountManager sharedAccountManager] getCurrentUser] uid],
                                            @"nickname" : [[[AccountManager sharedAccountManager] getCurrentUser] nickname],
                                            @"headimg" : [[[AccountManager sharedAccountManager] getCurrentUser] headimg]
                                            }];
}

@end
