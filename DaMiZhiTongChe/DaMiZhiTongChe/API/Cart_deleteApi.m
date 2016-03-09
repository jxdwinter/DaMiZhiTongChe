//
//  Cart_deleteApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/9/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Cart_deleteApi.h"
#import "User.h"

@interface Cart_deleteApi ()

@property (nonatomic, copy) NSString *goods_id;

@end

@implementation Cart_deleteApi

- (instancetype) initWithGoods_id:(NSString *)goods_id {
    self = [super init];
    if (self) {
        self.goods_id = goods_id;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/Cart";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"delete",
                                            @"uid" : [[[AccountManager sharedAccountManager] getCurrentUser] uid],
                                            @"goods_id" : self.goods_id
                                            }];
}

@end
