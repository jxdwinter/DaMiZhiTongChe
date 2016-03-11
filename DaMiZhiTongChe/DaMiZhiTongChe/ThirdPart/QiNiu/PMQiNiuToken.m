//
//  PMQiNiuToken.m
//  push2
//
//  Created by Liu_Sijia on 14-07-29.
//  Copyright (c) 2014年 北京睿智开元科技有限公司. All rights reserved.
//

#import "PMQiNiuToken.h"
#import "PMQiNiuPutPolicy.h"
#import "PMHmacSha1.h"
#import "MF_Base64Additions.h"

@implementation PMQiNiuToken


+ (NSString *)getAccessKey{
    return @"q8_ngiKiD0uT9e-D9rh7GIVOsDRT_JwDg7GniOy3";
}

+ (NSString *)getSecretKey{
    return @"KawXxDRKbrlpMZwiE8hf0vzlATp-Xdb3Gbm4WutT";
}

+ (NSString *)generateUploadTokenWithScopeName:(NSString *)scopeName{
    /* putPolicyJson */
    PMQiNiuPutPolicy *putPolicy = [[PMQiNiuPutPolicy alloc] initWithScopeName:scopeName];
    NSString *putPolicyJson = [putPolicy toJson];
    putPolicyJson=[NSString stringWithFormat:@"{\"scope\":\"%@\",\"deadline\":%ld}",putPolicy.scope,putPolicy.deadline];
    NSLog(@"putPolicyJson=%@",putPolicyJson);
    
    /* putPolicyBase64 */
    NSString *putPolicyBase64 = [putPolicyJson base64String];
    //NSLog(@"putPolicyBase64=%@",putPolicyBase64);
    
    /**/
    NSString *encodedPutPolicy = [putPolicyBase64 stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    encodedPutPolicy = [encodedPutPolicy stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    //NSLog(@"encodedPutPolicy=%@",encodedPutPolicy);
    //
    NSString *sign = [PMHmacSha1 hmacsha1:encodedPutPolicy secret:[self getSecretKey]];
    //NSLog(@"sign=%@",sign);
    NSString *encodedSign = [sign stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    encodedSign = [encodedSign stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    //NSLog(@"encodedSign=%@",encodedSign);
    //
    NSString *uploadToken = [NSString stringWithFormat:@"%@:%@:%@",[self getAccessKey],encodedSign,encodedPutPolicy];
    NSLog(@"uploadToken=%@",uploadToken);
    return uploadToken;
}

@end
