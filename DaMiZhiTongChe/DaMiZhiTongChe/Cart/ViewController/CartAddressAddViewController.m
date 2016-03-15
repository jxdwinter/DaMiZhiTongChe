//
//  CartAddressAddViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/15/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "CartAddressAddViewController.h"
#import "TextView.h"
#import "Cart_AddAddressApi.h"
#import "Cart_getAddressListApi.h"

@interface CartAddressAddViewController ()

@property (nonatomic, strong) UIButton *saveButton;

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *zipCodeTextField;
@property (nonatomic, strong) TextView *addressTextView;

@end

@implementation CartAddressAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    self.title = @"增加收货地址";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.saveButton];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 250.0)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [view addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).with.offset(10.0);
        make.left.equalTo(view.mas_left).with.offset(10.0);
        make.right.equalTo(view.mas_right).with.offset(-10.0);
        make.height.equalTo(@30.0);
    }];
    
    UIImageView *nameLineImageView = [[UIImageView alloc] init];
    nameLineImageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [view addSubview:nameLineImageView];
    [nameLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).with.offset(10.0);
        make.right.equalTo(view.mas_right).with.offset(-10.0);
        make.top.equalTo(self.nameTextField.mas_bottom).with.offset(10.0);
        make.height.equalTo(@.5);
    }];
    
    [view addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLineImageView.mas_bottom).with.offset(10.0);
        make.left.equalTo(view.mas_left).with.offset(10.0);
        make.right.equalTo(view.mas_right).with.offset(-10.0);
        make.height.equalTo(@30.0);
    }];
    
    UIImageView *phoneLineImageView = [[UIImageView alloc] init];
    phoneLineImageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [view addSubview:phoneLineImageView];
    [phoneLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).with.offset(10.0);
        make.right.equalTo(view.mas_right).with.offset(-10.0);
        make.top.equalTo(self.phoneTextField.mas_bottom).with.offset(10.0);
        make.height.equalTo(@.5);
    }];
    
    [view addSubview:self.zipCodeTextField];
    [self.zipCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLineImageView.mas_bottom).with.offset(10.0);
        make.left.equalTo(view.mas_left).with.offset(10.0);
        make.right.equalTo(view.mas_right).with.offset(-10.0);
        make.height.equalTo(@30.0);
    }];
    
    UIImageView *zipCodeLineImageView = [[UIImageView alloc] init];
    zipCodeLineImageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [view addSubview:zipCodeLineImageView];
    [zipCodeLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).with.offset(10.0);
        make.right.equalTo(view.mas_right).with.offset(-10.0);
        make.top.equalTo(self.zipCodeTextField.mas_bottom).with.offset(10.0);
        make.height.equalTo(@.5);
    }];
    
    [view addSubview:self.addressTextView];
    [self.addressTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(zipCodeLineImageView.mas_bottom).with.offset(10.0);
        make.left.equalTo(view.mas_left).with.offset(5.0);
        make.right.equalTo(view.mas_right).with.offset(-5.0);
        make.height.equalTo(@80.0);
    }];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.nameTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - privete method

- (void) backToPreViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) save {
    if (self.nameTextField.text.length > 0 && self.phoneTextField.text.length > 0 && self.zipCodeTextField.text.length > 0 && self.addressTextView.text.length > 0) {
        Cart_AddAddressApi *api = [[Cart_AddAddressApi alloc] initWithName:self.nameTextField.text
                                                               withAddress:self.addressTextView.text
                                                               withZipcode:self.zipCodeTextField.text
                                                                withMobile:self.phoneTextField.text];
        RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
        [api addAccessory:accessory];
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
            if (dic) {
                if ([dic[@"result"] isEqualToString:@"0"]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"RELOADADDRESS" object:nil];
                    [self performSelector:@selector(backToPreViewController) withObject:nil afterDelay:.5];
                }else{
                    [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
                }
            }
        } failure:^(YTKBaseRequest *request) {
            
        }];
    }else{
        [MBProgressHUD showHUDwithSuccess:NO WithTitle:@"请正确填写收货信息" withView:self.navigationController.view];
    }
}

#pragma mark - getter and setter

- (UIButton *) saveButton {
    if (!_saveButton) {
        _saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
        [_saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        [_saveButton setImage:[UIImage imageNamed:@"cart_save"] forState:UIControlStateNormal];
    }
    return _saveButton;
}

- (UITextField *) nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.keyboardType = UIKeyboardTypeDefault;
        _nameTextField.font = DEFAULFONT;
        _nameTextField.textColor = DEFAULTBROWNCOLOR;
        [_nameTextField setTintColor:DEFAULTBROWNCOLOR];
        _nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"收货人姓名" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    }
    return _nameTextField;
}

- (UITextField *) phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.font = DEFAULFONT;
        _phoneTextField.textColor = DEFAULTBROWNCOLOR;
        [_phoneTextField setTintColor:DEFAULTBROWNCOLOR];
        _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号码" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    }
    return _phoneTextField;
}

- (UITextField *) zipCodeTextField {
    if (!_zipCodeTextField) {
        _zipCodeTextField = [[UITextField alloc] init];
        _zipCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _zipCodeTextField.font = DEFAULFONT;
        _zipCodeTextField.textColor = DEFAULTBROWNCOLOR;
        [_zipCodeTextField setTintColor:DEFAULTBROWNCOLOR];
        _zipCodeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"邮政编码" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    }
    return _zipCodeTextField;
}

- (UITextView *) addressTextView {
    if (!_addressTextView) {
        _addressTextView = [[TextView alloc] init];
        _addressTextView.keyboardType = UIKeyboardTypeDefault;
        _addressTextView.font = DEFAULFONT;
        _addressTextView.textColor = DEFAULTBROWNCOLOR;
        [_addressTextView setTintColor:DEFAULTBROWNCOLOR];
        _addressTextView.placeholder = @"详细地址";
    }
    return _addressTextView;
}
@end
