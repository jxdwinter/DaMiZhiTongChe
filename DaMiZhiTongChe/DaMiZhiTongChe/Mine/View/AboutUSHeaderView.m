//
//  AboutUSHeaderView.m
//  TangPassport
//
//  Created by Xiaodong Jiang on 7/31/15.
//  Copyright (c) 2015 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "AboutUSHeaderView.h"

@implementation AboutUSHeaderView

- (instancetype) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.image = [UIImage imageNamed:@"icon"];
        [self addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).with.offset(-5.0);
            make.width.equalTo(@60.0);
            make.height.equalTo(@60.0);
        }];
        
        UILabel *versionLabel = [[UILabel alloc] init];
        versionLabel.textAlignment = NSTextAlignmentCenter;
        versionLabel.textColor = DEFAULTTEXTCOLOR;
        versionLabel.font = [UIFont systemFontOfSize:10.0];
        [versionLabel sizeToFit];
        versionLabel.text = [NSString stringWithFormat:@"版本号:%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        [self addSubview:versionLabel];
        [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconImageView.mas_bottom).with.offset(5.0);
            make.left.equalTo(self.mas_left).with.offset(10.0);
            make.right.equalTo(self.mas_right).with.offset(-10.0);
            make.height.equalTo(@20.0);
        }];
        
    }
    return self;
}

@end
