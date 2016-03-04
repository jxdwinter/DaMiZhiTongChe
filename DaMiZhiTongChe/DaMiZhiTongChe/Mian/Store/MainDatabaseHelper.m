//
//  MainDatabaseHelper.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/3/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "MainDatabaseHelper.h"

@implementation MainDatabaseHelper

+ (instancetype)sharedMainDatabaseHelper{
    static dispatch_once_t onceToken;
    static MainDatabaseHelper *helper;
    dispatch_once(&onceToken, ^{
        helper = [[MainDatabaseHelper alloc]init];
    });
    return helper;
}

- (void) saveMainDataWithDictionary : (NSDictionary *) dictionary {
    [[self store] putObject:dictionary withId:@"data" intoTable:MAINDATATALBE];
}

- (NSDictionary *) queryMainData {
    NSArray *array = [[self store] getAllItemsFromTable:MAINDATATALBE];
    YTKKeyValueItem *item = [array lastObject];
    return item.itemObject;
}

- (void) deleteMainData {
    [[self store] clearTable:MAINDATATALBE];
}

@end
