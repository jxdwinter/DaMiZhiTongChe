//
//  SetPasswordViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 2/29/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "Signup_registerApi.h"
#import "Login_resetPasswordApi.h"

@interface SetPasswordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
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

- (void) backToPreViewController {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) popToRootViewController {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) confirm {
    if ([VerifyTools verifyPassword:self.passwordTextField.text]) {
        //注册设置密码
        if (self.setPasswordType == 0) {
            Signup_registerApi *api = [[Signup_registerApi alloc] initWithPhone:self.phone withPassword:self.passwordTextField.text];
            RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
            [api addAccessory:accessory];
            [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
                NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
                if (dic) {
                    if ([dic[@"result"] isEqualToString:@"0"]) {
                        [MBProgressHUD showHUDwithSuccess:YES WithTitle:@"注册成功" withView:self.navigationController.view];
                        [AccountHelper saveAccountInfoWithPhone:self.phone];
                        AccountManager *accountManager = [AccountManager sharedAccountManager];
                        [accountManager setCurrentUser:dic[@"data"]];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"USERLOGIN" object:nil];
                        [self performSelector:@selector(backToPreViewController) withObject:nil afterDelay:1.5];
                    }else{
                        [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
                    }
                }
            } failure:^(YTKBaseRequest *request) {
                
            }];
        }
        //重置密码
        else if (self.setPasswordType == 1){
            Login_resetPasswordApi *api = [[Login_resetPasswordApi alloc] initWithPhone:self.phone withPassword:self.passwordTextField.text];
            RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
            [api addAccessory:accessory];
            [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
                NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
                if (dic) {
                    if ([dic[@"result"] isEqualToString:@"0"]) {
                        [MBProgressHUD showHUDwithSuccess:YES WithTitle:@"修改成功,请重新登录" withView:self.navigationController.view];
                        [self performSelector:@selector(popToRootViewController) withObject:nil afterDelay:1.5];
                    }else{
                        [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
                    }
                }
            } failure:^(YTKBaseRequest *request) {
                
            }];
        }
    }else{
        [MBProgressHUD showHUDwithSuccess:NO WithTitle:@"请正确填写6~16位密码" withView:self.navigationController.view];
    }
}

- (void) changeSignupButtonStatus {
    if (self.confirmButton.isEnabled) {
        self.confirmButton.enabled = NO;
        self.confirmButton.backgroundColor = DEFAULTGRAYCOLOR;
    }else{
        self.confirmButton.enabled = YES;
        self.confirmButton.backgroundColor = DEFAULTBROWNCOLOR;
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
