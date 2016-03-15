//
//  CartAddressEditViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/15/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "CartAddressEditViewController.h"
#import "Cart_modifyAddressApi.h"
#import "TextView.h"
#import "Cart_address.h"
#import "Cart_modifyDefaultAddressApi.h"

@interface CartAddressEditViewController ()

@property (nonatomic, strong) UIButton *editButton;

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *zipCodeTextField;
@property (nonatomic, strong) TextView *addressTextView;

@property (nonatomic, strong) UIButton *defaultButton;

@end

@implementation CartAddressEditViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    self.title = @"修改收货地址";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.editButton];
    
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
    
    [self.view addSubview:self.defaultButton];
    [self.defaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).with.offset(10.0);
        make.left.equalTo(self.view.mas_left).with.offset(20.0);
        make.right.equalTo(self.view.mas_right).with.offset(-20.0);
        make.height.equalTo(@44.0);
    }];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - privete method

- (void) defaultAddress {
    Cart_modifyDefaultAddressApi *api = [[Cart_modifyDefaultAddressApi alloc] initWithId:self.address._id];
    RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
    [api addAccessory:accessory];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
        if (dic) {
            if ([dic[@"result"] isEqualToString:@"0"]) {
                [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RELOADADDRESS" object:nil];
                [self performSelector:@selector(backToPreViewController) withObject:nil afterDelay:.5];
            }else{
                [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
            }
        }
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

- (void) backToPreViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) edit {
    if (self.nameTextField.text.length > 0 && self.phoneTextField.text.length > 0 && self.zipCodeTextField.text.length > 0 && self.addressTextView.text.length > 0) {
        Cart_modifyAddressApi *api = [[Cart_modifyAddressApi alloc] initWithId:self.address._id
                                                                      withName:self.nameTextField.text
                                                               withAddress:self.addressTextView.text
                                                               withZipcode:self.zipCodeTextField.text
                                                                withMobile:self.phoneTextField.text];
        RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
        [api addAccessory:accessory];
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
            if (dic) {
                if ([dic[@"result"] isEqualToString:@"0"]) {
                    [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
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

- (UIButton *) editButton {
    if (!_editButton) {
        _editButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
        [_editButton addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
        [_editButton setImage:[UIImage imageNamed:@"cart_save"] forState:UIControlStateNormal];
    }
    return _editButton;
}

- (UITextField *) nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.keyboardType = UIKeyboardTypeDefault;
        _nameTextField.font = DEFAULFONT;
        _nameTextField.textColor = DEFAULTTEXTCOLOR;
        [_nameTextField setTintColor:DEFAULTBROWNCOLOR];
        _nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"收货人姓名" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
        _nameTextField.text = self.address.name;
    }
    return _nameTextField;
}

- (UITextField *) phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.font = DEFAULFONT;
        _phoneTextField.textColor = DEFAULTTEXTCOLOR;
        [_phoneTextField setTintColor:DEFAULTBROWNCOLOR];
        _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号码" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
        _phoneTextField.text = self.address.mobile;
    }
    return _phoneTextField;
}

- (UITextField *) zipCodeTextField {
    if (!_zipCodeTextField) {
        _zipCodeTextField = [[UITextField alloc] init];
        _zipCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _zipCodeTextField.font = DEFAULFONT;
        _zipCodeTextField.textColor = DEFAULTTEXTCOLOR;
        [_zipCodeTextField setTintColor:DEFAULTBROWNCOLOR];
        _zipCodeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"邮政编码" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
        _zipCodeTextField.text = self.address.zipcode;
    }
    return _zipCodeTextField;
}

- (UITextView *) addressTextView {
    if (!_addressTextView) {
        _addressTextView = [[TextView alloc] init];
        _addressTextView.keyboardType = UIKeyboardTypeDefault;
        _addressTextView.font = DEFAULFONT;
        _addressTextView.textColor = DEFAULTTEXTCOLOR;
        [_addressTextView setTintColor:DEFAULTBROWNCOLOR];
        _addressTextView.placeholder = @"详细地址";
        _addressTextView.text = self.address.address;
    }
    return _addressTextView;
}

- (UIButton *) defaultButton {
    if (!_defaultButton) {
        _defaultButton = [[UIButton alloc] init];
        [_defaultButton.layer setMasksToBounds:YES];
        [_defaultButton.layer setCornerRadius:2.0];
        [_defaultButton addTarget:self action:@selector(defaultAddress) forControlEvents:UIControlEventTouchUpInside];
        _defaultButton.titleLabel.font = DEFAULFONT;
        _defaultButton.backgroundColor = DEFAULTBROWNCOLOR;
        [_defaultButton setTitle:@"设置为默认收货地址" forState:UIControlStateNormal];
    }
    return _defaultButton;
}

@end
