//
//  Cart_deleteApi.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/9/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "ConfigYTKRequest.h"

@interface Cart_deleteApi : ConfigYTKRequest

- (instancetype) initWithGoods_id : (NSString *) goods_id;

@end
