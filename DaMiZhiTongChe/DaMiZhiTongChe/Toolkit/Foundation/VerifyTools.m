//
//  VerifyTools.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/1/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "VerifyTools.h"

@implementation VerifyTools

+ (BOOL) verifyPhoneNumber : (NSString *) phoneNumber{
    NSString *pattern = @"^1+[34578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:phoneNumber];
}

+ (BOOL) verifyVerityCode : (NSString *) verityCode{
    NSString *pattern = @"^[0-9]{6}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:verityCode];
}

@end
