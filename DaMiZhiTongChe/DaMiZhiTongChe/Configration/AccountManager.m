//
//  AccountManager.m
//  TangPassport
//
//  Created by Xiaodong Jiang on 7/16/15.
//  Copyright (c) 2015 黑龙江龙卫中新医药连锁有限公司. All rights reserved.
//

#import "AccountManager.h"
#import "User.h"
#import <YTKKeyValueStore.h>

@implementation AccountManager

+ (instancetype)sharedAccountManager{
    static dispatch_once_t onceToken;
    static AccountManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[AccountManager alloc]init];
    });
    return manager;
}

- (void)setCurrentUser:(NSDictionary *)userInfo{
    [self clear];
    self.user = [[User alloc] initWithUserInfomation:userInfo];
    [[self store] putObject:userInfo withId:userInfo[@"username"] intoTable:CURRENTUSERTALBE];
}

- (User *) getCurrentUser{
    if (self.user) {
        return self.user;
    }else{
        NSArray *array = [[self store] getAllItemsFromTable:CURRENTUSERTALBE];
        if (array && [array count]) {
            YTKKeyValueItem *item = [array lastObject];
            User *user = [[User alloc] initWithUserInfomation:item.itemObject];
            if (user) {
                self.user = user;
                return user;
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }
}

- (void)clear{
    [[self store] clearTable:CURRENTUSERTALBE];
}

- (void) userLogout {
    [self clear];
    self.user = nil;
    [AccountHelper deleteAccountInfo];
    [[SharedDatabaseHelper sharedDatabaseHelper] clearAllCurrentUserDatabase];
}

- (void) updateCurrentUserInfoWithDictionary : (NSDictionary *) updateUserInfo{
    NSArray *array = [[self store] getAllItemsFromTable:CURRENTUSERTALBE];
    NSMutableDictionary *dic = [[[array lastObject] itemObject] mutableCopy];
    for (NSString *key in [updateUserInfo allKeys]) {
        [dic setValue:updateUserInfo[key] forKey:key];
    }
    self.user = nil;
    [self setCurrentUser:[dic copy]];
}

- (YTKKeyValueStore *) store{
    return [[YTKKeyValueStore alloc] initDBWithName:DATABASENAME];
}

@end
