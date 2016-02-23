//
//  ConfigArgument.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 8/4/15.
//  Copyright (c) 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigArgument : NSObject

+ (NSDictionary *) configArgument : (NSDictionary *) dictionary;
+ (NSDictionary *) decode : (NSString *) response;

@end
