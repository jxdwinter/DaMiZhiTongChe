//
//  RequestAccessory.m
//  TangPassport
//
//  Created by Xiaodong Jiang on 8/6/15.
//  Copyright (c) 2015 黑龙江龙卫中新医药连锁有限公司. All rights reserved.
//

#import "RequestAccessory.h"

@implementation RequestAccessory

- (void)requestWillStart:(id)request{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [MBProgressHUD showHUDWhileNetworkWithView:self.view];
}

- (void)requestWillStop:(id)request{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [MBProgressHUD hideHUDWhenNetworkFinishedFromView:self.view];
}

- (void)requestDidStop:(id)request{
    
}

- (instancetype) initAccessoryWithView : (UIView *)view{
    self = [super init];
    if (self) {
        self.view = view;
    }
    return self;
}


@end
