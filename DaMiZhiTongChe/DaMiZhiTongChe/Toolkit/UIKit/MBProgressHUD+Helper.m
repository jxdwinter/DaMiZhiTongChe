//
//  MBProgressHUD+Helper.m
//  TangPassport
//
//  Created by Xiaodong Jiang on 7/31/15.
//  Copyright (c) 2015 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#define HUDCOLOR [UIColor colorWithRed:(71/255.0) green:(179/255.0) blue:(155/255.0) alpha:.8]

#import "MBProgressHUD+Helper.h"

@implementation MBProgressHUD (Helper)

+ (void) showHUDwithSuccess : (BOOL) success WithTitle : (NSString *) title withView : (UIView *)view{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view?view:[[UIApplication sharedApplication] keyWindow]];
    [view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] init];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = title;
    [HUD show:YES];
    double delayInSeconds = 0.8;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
    });
}

+ (void) showHUDWhileNetworkWithView : (UIView *) view{
    if (view) {
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:HUD];
        [HUD show:YES];
    }else{
        [MBProgressHUD  showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    }
}

+ (void) hideHUDWhenNetworkFinishedFromView : (UIView *)view{
    if (view) {
        [MBProgressHUD hideHUDForView:view animated:YES];
    }else{
        [MBProgressHUD hideAllHUDsForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
    }
}

@end
