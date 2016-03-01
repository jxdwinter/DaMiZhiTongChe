//
//  SharedDatabaseHelper.m
//  TangPassport
//
//  Created by Xiaodong Jiang on 7/21/15.
//  Copyright (c) 2015 黑龙江龙卫中新医药连锁有限公司. All rights reserved.
//

#import "SharedDatabaseHelper.h"
#import <YTKKeyValueStore.h>

@implementation SharedDatabaseHelper

static SharedDatabaseHelper* sharedDatabaseHelper = nil;

+ (instancetype) sharedDatabaseHelper{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        sharedDatabaseHelper = [[self alloc] init] ;
    }) ;
    return sharedDatabaseHelper ;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        /**
         初始化数据库
         */
        YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:DATABASENAME];
        /**
         *  当前登录用户
         */
        [store createTableWithName:CURRENTUSERTALBE];

    }
    return self;
}

- (void)clearAllCurrentUserDatabase{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:DATABASENAME];
}

@end
