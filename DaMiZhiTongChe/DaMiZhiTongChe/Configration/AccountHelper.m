//
//  AccountHelper.m
//  TangPassport
//
//  Created by Xiaodong Jiang on 8/7/15.
//  Copyright (c) 2015 黑龙江龙卫中新医药连锁有限公司. All rights reserved.
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

+ (void) saveAccountInfoWithPhone : (NSString *) phone withPassword : (NSString *) password{
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) deleteAccountInfo{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) accountToken{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"token"]?[[NSUserDefaults standardUserDefaults] stringForKey:@"token"]:@"0";
}

+ (NSString *) accountInfoPhone{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"phone"];
}

+ (NSString *) accountInfoPassword{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
}

+ (void) updateAccountPhone : (NSString *) phone{
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) updateAccountPassword : (NSString *) password{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
