//
//  User.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/1/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype) initWithUserInfomation:(NSDictionary *)userInfo{
    self = [super init];
    if (self) {
        self.uid = userInfo[@"uid"];
        self.username = userInfo[@"username"];
        self.password = userInfo[@"password"];
        self.nickname = userInfo[@"nickname"];
        self.headimg = userInfo[@"headimg"];
    }
    return self;
}

@end
