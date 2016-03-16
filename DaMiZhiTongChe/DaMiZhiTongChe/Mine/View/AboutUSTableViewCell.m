//
//  AboutUSTableViewCell.m
//  TangPassport
//
//  Created by Xiaodong Jiang on 7/31/15.
//  Copyright (c) 2015 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "AboutUSTableViewCell.h"

@implementation AboutUSTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = DEFAULTTEXTCOLOR;
        self.titleLabel.font = DEFAULFONT;
        [self.titleLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(15.0);
            make.left.equalTo(self.contentView.mas_left).with.offset(15.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-15.0);
            make.height.equalTo(@20.0);
        }];
        
    }
    return self;
}

@end
