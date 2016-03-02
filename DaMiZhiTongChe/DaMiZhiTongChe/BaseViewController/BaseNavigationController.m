//
//  BaseNavigationController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 7/15/15.
//  Copyright (c) 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  Override
 *
 *  @param viewController <#viewController description#>
 *  @param animated       <#animated description#>
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
