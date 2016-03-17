//
//  WebViewController.h
//  TangPassport
//
//  Created by Xiaodong Jiang on 8/11/15.
//  Copyright (c) 2015 黑龙江龙卫中新医药连锁有限公司. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *htmlString;

@end
