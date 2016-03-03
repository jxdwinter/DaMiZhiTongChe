//
//  MainViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 2/23/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "MainViewController.h"
#import "Main_homeApi.h"

@interface MainViewController ()<UISearchBarDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation MainViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_navigationbar_blank"]]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_navigationbar_blank"]]];
    
    self.navigationItem.titleView = self.searchBar;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(dismissKeyboard)];
    tapGesture.numberOfTapsRequired = 1;
    [tapGesture setDelegate:self];
    [self.view addGestureRecognizer:tapGesture];
}

- (void) viewDidAppear:(BOOL)animated {
    [self.searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - searchBar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    
}

#pragma mark - privete method

- (void) dismissKeyboard {
    [self.searchBar resignFirstResponder];
}

#pragma mark - getter and setter

- (UISearchBar *) searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
        [_searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"main_navigationbar_searchbar"]forState:UIControlStateNormal];
        _searchBar.placeholder = @"搜索好大米";
        _searchBar.delegate = self;
        [_searchBar sizeToFit];
        _searchBar.barTintColor = DEFAULTCOLOR;
        _searchBar.tintColor = DEFAULTCOLOR;
        UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
        searchField.textColor = DEFAULTBROWNCOLOR;
        [searchField setValue:DEFAULTBROWNCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        [_searchBar sizeToFit];
    }
    return _searchBar;
}

@end
