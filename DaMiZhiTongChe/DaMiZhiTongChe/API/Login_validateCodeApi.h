//
//  Login_validateCodeApi.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/2/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "ConfigYTKRequest.h"


/*
 *验证码验证
 */

@interface Login_validateCodeApi : ConfigYTKRequest

- (instancetype) initWithPhone : (NSString *) phone withCode : (NSString *) code withType : (NSString *) type;

@end
