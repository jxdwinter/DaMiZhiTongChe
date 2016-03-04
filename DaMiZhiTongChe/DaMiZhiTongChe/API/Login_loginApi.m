//
//  Login_loginApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/2/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Login_loginApi.h"

@interface Login_loginApi ()

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;

@end

@implementation Login_loginApi

- (instancetype) initWithPhone : (NSString *) phone withPassword : (NSString *) password {
    self = [super init];
    if (self) {
        self.phone = phone;
        self.password = password;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/User";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"login",
                                            @"phone" : self.phone,
                                            @"password" : self.password,
                                            @"token" : [AccountHelper accountToken],
                                            @"flag" : @"0"
                                            }];
}

@end
