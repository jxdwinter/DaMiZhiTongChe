//
//  LoginViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 2/24/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () <UITextFieldDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIImageView *phoneTextFieldBackgroundImageView;
@property (nonatomic, strong) UIImageView *passwordTextFieldBackgroundImageView;
@property (nonatomic, strong) UIImageView *phoneImageView;
@property (nonatomic, strong) UIImageView *passwordImageView;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIImageView *forgetPasswordImageView;
@property (nonatomic, strong) UIButton *forgetPasswordButton;
@property (nonatomic, strong) UIButton *signupButton;

@end

@implementation LoginViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];

    [self.view addSubview:self.backgroundImageView];
    
    [self.backgroundImageView addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-10.0);
        make.width.equalTo(@25.0);
        make.height.equalTo(@25.0);
    }];
    
    [self.backgroundImageView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(100.0);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@120.0);
        make.height.equalTo(@120.0);
    }];
    
    [self.backgroundImageView addSubview:self.phoneTextFieldBackgroundImageView];
    [self.phoneTextFieldBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).with.offset(100.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@44.0);
    }];
    
    [self.phoneTextFieldBackgroundImageView addSubview:self.phoneImageView];
    [self.phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextFieldBackgroundImageView.mas_top).with.offset(12.0);
        make.left.equalTo(self.phoneTextFieldBackgroundImageView.mas_left).with.offset(12.0);
        make.width.equalTo(@20.0);
        make.height.equalTo(@20.0);
    }];
    
    [self.phoneTextFieldBackgroundImageView addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextFieldBackgroundImageView.mas_top).with.offset(7.0);
        make.left.equalTo(self.phoneImageView.mas_right).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-30.0);
        make.height.equalTo(@30.0);
    }];
    
    [self.backgroundImageView addSubview:self.passwordTextFieldBackgroundImageView];
    [self.passwordTextFieldBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextFieldBackgroundImageView.mas_bottom).with.offset(2.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@44.0);
    }];
    
    [self.passwordTextFieldBackgroundImageView addSubview:self.passwordImageView];
    [self.passwordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextFieldBackgroundImageView.mas_top).with.offset(12.0);
        make.left.equalTo(self.passwordTextFieldBackgroundImageView.mas_left).with.offset(12.0);
        make.width.equalTo(@20.0);
        make.height.equalTo(@20.0);
    }];
    
    [self.passwordTextFieldBackgroundImageView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextFieldBackgroundImageView.mas_top).with.offset(7.0);
        make.left.equalTo(self.passwordImageView.mas_right).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-30.0);
        make.height.equalTo(@30.0);
    }];
    
    [self.backgroundImageView addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextFieldBackgroundImageView.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@44.0);
    }];
    
    [self.backgroundImageView addSubview:self.forgetPasswordImageView];
    [self.forgetPasswordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginButton.mas_bottom).with.offset(10.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.width.equalTo(@15.0);
        make.height.equalTo(@15.0);
    }];
    
    [self.backgroundImageView addSubview:self.forgetPasswordButton];
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginButton.mas_bottom).with.offset(10.0);
        make.left.equalTo(self.forgetPasswordImageView.mas_right).with.offset(0.0);
        make.width.equalTo(@70.0);
        make.height.equalTo(@15.0);
    }];
    
    [self.backgroundImageView addSubview:self.signupButton];
    [self.signupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-40.0);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@70.0);
        make.height.equalTo(@15.0);
    }];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - privete method

- (void) backToPreViewController {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) login {
    NSLog(@"login");
}

- (void) signup {
    NSLog(@"signup");
}

- (void) keyboardWillhide:(NSNotification *)notification {
    self.phoneImageView.image = [UIImage imageNamed:@"login_phone"];
    self.passwordImageView.image = [UIImage imageNamed:@"login_password"];
}


- (void) dismissKeyboard {
    [self.view endEditing:YES];
}

- (void) forgetPassword {
    NSLog(@"forgetPassword");
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, -100.0f, self.view.frame.size.width, self.view.frame.size.height); //64-216
    [UIView commitAnimations];
    self.iconImageView.hidden = YES;
    
    if (textField == self.phoneTextField) {
        self.phoneImageView.image = [UIImage imageNamed:@"login_phone_selected"];
        self.passwordImageView.image = [UIImage imageNamed:@"login_password"];
    }else if ( textField == self.passwordTextField ) {
        self.phoneImageView.image = [UIImage imageNamed:@"login_phone"];
        self.passwordImageView.image = [UIImage imageNamed:@"login_password_selected"];
    }
}

-( void )textFieldDidEndEditing:(UITextField *)textField{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height); //64-216
    [UIView commitAnimations];
     self.iconImageView.hidden = NO;
}

#pragma mark - getter and setter

- (UIImageView *) backgroundImageView {
    if (!_backgroundImageView) {
        // Load launch image
        NSString *launchImageName;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            if ([UIScreen mainScreen].bounds.size.height == 480) launchImageName = @"LaunchImage-700@2x.png"; // iPhone 4/4s, 3.5 inch screen
            if ([UIScreen mainScreen].bounds.size.height == 568) launchImageName = @"LaunchImage-700-568h@2x.png"; // iPhone 5/5s, 4.0 inch screen
            if ([UIScreen mainScreen].bounds.size.height == 667) launchImageName = @"LaunchImage-800-667h@2x.png"; // iPhone 6, 4.7 inch screen
            if ([UIScreen mainScreen].bounds.size.height == 736) launchImageName = @"LaunchImage-800-Portrait-736h@3x.png"; // iPhone 6+, 5.5 inch screen
        }else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            if ([UIScreen mainScreen].scale == 1) launchImageName = @"LaunchImage-700-Portrait~ipad.png"; // iPad 2
            if ([UIScreen mainScreen].scale == 2) launchImageName = @"LaunchImage-700-Portrait@2x~ipad.png"; // Retina iPads
        }
        
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _backgroundImageView.userInteractionEnabled = YES;
        _backgroundImageView.image = [UIImage imageNamed:launchImageName];

        UIImageView *blackImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        blackImageView.userInteractionEnabled = YES;
        blackImageView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        [_backgroundImageView addSubview:blackImageView];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(dismissKeyboard)];
        tapGesture.numberOfTapsRequired = 1;
        [tapGesture setDelegate:self];
        [blackImageView addGestureRecognizer:tapGesture];
    }
    return _backgroundImageView;
}

- (UIImageView *) iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
    }
    return _iconImageView;
}

- (UIButton *) closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"login_close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(backToPreViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIImageView *) phoneTextFieldBackgroundImageView {
    if (!_phoneTextFieldBackgroundImageView) {
        _phoneTextFieldBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_textFieldBackground"]];
        _phoneTextFieldBackgroundImageView.userInteractionEnabled = YES;
    }
    return _phoneTextFieldBackgroundImageView;
}

- (UIImageView *) passwordTextFieldBackgroundImageView {
    if (!_passwordTextFieldBackgroundImageView) {
        _passwordTextFieldBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_textFieldBackground"]];
        _passwordTextFieldBackgroundImageView.userInteractionEnabled = YES;
    }
    return _passwordTextFieldBackgroundImageView;
}

- (UIImageView *) phoneImageView {
    if (!_phoneImageView) {
        _phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_phone"]];
    }
    return _phoneImageView;
}

- (UIImageView *) passwordImageView {
    if (!_passwordImageView) {
        _passwordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password"]];
    }
    return _passwordImageView;
}

- (UIButton *) loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        [_loginButton.layer setMasksToBounds:YES];
        [_loginButton.layer setCornerRadius:2.0];
        [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.titleLabel.font = DEFAULFONT;
        _loginButton.backgroundColor = DEFAULTBROWNCOLOR;
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    }
    return _loginButton;
}

- (UITextField *) phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.delegate = self;
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.font = DEFAULFONT;
        _phoneTextField.textColor = DEFAULTBROWNCOLOR;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_phoneTextField setTintColor:DEFAULTBROWNCOLOR];
        _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号码" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    }
    return _phoneTextField;
}

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
        _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    }
    return _passwordTextField;
}

- (UIImageView *) forgetPasswordImageView {
    if (!_forgetPasswordImageView) {
        _forgetPasswordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_forgetpassword"]];
    }
    return _forgetPasswordImageView;
}

- (UIButton *) forgetPasswordButton {
    if (!_forgetPasswordButton) {
        _forgetPasswordButton = [[UIButton alloc] init];
        [_forgetPasswordButton addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
        _forgetPasswordButton.titleLabel.font = DEFAULFONT;
        [_forgetPasswordButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_forgetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    }
    return _forgetPasswordButton;
}


- (UIButton *) signupButton {
    if (!_signupButton) {
        _signupButton = [[UIButton alloc] init];
        [_signupButton addTarget:self action:@selector(signup) forControlEvents:UIControlEventTouchUpInside];
        _signupButton.titleLabel.font = DEFAULFONT;
        [_signupButton setTitleColor:DEFAULTBROWNCOLOR forState:UIControlStateNormal];
        [_signupButton setTitle:@"现在注册" forState:UIControlStateNormal];
    }
    return _signupButton;
}

@end
