//
//  Login_validateCodeApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/2/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Login_validateCodeApi.h"

@interface Login_validateCodeApi ()

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *type;

@end

@implementation Login_validateCodeApi

- (instancetype) initWithPhone : (NSString *) phone withCode : (NSString *) code withType : (NSString *) type {
    self = [super init];
    if (self) {
        self.phone = phone;
        self.code = code;
        self.type = type;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/User";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"validateCode",
                                            @"phone" : self.phone,
                                            @"code" : self.code,
                                            @"type" : self.type
                                            }];
}

@end
