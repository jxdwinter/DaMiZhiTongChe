//
//  Cart_AddAddressApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/15/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Cart_AddAddressApi.h"
#import "User.h"

@interface Cart_AddAddressApi ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *zipcode;
@property (nonatomic, copy) NSString *mobile;

@end

@implementation Cart_AddAddressApi

- (instancetype) initWithName : (NSString *) name withAddress : (NSString *) address withZipcode : (NSString *) zipcode withMobile : (NSString *) mobile {
    self = [super init];
    if (self) {
        self.name = name;
        self.address = address;
        self.zipcode = zipcode;
        self.mobile = mobile;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/Address";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"addAddress",
                                            @"uid" : [[[AccountManager sharedAccountManager] getCurrentUser] uid],
                                            @"name" : self.name,
                                            @"address" : self.address,
                                            @"zipcode" : self.zipcode,
                                            @"mobile" : self.mobile
                                            }];
}

@end
