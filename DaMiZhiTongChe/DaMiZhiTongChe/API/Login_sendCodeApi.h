//
//  Login_sendCodeApi.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/1/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "ConfigYTKRequest.h"

/*
 *发送验证码
 */

@interface Login_sendCodeApi : ConfigYTKRequest

- (instancetype) initWithPhone : (NSString *) phone withType : (NSString *) type;

@end
