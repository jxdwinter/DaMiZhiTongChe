//
//  Cart_orderApi.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/11/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "ConfigYTKRequest.h"

@interface Cart_orderApi : ConfigYTKRequest

- (instancetype) initWithPay_id : (NSString *) pay_id withGoods : (NSString *) goods withAddress_id : (NSString *) address_id;

@end
