//
//  PMHmacSha1.h
//  push2
//
//  Created by Liu_Sijia on 14-07-29.
//  Copyright (c) 2014年 北京睿智开元科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMHmacSha1 : NSObject

+ (NSString *)hmacsha1:(NSString *)data secret:(NSString *)key;

@end
