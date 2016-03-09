//
//  User.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/1/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
/*
 *username: "手机号",
 password: "密码(md5加密)",
 nickname: "昵称",
 realname: "真实姓名",
 headimg: "头像地址",
 */
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *headimg;

- (instancetype) initWithUserInfomation : (NSDictionary *) userInfo;

@end
