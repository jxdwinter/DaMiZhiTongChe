//
//  Login_loginApi.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/2/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "ConfigYTKRequest.h"

@interface Login_loginApi : ConfigYTKRequest

- (instancetype) initWithPhone : (NSString *) phone withPassword : (NSString *) password;

@end
