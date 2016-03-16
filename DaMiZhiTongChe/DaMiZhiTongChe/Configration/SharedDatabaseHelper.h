//
//  SharedDatabaseHelper.h
//  TangPassport
//
//  Created by Xiaodong Jiang on 7/21/15.
//  Copyright (c) 2015 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CURRENTUSERTALBE @"currentUserTalbe"

@interface SharedDatabaseHelper : NSObject

+ (instancetype) sharedDatabaseHelper;

/**
 *  清理和当前用户相关的数据表
 */
- (void) clearAllCurrentUserDatabase;

@end
