//
//  HeaderView.m
//  TangPassport
//
//  Created by Xiaodong Jiang on 7/28/15.
//  Copyright (c) 2015 黑龙江龙卫中新医药连锁有限公司. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.avatarImageView = [[UIImageView alloc] init];
        [self addSubview:self.avatarImageView];
        [self.avatarImageView.layer setMasksToBounds:YES];
        [self.avatarImageView.layer setCornerRadius:25.0];
        self.avatarImageView.layer.borderColor = DEFAULTGRAYCOLOR.CGColor;
        self.avatarImageView.layer.borderWidth = 1.f;
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(15.0);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo(@50.0);
            make.height.equalTo(@50.0);
        }];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = DEFAULTTEXTCOLOR;
        self.nameLabel.font = DEFAULFONT;
        [self.nameLabel sizeToFit];
        [self addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(20.0);
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(10.0);
            make.height.equalTo(@20.0);
        }];

        UIImageView *lineImageView = [[UIImageView alloc] init];
        lineImageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [self addSubview:lineImageView];
        [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(0.0);
            make.bottom.equalTo(self.mas_bottom).with.offset(-0.5);
            make.right.equalTo(self.mas_right).with.offset(0.0);
            make.height.equalTo(@.5);
        }];
        
    }
    return self;
}

@end
