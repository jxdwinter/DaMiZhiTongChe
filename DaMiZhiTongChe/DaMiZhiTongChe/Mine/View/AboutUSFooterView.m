//
//  AboutUSFooterView.m
//  TangPassport
//
//  Created by Xiaodong Jiang on 7/31/15.
//  Copyright (c) 2015 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "AboutUSFooterView.h"

@implementation AboutUSFooterView

- (instancetype) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UILabel *versionLabel = [[UILabel alloc] init];
        versionLabel.textAlignment = NSTextAlignmentCenter;
        versionLabel.textColor = DEFAULTTEXTCOLOR;
        versionLabel.font = [UIFont systemFontOfSize:10.0];
        [versionLabel sizeToFit];
        versionLabel.text = [NSString stringWithFormat:@"Copyright©2016 哈尔滨市龙卫中新工贸有限责任公司"];
        [self addSubview:versionLabel];
        [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(10.0);
            make.left.equalTo(self.mas_left).with.offset(10.0);
            make.right.equalTo(self.mas_right).with.offset(-10.0);
            make.height.equalTo(@20.0);
        }];
        
    }
    return self;
}

@end
