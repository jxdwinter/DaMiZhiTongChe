//
//  SetPasswordViewController.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 2/29/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "BaseViewController.h"

@interface SetPasswordViewController : BaseViewController

/*
 0 为设置密码
 1 为重设密码
 */
@property (nonatomic, assign) NSUInteger setPasswordType;
@property (nonatomic, copy) NSString *phone;

@end
