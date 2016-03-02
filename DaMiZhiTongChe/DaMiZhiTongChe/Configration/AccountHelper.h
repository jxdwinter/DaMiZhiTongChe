//
//  AccountHelper.h
//  TangPassport
//
//  Created by Xiaodong Jiang on 8/7/15.
//  Copyright (c) 2015 黑龙江龙卫中新医药连锁有限公司. All rights reserved.
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
