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
        
        self.orderNumberLabel = [[UILabel alloc] init];
        self.orderNumberLabel.textColor = DEFAULTTEXTCOLOR;
        self.orderNumberLabel.font = [UIFont systemFontOfSize:10.0];
        [self addSubview:self.orderNumberLabel];
        [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(7.5);
            make.left.equalTo(self.mas_left).with.offset(10.0);
            make.right.equalTo(self.mas_right).with.offset(-10.0);
            make.height.equalTo(@20.0);
        }];
    }
    return self;
}

@end
