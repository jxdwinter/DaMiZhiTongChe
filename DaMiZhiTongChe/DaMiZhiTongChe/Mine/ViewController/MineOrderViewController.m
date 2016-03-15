//
//  MineOrderViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/15/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "MineOrderViewController.h"
#import "MineOrderUnPayedViewController.h"
#import "MineOrderPayedViewController.h"
#import "MineOrderSentViewController.h"
#import "MineOrderReceivedViewController.h"

@interface MineOrderViewController ()

@property (nonatomic, strong) WMPageController *pageViewController;

@end

@implementation MineOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    self.title = @"我的订单";
    [self configController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configController{
    NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithCapacity:1];
    NSMutableArray *titles = [[NSMutableArray alloc] initWithCapacity:1];
    [viewControllers addObject:[MineOrderUnPayedViewController class]];
    [titles addObject:@"未付款"];
    [viewControllers addObject:[MineOrderPayedViewController class]];
    [titles addObject:@"已付款"];
    [viewControllers addObject:[MineOrderSentViewController class]];
    [titles addObject:@"已发货"];
    [viewControllers addObject:[MineOrderReceivedViewController class]];
    [titles addObject:@"已收货"];
    self.pageViewController = [[WMPageController alloc] initWithViewControllerClasses:viewControllers
                                                                       andTheirTitles:titles];
    self.pageViewController.menuViewStyle = WMMenuViewStyleLine;
    self.pageViewController.pageAnimatable = YES;
    self.pageViewController.menuItemWidth = 85;
    self.pageViewController.titleColorSelected = DEFAULTBROWNCOLOR;
    self.pageViewController.titleColorNormal = DEFAULTTEXTCOLOR;
    self.pageViewController.titleSizeNormal = 10;
    self.pageViewController.titleSizeSelected = 14;
    self.pageViewController.menuHeight = 40;
    self.pageViewController.menuBGColor = DEFAULTLIGHTGRAYCOLOR;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    if (self.selectIndex) {
        self.pageViewController.selectIndex = self.selectIndex;
    }
}

@end
