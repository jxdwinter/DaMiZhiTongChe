//
//  Cart_getOrderAddressApi.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/18/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "ConfigYTKRequest.h"

@interface Cart_getOrderAddressApi : ConfigYTKRequest

- (instancetype) initWithOrder_sn : (NSString *) order_sn;

@end
