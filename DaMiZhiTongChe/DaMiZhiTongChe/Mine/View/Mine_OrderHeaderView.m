//
//  Mine_OrderHeaderView.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/17/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Mine_OrderHeaderView.h"

@implementation Mine_OrderHeaderView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *lineImageView = [[UIImageView alloc] init];
        lineImageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [self addSubview:lineImageView];
        [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(0.0);
            make.right.equalTo(self.mas_right).with.offset(0.0);
            make.bottom.equalTo(self.mas_bottom).with.offset(0.0);
            make.height.equalTo(@.5);
        }];
        
        self.button = [[UIButton alloc] init];
        [self.button.layer setMasksToBounds:YES];
        [self.button.layer setCornerRadius:2.0];
        self.button.titleLabel.font = [UIFont systemFontOfSize:10.0];
        [self.button setTitleColor:DEFAULTTEXTCOLOR forState:UIControlStateNormal];
        self.button.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [self addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(5.0);
            make.right.equalTo(self.mas_right).with.offset(-10.0);
            make.width.equalTo(@80.0);
            make.height.equalTo(@40.0);
        }];
        
        self.orderNumberLabel = [[UILabel alloc] init];
        self.orderNumberLabel.textColor = DEFAULTTEXTCOLOR;
        self.orderNumberLabel.font = [UIFont systemFontOfSize:10.0];
        [self addSubview:self.orderNumberLabel];
        [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(7.5);
            make.left.equalTo(self.mas_left).with.offset(10.0);
            make.right.equalTo(self.button.mas_left).with.offset(-10.0);
            make.height.equalTo(@20.0);
        }];
        
        self.addressLabel = [[UILabel alloc] init];
        self.addressLabel.textColor = DEFAULTTEXTCOLOR;
        self.addressLabel.font = [UIFont systemFontOfSize:10.0];
        [self addSubview:self.addressLabel];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderNumberLabel.mas_bottom).with.offset(0.0);
            make.left.equalTo(self.mas_left).with.offset(10.0);
            make.right.equalTo(self.button.mas_left).with.offset(-10.0);
            make.height.equalTo(@15.0);
        }];
    }
    return self;
}

@end
