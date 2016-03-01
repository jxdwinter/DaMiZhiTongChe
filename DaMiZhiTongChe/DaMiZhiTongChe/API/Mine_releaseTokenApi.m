//
//  Mine_releaseTokenApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/1/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Mine_releaseTokenApi.h"
#import "AccountHelper.h"

@interface Mine_releaseTokenApi ()

@end

@implementation Mine_releaseTokenApi

- (NSString *)requestUrl {
    return @"/User";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"releaseToken",
                                            @"token" : [AccountHelper accountToken],
                                            @"flag" : @"0"
                                            }];
}

@end
