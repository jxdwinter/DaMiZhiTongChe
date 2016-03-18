//
//  Cart_confirmReceiptApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/18/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Cart_confirmReceiptApi.h"
#import "User.h"

@interface Cart_confirmReceiptApi ()

@property (nonatomic, copy) NSString *order_sn;
@property (nonatomic, copy) NSString *ent_id;

@end

@implementation Cart_confirmReceiptApi

- (instancetype) initWithOrder_sn : (NSString *) order_sn withEnt_id : (NSString *) ent_id {
    self = [super init];
    if (self) {
        self.order_sn = order_sn;
        self.ent_id = ent_id;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/Cart";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"confirmReceipt",
                                            @"uid" : [[[AccountManager sharedAccountManager] getCurrentUser] uid],
                                            @"order_sn" : self.order_sn,
                                            @"ent_id_string" : self.ent_id
                                            }];
}

@end
