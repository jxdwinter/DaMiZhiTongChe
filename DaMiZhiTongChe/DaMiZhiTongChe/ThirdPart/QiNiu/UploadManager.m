//
//  UploadManager.m
//  TangPassport
//
//  Created by Xiaodong Jiang on 8/19/15.
//  Copyright (c) 2015 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "UploadManager.h"

@implementation UploadManager

+ (instancetype) sharedUploadManager{
    static dispatch_once_t onceToken;
    static UploadManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[UploadManager alloc]init];
    });
    return manager;
}

@end
