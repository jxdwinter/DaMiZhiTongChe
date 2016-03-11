//
//  PMHmacSha1.m
//  push2
//
//  Created by Liu_Sijia on 14-07-29.
//  Copyright (c) 2014年 北京睿智开元科技有限公司. All rights reserved.
//

#import "PMHmacSha1.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#import "MF_Base64Additions.h"

@implementation PMHmacSha1

+ (NSString *)hmacsha1:(NSString *)data secret:(NSString *)key{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    NSString *hash = [HMAC base64String];
    return hash;
}

@end
