//
//  AccountHelper.h
//  TangPassport
//
//  Created by Xiaodong Jiang on 8/7/15.
//  Copyright (c) 2015 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountHelper : NSObject

+ (void) saveAccountTokenWithToken : (NSString *) token;
+ (void) saveAccountInfoWithPhone : (NSString *) phone;
+ (void) deleteAccountInfo;
+ (NSString *) accountToken;
+ (NSString *) accountInfoPhone;
+ (void) updateAccountPhone : (NSString *) phone;

@end
