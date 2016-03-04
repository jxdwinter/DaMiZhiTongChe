//
//  MainDatabaseHelper.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/3/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainDatabaseHelper : DatabaseHelper

+ (instancetype)sharedMainDatabaseHelper;

- (void) saveMainDataWithDictionary : (NSDictionary *) dictionary;
- (NSDictionary *) queryMainData;
- (void) deleteMainData;

@end
