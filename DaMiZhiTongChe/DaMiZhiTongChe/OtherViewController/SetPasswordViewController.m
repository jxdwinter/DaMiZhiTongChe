//
//  SetPasswordViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 2/29/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "SetPasswordViewController.h"

@interface SetPasswordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.setPasswordType == 0) {
        self.title = @"设置密码";
    }else if (self.setPasswordType == 1){
        self.title = @"重设密码";
    }
    
    [self.view addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(50.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@30.0);
    }];
    
    UIImageView *lineImageView = [[UIImageView alloc] init];
    lineImageView.backgroundColor = DEFAULTGRAYCOLOR;
    [self.view addSubview:lineImageView];
    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(5.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@.5);
    }];
    
    [self.view addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_4_OR_LESS) {
            make.top.equalTo(lineImageView.mas_bottom).with.offset(20.0);
        } else if (IS_IPHONE_5) {
            make.top.equalTo(lineImageView.mas_bottom).with.offset(40.0);
        } else if (IS_IPHONE_6) {
            make.top.equalTo(lineImageView.mas_bottom).with.offset(50.0);
        } else if ( IS_IPHONE_6P ){
            make.top.equalTo(lineImageView.mas_bottom).with.offset(50.0);
        }
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@44.0);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - privete method

- (void) confirm {
    if (self.setPasswordType == 0) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else if (self.setPasswordType == 1){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - getter and setter

- (UITextField *) passwordTextField{
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.delegate = self;
        _passwordTextField.keyboardType = UIKeyboardTypeDefault;
        _passwordTextField.font = DEFAULFONT;
        _passwordTextField.textColor = DEFAULTBROWNCOLOR;
        [_passwordTextField setTintColor:DEFAULTBROWNCOLOR];
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请设置6~16位密码" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
        [_passwordTextField becomeFirstResponder];
    }
    return _passwordTextField;
}

- (UIButton *) confirmButton {
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] init];
        [_confirmButton.layer setMasksToBounds:YES];
        [_confirmButton.layer setCornerRadius:2.0];
        [_confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.titleLabel.font = DEFAULFONT;
        _confirmButton.backgroundColor = DEFAULTBROWNCOLOR;
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    }
    return _confirmButton;
}

@end
