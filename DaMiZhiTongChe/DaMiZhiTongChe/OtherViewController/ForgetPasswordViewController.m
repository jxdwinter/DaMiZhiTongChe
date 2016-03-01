//
//  ForgetPasswordViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 2/29/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "SetPasswordViewController.h"
#import "Login_sendCodeApi.h"

@interface ForgetPasswordViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIButton *getCodeButton;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"验证手机";
    
    [self.view addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(50.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@30.0);
    }];
    
    UIImageView *lineImageView = [[UIImageView alloc] init];
    lineImageView.backgroundColor = DEFAULTGRAYCOLOR;
    [self.view addSubview:lineImageView];
    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).with.offset(5.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@.5);
    }];
    
    [self.view addSubview:self.getCodeButton];
    [self.getCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineImageView.mas_bottom).with.offset(5.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.width.equalTo (@80);
        make.height.equalTo(@30.0);
    }];
    
    [self.view addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineImageView.mas_bottom).with.offset(5.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.getCodeButton.mas_left).with.offset(-10.0);
        make.height.equalTo(@30.0);
    }];
    
    UIImageView *lineTwoImageView = [[UIImageView alloc] init];
    lineTwoImageView.backgroundColor = DEFAULTGRAYCOLOR;
    [self.view addSubview:lineTwoImageView];
    [lineTwoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTextField.mas_bottom).with.offset(5.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@.5);
    }];
    
    [self.view addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_4_OR_LESS) {
            make.top.equalTo(lineTwoImageView.mas_bottom).with.offset(20.0);
        } else if (IS_IPHONE_5) {
            make.top.equalTo(lineTwoImageView.mas_bottom).with.offset(40.0);
        } else if (IS_IPHONE_6) {
            make.top.equalTo(lineTwoImageView.mas_bottom).with.offset(50.0);
        } else if ( IS_IPHONE_6P ){
            make.top.equalTo(lineTwoImageView.mas_bottom).with.offset(50.0);
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

- (void) getCode : (UIButton *) button {
    if ([VerifyTools verifyPhoneNumber:self.phoneTextField.text]) {
        Login_sendCodeApi *api = [[Login_sendCodeApi alloc] initWithPhone:self.phoneTextField.text withType:@"1"];
        RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
        [api addAccessory:accessory];
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
            if (dic) {
                if ([dic[@"result"] isEqualToString:@"0"]) {
                    [self setButtonCountDown:button];
                    [MBProgressHUD showHUDwithSuccess:YES WithTitle:dic[@"msg"] withView:self.navigationController.view];
                }else{
                    [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
                }
            }
        } failure:^(YTKBaseRequest *request) {
            
        }];
    }else{
        [MBProgressHUD showHUDwithSuccess:NO WithTitle:@"请正确填写手机号码" withView:self.navigationController.view];
    }
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

- (void) confirm {
    if ( [VerifyTools verifyPhoneNumber:self.phoneTextField.text] && [VerifyTools verifyVerityCode:self.codeTextField.text] ) {
        
    }else{
        [MBProgressHUD showHUDwithSuccess:NO WithTitle:@"请正确填写手机号码和六位数字验证码" withView:self.navigationController.view];
    }
    /*
    SetPasswordViewController *setPasswordViewController = [[SetPasswordViewController alloc] init];
    setPasswordViewController.setPasswordType = 1;
    [self.navigationController pushViewController:setPasswordViewController animated:YES];
     */
}

#pragma mark - getter and setter

- (UITextField *) phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.delegate = self;
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.font = DEFAULFONT;
        _phoneTextField.textColor = DEFAULTBROWNCOLOR;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_phoneTextField setTintColor:DEFAULTBROWNCOLOR];
        _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号(仅支持中国大陆手机)" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    }
    return _phoneTextField;
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
