//
//  UploadManager.m
//  TangPassport
//
//  Created by Xiaodong Jiang on 8/19/15.
//  Copyright (c) 2015 黑龙江龙卫中新医药连锁有限公司. All rights reserved.
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
