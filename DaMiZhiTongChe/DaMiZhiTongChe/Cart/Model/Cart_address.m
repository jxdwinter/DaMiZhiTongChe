//
//  Cart_address.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/15/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Cart_address.h"

@implementation Cart_address

- (instancetype) initWithCart_addressInfo : (NSDictionary *) cart_addressInfo {
    self = [super init];
    if (self) {
        self._id = cart_addressInfo[@"id"];
        self.name = cart_addressInfo[@"name"];
        self.address = cart_addressInfo[@"address"];
        self.zipcode = cart_addressInfo[@"zipcode"];
        self.mobile = cart_addressInfo[@"mobile"];
        self.flag = cart_addressInfo[@"flag"];
    }
    return self;
}

@end
