//
//  MineEditInformationViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/16/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "MineEditInformationViewController.h"
#import "User.h"
#import <JGActionSheet.h>
#import "UploadManager.h"
#import "PMQiNiuToken.h"
#import <QNUploadManager.h>
#import "Mine_modifyDetailApi.h"

@interface MineEditInformationViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIImagePickerController *ctr;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIControl *avatarControl;
@property (nonatomic, strong) UITextField *nameTextField;

@end

@implementation MineEditInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backButton.hidden = NO;
    self.title = @"个人资料";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.saveButton];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 130.0)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [view addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).with.offset(10.0);
        make.centerX.equalTo(view.mas_centerX);
        make.width.equalTo(@60.0);
        make.height.equalTo(@60.0);
    }];
    
    UIImageView *headImageView = [[UIImageView alloc] init];
    headImageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [view addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).with.offset(10.0);
        make.right.equalTo(view.mas_right).with.offset(-10.0);
        make.top.equalTo(self.avatarImageView.mas_bottom).with.offset(10.0);
        make.height.equalTo(@.5);
    }];
    
    [view addSubview:self.avatarControl];
    [self.avatarControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).with.offset(0.0);
        make.left.equalTo(view.mas_left).with.offset(0.0);
        make.right.equalTo(view.mas_right).with.offset(0.0);
        make.height.equalTo(@80);
    }];
    
    UILabel *nicknameLabel = [[UILabel alloc] init];
    nicknameLabel = [[UILabel alloc] init];
    nicknameLabel.textColor = DEFAULTTEXTCOLOR;
    nicknameLabel.font = [UIFont systemFontOfSize:14.0];
    nicknameLabel.text = @"昵称";
    [view addSubview:nicknameLabel];
    [nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImageView.mas_bottom).with.offset(10.0);
        make.left.equalTo(view.mas_left).with.offset(10.0);
        make.width.equalTo(@50.0);
        make.height.equalTo(@30.0);
    }];
    
    [view addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImageView.mas_bottom).with.offset(10.0);
        make.left.equalTo(nicknameLabel.mas_right).with.offset(10.0);
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[[[AccountManager sharedAccountManager] getCurrentUser] headimg]]
                                   placeholderImage:[UIImage imageNamed:@"mine_headerImage"]];
    self.nameTextField.text = [NSString stringWithFormat:@"%@",[[[AccountManager sharedAccountManager] getCurrentUser] nickname]];
}

#pragma mark - privete method

- (void) backToPreViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) changeAvatar {
    JGActionSheetSection *section = [JGActionSheetSection sectionWithTitle:@"修改头像" message:@"" buttonTitles:@[@"拍照",@"选择"] buttonStyle:JGActionSheetButtonStyleDefault];
    section.titleLabel.textColor = DEFAULTTEXTCOLOR;
    section.titleLabel.font = DEFAULFONT;
    JGActionSheetSection *cancelSection = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleCancel];
    NSArray *sections = @[section, cancelSection];
    JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
    [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
        [sheet dismissAnimated:YES];
        if (indexPath.section == 0 && indexPath.row == 0) {
            //如果可以实用摄像头
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
                self.ctr = [[UIImagePickerController alloc] init];
                self.ctr.sourceType = UIImagePickerControllerSourceTypeCamera;
                self.ctr.delegate = self;
                self.ctr.allowsEditing = YES;
                [self presentViewController:self.ctr animated:YES completion:^{
                    
                }];
            }
        }else if (indexPath.section == 0 && indexPath.row == 1){
            //如果可以实用图库
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]){
                self.ctr = [[UIImagePickerController alloc] init];
                self.ctr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                self.ctr.delegate = self;
                self.ctr.allowsEditing = YES;
                [self presentViewController:self.ctr animated:YES completion:^{
                    
                }];
            }
        }
    }];
    [sheet showInView:self.navigationController.view animated:YES];
}

- (void) save {
    if (self.nameTextField.text.length > 0 ) {
        Mine_modifyDetailApi *api = [[Mine_modifyDetailApi alloc] init];
        RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
        [api addAccessory:accessory];
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
            if (dic) {
                if ([dic[@"result"] isEqualToString:@"0"]) {
                    [[AccountManager sharedAccountManager] updateCurrentUserInfoWithDictionary:@{@"nickname" : self.nameTextField.text}];
                    [MBProgressHUD showHUDwithSuccess:YES WithTitle:dic[@"msg"] withView:self.navigationController.view];
                    self.nameTextField.text = self.nameTextField.text;
                }else{
                    [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
                }
            }
        } failure:^(YTKBaseRequest *request) {
            
        }];
    }else{
        [MBProgressHUD showHUDwithSuccess:NO WithTitle:@"请填写昵称" withView:self.navigationController.view];
    }
}

- (void) uploadImageWithImageData : (NSData *) imageData{
    WEAKSELF
    [[UploadManager sharedUploadManager] putData:imageData
                                             key:nil
                                           token:[PMQiNiuToken generateUploadTokenWithScopeName:AVATARSCOPENAME]
                                        complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                                            if (resp) {
                                                NSString *imageURL = [AVATARURL stringByAppendingString:resp[@"key"]];
                                                [weakSelf saveAvatarWithImageURL:imageURL];
                                            }
                                        } option:nil];
}

- (void)saveAvatarWithImageURL : (NSString *) imageURL{
    Mine_modifyDetailApi *api = [[Mine_modifyDetailApi alloc] init];
    RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
    [api addAccessory:accessory];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
        if (dic) {
            if ([dic[@"result"] isEqualToString:@"0"]) {
                [[AccountManager sharedAccountManager] updateCurrentUserInfoWithDictionary:@{@"headimg" : imageURL}];
                [MBProgressHUD showHUDwithSuccess:YES WithTitle:dic[@"msg"] withView:self.navigationController.view];
                [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"PersonalCenter_avatarImageView"]];
            }else{
                [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
            }
        }
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

# pragma mark -
# pragma mark UIImagePickerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
    [self uploadImageWithImageData:imageData];
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

- (UIImageView *) avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.userInteractionEnabled = YES;
        [_avatarImageView.layer setMasksToBounds:YES];
        [_avatarImageView.layer setCornerRadius:30.0];
        _avatarImageView.layer.borderColor = DEFAULTBROWNCOLOR.CGColor;
        _avatarImageView.layer.borderWidth = 1.f;
    }
    return _avatarImageView;
}

- (UIControl *) avatarControl {
    if (!_avatarControl) {
        _avatarControl = [[UIControl alloc] init];
        _avatarControl.backgroundColor = [UIColor clearColor];
        [_avatarControl addTarget:self action:@selector(changeAvatar) forControlEvents:UIControlEventTouchUpInside];
    }
    return _avatarControl;
}

- (UITextField *) nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.keyboardType = UIKeyboardTypeDefault;
        _nameTextField.font = DEFAULFONT;
        _nameTextField.textColor = DEFAULTTEXTCOLOR;
        [_nameTextField setTintColor:DEFAULTBROWNCOLOR];
        _nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"昵称" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    }
    return _nameTextField;
}

@end
