//
//  ConfigYTKRequest.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 8/6/15.
//  Copyright (c) 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "ConfigYTKRequest.h"

@implementation ConfigYTKRequest

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)responseDictionaryWithResponseString : (NSString *) responseString{
    return [ConfigArgument decode:responseString];
}

@end
