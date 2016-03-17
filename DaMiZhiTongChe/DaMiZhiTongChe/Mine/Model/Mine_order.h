//
//  Mine_order.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/17/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mine_order : NSObject

@property (nonatomic, copy) NSString *order_sn;
@property (nonatomic, strong) NSArray *enterprise;

- (instancetype) initWithOrderInfo : (NSDictionary *) orderInfo;

@end
