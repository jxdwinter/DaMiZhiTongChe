//
//  FooterView.m
//  TangPassport
//
//  Created by Xiaodong Jiang on 7/31/15.
//  Copyright (c) 2015 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "FooterView.h"

@implementation FooterView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.logoutButton = [[UIButton alloc] init];
        [self.logoutButton.layer setMasksToBounds:YES];
        [self.logoutButton.layer setCornerRadius:2.0];
        self.logoutButton.titleLabel.font = DEFAULFONT;
        self.logoutButton.backgroundColor = DEFAULTBROWNCOLOR;
        [self.logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [self addSubview:self.logoutButton];
        [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(20.0);
            make.left.equalTo(self.mas_left).with.offset(20.0);
            make.right.equalTo(self.mas_right).with.offset(-20.0);
            make.height.equalTo(@44.0);
        }];
    }
    return self;
}

@end
