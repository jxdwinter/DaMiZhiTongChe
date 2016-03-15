//
//  Cart_modifyAddressApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/15/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Cart_modifyAddressApi.h"
#import "User.h"

@interface Cart_modifyAddressApi ()

@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *zipcode;
@property (nonatomic, copy) NSString *mobile;

@end

@implementation Cart_modifyAddressApi

- (instancetype) initWithId : (NSString *) _id
                   withName : (NSString *) name
                withAddress : (NSString *) address
                withZipcode : (NSString *) zipcode
                 withMobile : (NSString *) mobile {
    self = [super init];
    if (self) {
        self._id = _id;
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
                                            @"action" : @"modifyAddress",
                                            @"uid" : [[[AccountManager sharedAccountManager] getCurrentUser] uid],
                                            @"id" : self._id,
                                            @"name" : self.name,
                                            @"address" : self.address,
                                            @"zipcode" : self.zipcode,
                                            @"mobile" : self.mobile
                                            }];
}

@end
