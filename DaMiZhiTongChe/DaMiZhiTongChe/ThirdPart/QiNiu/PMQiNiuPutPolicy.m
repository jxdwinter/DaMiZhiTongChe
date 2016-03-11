//
//  PMQiNiuPutPolicy.m
//  push2
//
//  Created by Liu_Sijia on 14-07-29.
//  Copyright (c) 2014年 北京睿智开元科技有限公司. All rights reserved.
//

#import "PMQiNiuPutPolicy.h"

@implementation PMQiNiuPutPolicy

/** 必选。可以是 bucketName 或者 bucketName:key */
@synthesize scope;
/** 必选。 */
@synthesize deadline;

/**
 * 转码队列名，须预先开通
 * 资源上传成功后，触发转码时指定独立的队列进行转码
 */
@synthesize persistentPipeline;


#pragma mark - init

- (id)initWithScopeName:(NSString *)scopeName{
    self = [super init];
    if (self){
        scope = scopeName;
        deadline=([[NSDate date] timeIntervalSince1970])+3600;
    }
    return self;
}


#pragma mark - JSON

/**
 *  生成JSON串
 *
 *  @return 生成的JSON串
 */
- (NSString *)toJson
{
    /**/
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:scope forKey:@"scope"];
    [dictionary setObject:[NSString stringWithFormat:@"%ld",deadline] forKey:@"deadline"];
    /**/
    if ([NSJSONSerialization isValidJSONObject:dictionary]){
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        if ([jsonData length] > 0 && error == nil){
            NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            return json;
        }else{
            NSLog(@"PMResponseEntity.toJson:NULL");
            return nil;
        }
    }
    return nil;
}



@end
