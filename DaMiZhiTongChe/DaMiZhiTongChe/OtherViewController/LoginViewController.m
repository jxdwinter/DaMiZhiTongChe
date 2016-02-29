//
//  LoginViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 2/24/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "LoginViewController.h"
#import "SetPasswordViewController.h"
#import "ForgetPasswordViewController.h"

@interface LoginViewController () <UITextFieldDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *blackImageView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIImageView *phoneTextFieldBackgroundImageView;
@property (nonatomic, strong) UIImageView *passwordTextFieldBackgroundImageView;
@property (nonatomic, strong) UIImageView *codeBackgroundImageView;
@property (nonatomic, strong) UIImageView *phoneImageView;
@property (nonatomic, strong) UIImageView *passwordImageView;
@property (nonatomic, strong) UIImageView *codeImageView;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *signUpButton;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIImageView *forgetPasswordImageView;
@property (nonatomic, strong) UIButton *forgetPasswordButton;
@property (nonatomic, strong) UIButton *changeToSignupButton;
@property (nonatomic, strong) UIButton *changeToLoginButton;
@property (nonatomic, strong) UILabel *declarationLabel;
@property (nonatomic, strong) UIButton *getCodeButton;

@end

@implementation LoginViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];

    [self.view addSubview:self.backgroundImageView];
    [self.backgroundImageView addSubview:self.blackImageView];
    
    [self.blackImageView addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.blackImageView.mas_top).with.offset(20.0);
        make.right.equalTo(self.blackImageView.mas_right).with.offset(-10.0);
        make.width.equalTo(@25.0);
        make.height.equalTo(@25.0);
    }];
    
    [self.blackImageView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_4_OR_LESS) {
            make.top.equalTo(self.blackImageView.mas_top).with.offset(20.0);
        } else if (IS_IPHONE_5) {
            make.top.equalTo(self.blackImageView.mas_top).with.offset(50.0);
        } else if (IS_IPHONE_6) {
            make.top.equalTo(self.blackImageView.mas_top).with.offset(100.0);
        } else if ( IS_IPHONE_6P ){
            make.top.equalTo(self.blackImageView.mas_top).with.offset(130.0);
        }
        make.centerX.equalTo(self.blackImageView.mas_centerX);
        make.width.equalTo(@120.0);
        make.height.equalTo(@120.0);
    }];
    
    [self.blackImageView addSubview:self.phoneTextFieldBackgroundImageView];
    [self.phoneTextFieldBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_4_OR_LESS) {
            make.top.equalTo(self.iconImageView.mas_bottom).with.offset(20.0);
        } else if (IS_IPHONE_5) {
            make.top.equalTo(self.iconImageView.mas_bottom).with.offset(50.0);
        } else if (IS_IPHONE_6) {
            make.top.equalTo(self.iconImageView.mas_bottom).with.offset(100.0);
        } else if ( IS_IPHONE_6P ){
            make.top.equalTo(self.iconImageView.mas_bottom).with.offset(130.0);
        }
        make.left.equalTo(self.blackImageView.mas_left).with.offset(20.0);
        make.right.equalTo(self.blackImageView.mas_right).with.offset(-20.0);
        make.height.equalTo(@44.0);
    }];
    
    UIImageView *phoneBlackImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_black"]];
    [self.phoneTextFieldBackgroundImageView addSubview:phoneBlackImageView];
    [phoneBlackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextFieldBackgroundImageView.mas_top).with.offset(.0);
        make.left.equalTo(self.phoneTextFieldBackgroundImageView.mas_left).with.offset(.0);
        make.width.equalTo(@44.0);
        make.height.equalTo(@44.0);
    }];
    
    [phoneBlackImageView addSubview:self.phoneImageView];
    [self.phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(phoneBlackImageView.mas_centerX).with.offset(.0);
        make.centerY.equalTo(phoneBlackImageView.mas_centerY).with.offset(.0);
        make.width.equalTo(@20.0);
        make.height.equalTo(@20.0);
    }];
    
    [self.phoneTextFieldBackgroundImageView addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextFieldBackgroundImageView.mas_top).with.offset(7.0);
        make.left.equalTo(self.phoneImageView.mas_right).with.offset(20.0);
        make.right.equalTo(self.blackImageView.mas_right).with.offset(-30.0);
        make.height.equalTo(@30.0);
    }];
    
    [self.blackImageView addSubview:self.passwordTextFieldBackgroundImageView];
    [self.passwordTextFieldBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextFieldBackgroundImageView.mas_bottom).with.offset(2.0);
        make.left.equalTo(self.blackImageView.mas_left).with.offset(20.0);
        make.right.equalTo(self.blackImageView.mas_right).with.offset(-20.0);
        make.height.equalTo(@44.0);
    }];
    
    UIImageView *passwordBlackImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_black"]];
    [self.passwordTextFieldBackgroundImageView addSubview:passwordBlackImageView];
    [passwordBlackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextFieldBackgroundImageView.mas_top).with.offset(.0);
        make.left.equalTo(self.passwordTextFieldBackgroundImageView.mas_left).with.offset(.0);
        make.width.equalTo(@44.0);
        make.height.equalTo(@44.0);
    }];
    
    [self.passwordTextFieldBackgroundImageView addSubview:self.passwordImageView];
    [self.passwordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(passwordBlackImageView.mas_centerX).with.offset(.0);
        make.centerY.equalTo(passwordBlackImageView.mas_centerY).with.offset(.0);
        make.width.equalTo(@20.0);
        make.height.equalTo(@20.0);
    }];
    
    [self.passwordTextFieldBackgroundImageView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextFieldBackgroundImageView.mas_top).with.offset(7.0);
        make.left.equalTo(self.passwordImageView.mas_right).with.offset(20.0);
        make.right.equalTo(self.blackImageView.mas_right).with.offset(-30.0);
        make.height.equalTo(@30.0);
    }];
    
    [self.blackImageView addSubview:self.codeBackgroundImageView];
    [self.codeBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextFieldBackgroundImageView.mas_bottom).with.offset(2.0);
        make.left.equalTo(self.blackImageView.mas_left).with.offset(20.0);
        make.right.equalTo(self.blackImageView.mas_right).with.offset(-20.0);
        make.height.equalTo(@44.0);
    }];
    
    UIImageView *codeBlackImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_black"]];
    [self.codeBackgroundImageView addSubview:codeBlackImageView];
    [codeBlackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeBackgroundImageView.mas_top).with.offset(.0);
        make.left.equalTo(self.codeBackgroundImageView.mas_left).with.offset(.0);
        make.width.equalTo(@44.0);
        make.height.equalTo(@44.0);
    }];
    
    [codeBlackImageView addSubview:self.codeImageView];
    [self.codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(codeBlackImageView.mas_centerX).with.offset(.0);
        make.centerY.equalTo(codeBlackImageView.mas_centerY).with.offset(.0);
        make.width.equalTo(@20.0);
        make.height.equalTo(@20.0);
    }];
    
    [self.codeBackgroundImageView addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeBackgroundImageView.mas_top).with.offset(7.0);
        make.left.equalTo(self.codeImageView.mas_right).with.offset(20.0);
        make.right.equalTo(self.codeBackgroundImageView.mas_right).with.offset(-100.0);
        make.height.equalTo(@30.0);
    }];
    
    [self.codeBackgroundImageView addSubview:self.getCodeButton];
    [self.getCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeBackgroundImageView.mas_top).with.offset(7.0);
        make.left.equalTo(self.codeTextField.mas_right).with.offset(10.0);
        make.right.equalTo(self.codeBackgroundImageView.mas_right).with.offset(-10.0);
        make.height.equalTo(@30.0);
    }];
    
    [self.blackImageView addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextFieldBackgroundImageView.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.blackImageView.mas_left).with.offset(20.0);
        make.right.equalTo(self.blackImageView.mas_right).with.offset(-20.0);
        make.height.equalTo(@44.0);
    }];
    
    [self.blackImageView addSubview:self.signUpButton];
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextFieldBackgroundImageView.mas_bottom).with.offset(20.0);
        make.left.equalTo(self.blackImageView.mas_left).with.offset(20.0);
        make.right.equalTo(self.blackImageView.mas_right).with.offset(-20.0);
        make.height.equalTo(@44.0);
    }];
    
    [self.blackImageView addSubview:self.forgetPasswordImageView];
    [self.forgetPasswordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginButton.mas_bottom).with.offset(10.0);
        make.left.equalTo(self.blackImageView.mas_left).with.offset(20.0);
        make.width.equalTo(@15.0);
        make.height.equalTo(@15.0);
    }];
    
    [self.blackImageView addSubview:self.forgetPasswordButton];
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginButton.mas_bottom).with.offset(10.0);
        make.left.equalTo(self.forgetPasswordImageView.mas_right).with.offset(0.0);
        make.width.equalTo(@70.0);
        make.height.equalTo(@15.0);
    }];
    
    [self.blackImageView addSubview:self.declarationLabel];
    [self.declarationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.signUpButton.mas_bottom).with.offset(10.0);
        make.left.equalTo(self.blackImageView.mas_left).with.offset(20.0);
        make.right.equalTo(self.blackImageView.mas_right).with.offset(-20.0);
        make.height.equalTo(@15.0);
    }];
    
    [self.blackImageView addSubview:self.changeToSignupButton];
    [self.changeToSignupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-40.0);
        make.centerX.equalTo(self.blackImageView.mas_centerX);
        make.width.equalTo(@70.0);
        make.height.equalTo(@15.0);
    }];
    
    [self.blackImageView addSubview:self.changeToLoginButton];
    [self.changeToLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-40.0);
        make.centerX.equalTo(self.blackImageView.mas_centerX);
        make.width.equalTo(@70.0);
        make.height.equalTo(@15.0);
    }];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.view endEditing:YES];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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

- (void) signUp {
    SetPasswordViewController *setPasswordViewController = [[SetPasswordViewController alloc] init];
    setPasswordViewController.setPasswordType = 0;
    [self.navigationController pushViewController:setPasswordViewController animated:YES];
}

- (void) getCode : (UIButton *) button {
    [self setButtonCountDown:button];
}

- (void)declarationLabelClicked : (UILabel *) sender{
    NSLog(@"declarationLabelClicked");
}

- (void) forgetPassword {
    [self.navigationController pushViewController:[[ForgetPasswordViewController alloc] init] animated:YES];
}

- (void) changeTosignup {
    self.changeToLoginButton.hidden = NO;
    self.signUpButton.hidden = NO;
    self.declarationLabel.hidden = NO;
    self.codeBackgroundImageView.hidden = NO;
    
    self.changeToSignupButton.hidden = YES;
    self.loginButton.hidden = YES;
    self.forgetPasswordImageView.hidden = YES;
    self.forgetPasswordButton.hidden = YES;
    self.passwordTextFieldBackgroundImageView.hidden = YES;
}

- (void) changeToLogin {
    self.changeToLoginButton.hidden = YES;
    self.signUpButton.hidden = YES;
    self.declarationLabel.hidden = YES;
    self.codeBackgroundImageView.hidden = YES;
    
    self.changeToSignupButton.hidden = NO;
    self.loginButton.hidden = NO;
    self.forgetPasswordImageView.hidden = NO;
    self.forgetPasswordButton.hidden = NO;
    self.passwordTextFieldBackgroundImageView.hidden = NO;
}

- (void) keyboardWillhide:(NSNotification *)notification {
    self.phoneImageView.image = [UIImage imageNamed:@"login_phone"];
    self.passwordImageView.image = [UIImage imageNamed:@"login_password"];
    self.codeImageView.image = [UIImage imageNamed:@"login_code"];
}

- (void) dismissKeyboard {
    [self.view endEditing:YES];
}

-(void) setButtonCountDown:(UIButton *)button {
    button.enabled = NO;
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1ull*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if( timeout <= 0 ){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                button.enabled = YES;
                [button setTitleColor:DEFAULTBROWNCOLOR forState:UIControlStateNormal];
                [button setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        }else{
            NSString *strTime = [NSString stringWithFormat:@"%ds",timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                [button setTitle:strTime forState:UIControlStateDisabled];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.blackImageView.frame = CGRectMake(0.0f, -100.0f, self.blackImageView.frame.size.width, self.blackImageView.frame.size.height);
    [UIView commitAnimations];
    [UIView transitionWithView:self.iconImageView duration:.8 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
        self.iconImageView.hidden = YES;
    } completion:nil];
    if (textField == self.phoneTextField) {
        self.phoneImageView.image = [UIImage imageNamed:@"login_phone_selected"];
        self.passwordImageView.image = [UIImage imageNamed:@"login_password"];
        self.codeImageView.image = [UIImage imageNamed:@"login_code"];
    }else if ( textField == self.passwordTextField ) {
        self.phoneImageView.image = [UIImage imageNamed:@"login_phone"];
        self.passwordImageView.image = [UIImage imageNamed:@"login_password_selected"];
        self.codeImageView.image = [UIImage imageNamed:@"login_code"];
    }else if ( textField == self.codeTextField ) {
        self.phoneImageView.image = [UIImage imageNamed:@"login_phone"];
        self.passwordImageView.image = [UIImage imageNamed:@"login_password"];
        self.codeImageView.image = [UIImage imageNamed:@"login_code_selected"];
    }
}

-( void )textFieldDidEndEditing:(UITextField *)textField{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.blackImageView.frame = CGRectMake(0.0f, 0.0f, self.blackImageView.frame.size.width, self.blackImageView.frame.size.height);
    [UIView commitAnimations];
    [UIView transitionWithView:self.iconImageView duration:.8 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
        self.iconImageView.hidden = NO;
    } completion:nil];
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
    }
    return _backgroundImageView;
}

- (UIImageView *) blackImageView {
    if (!_blackImageView) {
        _blackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y,
                                                                        self.view.frame.size.width, self.view.frame.size.height + 100.0)];
        _blackImageView.userInteractionEnabled = YES;
        _blackImageView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(dismissKeyboard)];
        tapGesture.numberOfTapsRequired = 1;
        [tapGesture setDelegate:self];
        [_blackImageView addGestureRecognizer:tapGesture];
    }
    return _blackImageView;
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

- (UIImageView *) codeBackgroundImageView {
    if (!_codeBackgroundImageView) {
        _codeBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_textFieldBackground"]];
        _codeBackgroundImageView.userInteractionEnabled = YES;
        _codeBackgroundImageView.hidden = YES;
    }
    return _codeBackgroundImageView;
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

- (UIImageView *) codeImageView {
    if (!_codeImageView) {
        _codeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_code"]];
    }
    return _codeImageView;
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

- (UIButton *) signUpButton {
    if (!_signUpButton) {
        _signUpButton = [[UIButton alloc] init];
        [_signUpButton.layer setMasksToBounds:YES];
        [_signUpButton.layer setCornerRadius:2.0];
        [_signUpButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
        _signUpButton.titleLabel.font = DEFAULFONT;
        _signUpButton.backgroundColor = DEFAULTBROWNCOLOR;
        [_signUpButton setTitle:@"注册" forState:UIControlStateNormal];
        _signUpButton.hidden = YES;
    }
    return _signUpButton;
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

- (UITextField *) codeTextField{
    if (!_codeTextField) {
        _codeTextField = [[UITextField alloc] init];
        _codeTextField.delegate = self;
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.font = DEFAULFONT;
        _codeTextField.textColor = DEFAULTBROWNCOLOR;
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_codeTextField setTintColor:DEFAULTBROWNCOLOR];
        _codeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    }
    return _codeTextField;
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

- (UIButton *) changeToSignupButton {
    if (!_changeToSignupButton) {
        _changeToSignupButton = [[UIButton alloc] init];
        [_changeToSignupButton addTarget:self action:@selector(changeTosignup) forControlEvents:UIControlEventTouchUpInside];
        _changeToSignupButton.titleLabel.font = DEFAULFONT;
        [_changeToSignupButton setTitleColor:DEFAULTBROWNCOLOR forState:UIControlStateNormal];
        [_changeToSignupButton setTitle:@"现在注册" forState:UIControlStateNormal];
    }
    return _changeToSignupButton;
}

- (UIButton *) changeToLoginButton {
    if (!_changeToLoginButton) {
        _changeToLoginButton = [[UIButton alloc] init];
        [_changeToLoginButton addTarget:self action:@selector(changeToLogin) forControlEvents:UIControlEventTouchUpInside];
        _changeToLoginButton.titleLabel.font = DEFAULFONT;
        [_changeToLoginButton setTitleColor:DEFAULTBROWNCOLOR forState:UIControlStateNormal];
        [_changeToLoginButton setTitle:@"返回登录" forState:UIControlStateNormal];
        _changeToLoginButton.hidden = YES;
    }
    return _changeToLoginButton;
}

- (UILabel *) declarationLabel {
    if (!_declarationLabel) {
        _declarationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _declarationLabel.textAlignment = NSTextAlignmentCenter;
        _declarationLabel.font = DEFAULFONT;
        _declarationLabel.userInteractionEnabled = YES;
        _declarationLabel.textColor = [UIColor lightGrayColor];
        NSString *string = @"注册代表你已同意大米直通车用户协议";
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
        [attr addAttribute:NSForegroundColorAttributeName value:DEFAULTBROWNCOLOR range:[string rangeOfString:@"大米直通车用户协议"]];
        _declarationLabel.attributedText = attr;
        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(declarationLabelClicked:)];
        [_declarationLabel addGestureRecognizer:gesture];
        _declarationLabel.hidden = YES;
    }
    return _declarationLabel;
}

- (UIButton *) getCodeButton {
    if (!_getCodeButton) {
        _getCodeButton = [[UIButton alloc] init];
        [_getCodeButton addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
        _getCodeButton.titleLabel.font = DEFAULFONT;
        [_getCodeButton setTitleColor:DEFAULTBROWNCOLOR forState:UIControlStateNormal];
        [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return _getCodeButton;
}

@end
