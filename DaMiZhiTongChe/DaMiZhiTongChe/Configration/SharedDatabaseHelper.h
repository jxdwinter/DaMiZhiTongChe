//
//  SharedDatabaseHelper.h
//  TangPassport
//
//  Created by Xiaodong Jiang on 7/21/15.
//  Copyright (c) 2015 黑龙江龙卫中新医药连锁有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CURRENTUSERTALBE @"currentUserTalbe"
#define MAINDATATALBE @"mainDataTalbe"

@interface SharedDatabaseHelper : NSObject

+ (instancetype) sharedDatabaseHelper;

/**
 *  清理和当前用户相关的数据表
 */
- (void) clearAllCurrentUserDatabase;

@end
