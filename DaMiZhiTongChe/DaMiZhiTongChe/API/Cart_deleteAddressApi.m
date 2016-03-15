//
//  Cart_deleteAddressApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/15/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Cart_deleteAddressApi.h"
#import "User.h"

@interface Cart_deleteAddressApi ()

@property (nonatomic, copy) NSString *_id;

@end

@implementation Cart_deleteAddressApi

- (instancetype) initWithId : (NSString *) _id {
    self = [super init];
    if (self) {
        self._id = _id;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/Address";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"deleteAddress",
                                            @"uid" : [[[AccountManager sharedAccountManager] getCurrentUser] uid],
                                            @"id" : self._id
                                            }];
}

@end
