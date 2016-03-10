//
//  CartAddressListViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/10/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "CartAddressListViewController.h"

@interface CartAddressListViewController ()

@property (nonatomic, strong) UIButton *addButton;

@end

@implementation CartAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    self.title = @"收货地址";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.addButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - privete method

- (void) addAddress {
    
}

#pragma mark - getter and setter

- (UIButton *) addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
        [_addButton addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
        [_addButton setImage:[UIImage imageNamed:@"cart_add"] forState:UIControlStateNormal];
    }
    return _addButton;
}

@end
