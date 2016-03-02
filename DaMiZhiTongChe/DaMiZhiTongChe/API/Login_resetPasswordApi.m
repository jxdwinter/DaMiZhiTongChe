//
//  Login_resetPasswordApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/2/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Login_resetPasswordApi.h"

@interface Login_resetPasswordApi ()

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;

@end

@implementation Login_resetPasswordApi

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
                                            @"action" : @"resetPassword",
                                            @"phone" : self.phone,
                                            @"password" : self.password
                                            }];
}

@end
