//
//  VerifyTools.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/1/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerifyTools : NSObject

/*
 *验证手机号码
 */
+ (BOOL) verifyPhoneNumber : (NSString *) phoneNumber;

/*
 *验证六位数字验证码
 */
+ (BOOL) verifyVerityCode : (NSString *) verityCode;

@end
