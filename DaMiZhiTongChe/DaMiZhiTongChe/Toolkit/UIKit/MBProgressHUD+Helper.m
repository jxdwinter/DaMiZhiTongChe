//
//  MBProgressHUD+Helper.m
//  TangPassport
//
//  Created by Xiaodong Jiang on 7/31/15.
//  Copyright (c) 2015 黑龙江龙卫中新医药连锁有限公司. All rights reserved.
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
    [HUD hide:YES afterDelay:2.0];
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
