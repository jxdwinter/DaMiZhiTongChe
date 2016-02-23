//
//  ConfigArgument.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 8/4/15.
//  Copyright (c) 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "ConfigArgument.h"
#import "AESenAndDe.h"

@implementation ConfigArgument

+ (NSDictionary *) configArgument : (NSDictionary *) dictionary{
    if (dictionary) {
        NSString *jsonString = nil;
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                           options:0
                                                             error:&error];
        if (!error) {
            if (jsonData){
                jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
            }
            NSString *str_64 = [AESenAndDe En_AESandBase64EnToString:jsonString];
            return @{@"para": str_64};
        }
    }
    return nil;
}

+ (NSDictionary *) decode : (NSString *) response{
    return [AESenAndDe De_Base64andAESToDictionary:response];
}

@end
