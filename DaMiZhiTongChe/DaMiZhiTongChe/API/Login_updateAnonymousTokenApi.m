//
//  Login_updateAnonymousTokenApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/1/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Login_updateAnonymousTokenApi.h"
#import "AccountHelper.h"

@interface Login_updateAnonymousTokenApi ()

@end

@implementation Login_updateAnonymousTokenApi

- (NSString *)requestUrl {
    return @"/User";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"updateAnonymousToken",
                                            @"token" : [AccountHelper accountToken],
                                            @"flag" : @"0"
                                            }];
}

@end
