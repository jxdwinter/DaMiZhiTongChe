//
//  Cart_AddAddressApi.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/15/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "ConfigYTKRequest.h"

@interface Cart_AddAddressApi : ConfigYTKRequest

- (instancetype) initWithName : (NSString *) name withAddress : (NSString *) address withZipcode : (NSString *) zipcode withMobile : (NSString *) mobile;

@end
