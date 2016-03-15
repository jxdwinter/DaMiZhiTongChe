//
//  Cart_modifyDefaultAddressApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/15/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Cart_modifyDefaultAddressApi.h"
#import "User.h"

@interface Cart_modifyDefaultAddressApi ()

@property (nonatomic, copy) NSString *_id;

@end

@implementation Cart_modifyDefaultAddressApi

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
                                            @"action" : @"modifyDefaultAddress",
                                            @"uid" : [[[AccountManager sharedAccountManager] getCurrentUser] uid],
                                            @"id" : self._id
                                            }];
}

@end
