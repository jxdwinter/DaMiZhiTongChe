//
//  Config.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 7/15/15.
//  Copyright (c) 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject

/**
 *  BugHD General Key
 */
extern NSString *const BUGHDGENERALKEY;

/**
 *  MTA APP KEY
 */
extern NSString *const MTAAPPKEY;

/**
 *  数据库名
 */
extern NSString *const DATABASENAME;

/**
 *  URL
 */
extern NSString *const BASEURL;

/**
 *  每一页的数量,用于翻页
 */
extern NSInteger const PAGENUMBER;



extern NSString *const AVATARSCOPENAME;


extern NSString *const AVATARURL;


@end
