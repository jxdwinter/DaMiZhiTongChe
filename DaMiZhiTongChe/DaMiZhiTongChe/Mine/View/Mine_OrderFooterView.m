//
//  Mine_OrderFooterView.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/17/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Mine_OrderFooterView.h"

@implementation Mine_OrderFooterView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *lineImageView = [[UIImageView alloc] init];
        lineImageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [self addSubview:lineImageView];
        [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(0.0);
            make.right.equalTo(self.mas_right).with.offset(0.0);
            make.top.equalTo(self.mas_top).with.offset(0.0);
            make.height.equalTo(@.5);
        }];
        
        self.button = [[UIButton alloc] init];
        [self.button.layer setMasksToBounds:YES];
        [self.button.layer setCornerRadius:2.0];
        self.button.titleLabel.font = [UIFont systemFontOfSize:12.0];
        self.button.backgroundColor = DEFAULTBROWNCOLOR;
        [self addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(5.0);
            make.right.equalTo(self.mas_right).with.offset(-10.0);
            make.width.equalTo(@80.0);
            make.height.equalTo(@25.0);
        }];
        
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.textColor = DEFAULTTEXTCOLOR;
        self.priceLabel.font = [UIFont systemFontOfSize:10.0];
        [self addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(7.5);
            make.left.equalTo(self.mas_left).with.offset(10.0);
            make.right.equalTo(self.button.mas_left).with.offset(-10.0);
            make.height.equalTo(@20.0);
        }];
    }
    return self;
}
@end
