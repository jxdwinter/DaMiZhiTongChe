//
//  Cart_AddressTableViewCell.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/10/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Cart_AddressTableViewCell.h"

@implementation Cart_AddressTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.image = [UIImage imageNamed:@"goods_origin"];
        [self.contentView addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(30.0);
            make.left.equalTo(self.contentView.mas_left).with.offset(10.0);
            make.width.equalTo(@15.0);
            make.height.equalTo(@15.0);
        }];
        
        self.phoneLabel = [[UILabel alloc] init];
        self.phoneLabel.textColor = DEFAULTTEXTCOLOR;
        self.phoneLabel.font = [UIFont systemFontOfSize:12.0];
        self.phoneLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.phoneLabel];
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(10.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10.0);
            make.width.equalTo(@80.0);
            make.height.equalTo(@20.0);
        }];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = DEFAULTTEXTCOLOR;
        self.nameLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(10.0);
            make.left.equalTo(iconImageView.mas_right).with.offset(10.0);
            make.right.equalTo(self.phoneLabel.mas_left).with.offset(-10.0);
            make.height.equalTo(@20.0);
        }];
        
        self.addressLabel = [[UILabel alloc] init];
        [self.addressLabel setNumberOfLines:0];
        self.addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.addressLabel.textColor = DEFAULTTEXTCOLOR;
        self.addressLabel.font = [UIFont systemFontOfSize:10.0];
        [self.contentView addSubview:self.addressLabel];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.phoneLabel.mas_bottom).with.offset(5.0);
            make.left.equalTo(iconImageView.mas_right).with.offset(10.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10.0);
            make.height.equalTo(@30.0);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
