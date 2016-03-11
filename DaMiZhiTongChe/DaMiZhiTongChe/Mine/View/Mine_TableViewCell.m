//
//  Mine_TableViewCell.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/11/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Mine_TableViewCell.h"

@implementation Mine_TableViewCell


- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIImageView *lineImageView = [[UIImageView alloc] init];
        lineImageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [self.contentView addSubview:lineImageView];
        [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-.5);
            make.height.equalTo(@.5);
        }];
        self.iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(15.0);
            make.left.equalTo(self.contentView.mas_left).with.offset(10.0);
            make.width.equalTo(@20.0);
            make.height.equalTo(@20.0);
        }];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = DEFAULTTEXTCOLOR;
        self.titleLabel.font = DEFAULFONT;
        [self.titleLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(15.0);
            make.left.equalTo(self.iconImageView.mas_right).with.offset(10.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10.0);
            make.height.equalTo(@20.0);
        }];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
