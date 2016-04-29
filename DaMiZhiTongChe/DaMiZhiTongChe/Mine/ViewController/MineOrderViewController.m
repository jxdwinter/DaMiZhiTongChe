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

@interface MineOrderViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) WMPageController *pageViewController;

@end

@implementation MineOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:@"ORDERSUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail) name:@"ORDERFAIL" object:nil];
    self.title = @"我的订单";
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.backBarButtonItem.title = @"";
    [self configController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 - (void) viewDidAppear:(BOOL)animated {
     [super viewDidAppear:animated];
 }
 
 - (void) viewWillDisappear:(BOOL)animated {
     [super viewWillDisappear:animated];
 }

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ORDERSUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ORDERFAIL" object:nil];
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
    self.pageViewController.edgesForExtendedLayout = UIRectEdgeNone;
    self.pageViewController.menuViewStyle = WMMenuViewStyleLine;
    self.pageViewController.pageAnimatable = YES;
    self.pageViewController.menuItemWidth = 85;
    self.pageViewController.titleColorSelected = DEFAULTBROWNCOLOR;
    self.pageViewController.titleColorNormal = DEFAULTTEXTCOLOR;
    self.pageViewController.titleSizeNormal = 10;
    self.pageViewController.titleSizeSelected = 14;
    self.pageViewController.menuHeight = 40;
    self.pageViewController.menuBGColor = DEFAULTLIGHTGRAYCOLOR;
    if (self.selectIndex) {
        self.pageViewController.selectIndex = self.selectIndex;
    }
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

- (void) payFail {
    self.pageViewController.selectIndex = 0;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UNPAYEDRELOAD" object:nil];
}

- (void) paySuccess {
    self.pageViewController.selectIndex = 1;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UNPAYEDRELOAD" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PAYEDRELOAD" object:nil];
}

- (void) popToPreViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter and setter

- (UIButton *) backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
        [_backButton addTarget:self action:@selector(popToPreViewController) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setImage:[UIImage imageNamed:@"main_back"] forState:UIControlStateNormal];
    }
    return _backButton;
}

@end
