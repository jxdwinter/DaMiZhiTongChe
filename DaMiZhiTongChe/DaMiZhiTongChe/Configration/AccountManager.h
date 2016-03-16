//
//  AccountManager.h
//  TangPassport
//
//  Created by Xiaodong Jiang on 7/16/15.
//  Copyright (c) 2015 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

/**
 *  单例,当前登录用户管理类,用来获取本地存储的当前登录用户的信息,状态等...
 */
@interface AccountManager : NSObject

@property (nonatomic, strong) User *user;

+ (instancetype)sharedAccountManager;

/**
 *  设置当前登录用户
 *
 *  @param user 当前用户
 */
- (void) setCurrentUser : (NSDictionary *) userInfo;

/**
 *  获取当前登录用户
 *
 */
- (User *) getCurrentUser;

/**
 *  当前用户登出
 */
- (void) userLogout;

/**
 *  修改当前用户属性
 *
 *  @param updateUserInfo 需要修改的用户属性
 */
- (void) updateCurrentUserInfoWithDictionary : (NSDictionary *) updateUserInfo;

@end
