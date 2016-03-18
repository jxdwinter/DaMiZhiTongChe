//
//  Cart_confirmReceiptApi.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/18/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "ConfigYTKRequest.h"

@interface Cart_confirmReceiptApi : ConfigYTKRequest

- (instancetype) initWithOrder_sn : (NSString *) order_sn withEnt_id : (NSString *) ent_id;

@end
