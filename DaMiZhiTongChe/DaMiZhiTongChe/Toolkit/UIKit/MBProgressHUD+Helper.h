//
//  MBProgressHUD+Helper.h
//  TangPassport
//
//  Created by Xiaodong Jiang on 7/31/15.
//  Copyright (c) 2015 黑龙江龙卫中新医药连锁有限公司. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Helper)

+ (void) showHUDwithSuccess : (BOOL) success WithTitle : (NSString *) title withView : (UIView *)view;
+ (void) showHUDWhileNetworkWithView : (UIView *) view;
+ (void) hideHUDWhenNetworkFinishedFromView : (UIView *)view;

@end
