//
//  Login_sendCodeApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/1/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Login_sendCodeApi.h"

@interface Login_sendCodeApi ()

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *type;

@end

@implementation Login_sendCodeApi

- (instancetype) initWithPhone : (NSString *) phone withType : (NSString *) type{
    self = [super init];
    if (self) {
        self.phone = phone;
        self.type = type;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/User";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"sendCode",
                                            @"phone" : self.phone,
                                            @"type" : self.type
                                            }];
}

@end
