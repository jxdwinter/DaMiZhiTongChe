//
//  PMQiNiuPutPolicy.h
//  push2
//
//  Created by Liu_Sijia on 14-07-29.
//  Copyright (c) 2014年 北京睿智开元科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMQiNiuPutPolicy : NSObject

/** 必选。可以是 bucketName 或者 bucketName:key */
@property (nonatomic,strong) NSString *scope;
/** 必选。 */
@property (nonatomic) long deadline;

/**
 * 转码队列名，须预先开通
 * 资源上传成功后，触发转码时指定独立的队列进行转码
 */
@property (nonatomic,strong) NSString *persistentPipeline;


- (id)initWithScopeName:(NSString *)scopeName;

#pragma mark - JSON
- (NSString *)toJson;

@end
