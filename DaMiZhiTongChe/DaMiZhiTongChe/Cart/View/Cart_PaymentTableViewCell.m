//
//  Cart_PaymentTableViewCell.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/10/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Cart_PaymentTableViewCell.h"

@implementation Cart_PaymentTableViewCell

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
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0.0);
            make.height.equalTo(@.5);
        }];
        self.checkBoxButton = [[UIButton alloc] init];
        [self.contentView addSubview:self.checkBoxButton];
        [self.checkBoxButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(10.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10.0);
            make.width.equalTo(@30.0);
            make.height.equalTo(@30.0);
        }];
        
        self.iconImagView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconImagView];
        [self.iconImagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(10.0);
            make.left.equalTo(self.contentView.mas_left).with.offset(10.0);
            make.width.equalTo(@30.0);
            make.height.equalTo(@30.0);
        }];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = DEFAULTTEXTCOLOR;
        self.nameLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(15.0);
            make.left.equalTo(self.iconImagView.mas_right).with.offset(10.0);
            make.right.equalTo(self.checkBoxButton.mas_left).with.offset(-10.0);
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
