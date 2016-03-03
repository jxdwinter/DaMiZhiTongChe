//
//  DatabaseHelper.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/3/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "DatabaseHelper.h"

@implementation DatabaseHelper

- (YTKKeyValueStore *) store {
    return [[YTKKeyValueStore alloc] initDBWithName:DATABASENAME];
}

@end
