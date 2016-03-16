//
//  AccountHelper.m
//  TangPassport
//
//  Created by Xiaodong Jiang on 8/7/15.
//  Copyright (c) 2015 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "AccountHelper.h"

@implementation AccountHelper

+ (void) saveAccountTokenWithToken : (NSString *) token{
    if (!token || token.length == 0) {
        token = @"0";
    }
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) saveAccountInfoWithPhone : (NSString *) phone {
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) deleteAccountInfo{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) accountToken{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"token"]?[[NSUserDefaults standardUserDefaults] stringForKey:@"token"]:@"0";
}

+ (NSString *) accountInfoPhone{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"phone"];
}

+ (void) updateAccountPhone : (NSString *) phone{
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
