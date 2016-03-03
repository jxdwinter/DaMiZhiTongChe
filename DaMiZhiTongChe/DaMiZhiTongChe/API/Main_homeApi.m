//
//  Main_homeApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/3/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Main_homeApi.h"

@implementation Main_homeApi


- (NSString *)requestUrl {
    return @"/Goods";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"home"
                                            }];
}

@end
