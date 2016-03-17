//
//  Mine_getOrderListApi.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/17/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "ConfigYTKRequest.h"

@interface Mine_getOrderListApi : ConfigYTKRequest

@property (nonatomic,copy) NSString *order_status;

- (instancetype) initWithOrder_status : (NSString *) order_status;

@end
