//
//  Mine_OrderTableViewCell.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/17/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Mine_OrderTableViewCell.h"

@implementation Mine_OrderTableViewCell

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
        
        self.linkmodeLabel = [[UILabel alloc] init];
        self.linkmodeLabel.textColor = DEFAULTTEXTCOLOR;
        self.linkmodeLabel.font = [UIFont systemFontOfSize:10.0];
        self.linkmodeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.linkmodeLabel];
        [self.linkmodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(12.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10.0);
            make.width.equalTo(@120.0);
            make.height.equalTo(@20.0);
        }];
        
        self.ent_nameLabel = [[UILabel alloc] init];
        self.ent_nameLabel.textColor = DEFAULTTEXTCOLOR;
        self.ent_nameLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:self.ent_nameLabel];
        [self.ent_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(10.0);
            make.left.equalTo(self.contentView.mas_left).with.offset(10.0);
            make.right.equalTo(self.linkmodeLabel.mas_left).with.offset(-10.0);
            make.height.equalTo(@20.0);
        }];
        
        self.goodsImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(40.0);
            make.left.equalTo(self.contentView.mas_left).with.offset(10.0);
            make.width.equalTo(@120.0);
            make.height.equalTo(@80.0);
        }];
        
        self.goods_nameLabel = [[UILabel alloc] init];
        self.goods_nameLabel.textColor = DEFAULTTEXTCOLOR;
        self.goods_nameLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:self.goods_nameLabel];
        [self.goods_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(38.0);
            make.left.equalTo(self.goodsImageView.mas_right).with.offset(10.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10.0);
            make.height.equalTo(@20.0);
        }];
        
        UIImageView *framerImageView = [[UIImageView alloc] init];
        framerImageView.image = [UIImage imageNamed:@"goods_framer"];
        [self.contentView addSubview:framerImageView];
        [framerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goods_nameLabel.mas_bottom).with.offset(10.0);
            make.left.equalTo(self.goodsImageView.mas_right).with.offset(10.0);
            make.width.equalTo(@10.0);
            make.height.equalTo(@10.0);
        }];
        self.farmer_nameLabel = [[UILabel alloc] init];
        self.farmer_nameLabel.textColor = DEFAULTGRAYCOLOR;
        self.farmer_nameLabel.font = [UIFont systemFontOfSize:10.0];
        [self.contentView addSubview:self.farmer_nameLabel];
        [self.farmer_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(framerImageView.mas_top).with.offset(0.0);
            make.left.equalTo(framerImageView.mas_right).with.offset(5.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10.0);
            make.height.equalTo(@10.0);
        }];
        UIImageView *originImageView = [[UIImageView alloc] init];
        originImageView.image = [UIImage imageNamed:@"goods_origin"];
        [self.contentView addSubview:originImageView];
        [originImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(framerImageView.mas_bottom).with.offset(5.0);
            make.left.equalTo(self.goodsImageView.mas_right).with.offset(10.0);
            make.width.equalTo(@10.0);
            make.height.equalTo(@10.0);
        }];
        self.origin_nameLabel = [[UILabel alloc] init];
        self.origin_nameLabel.textColor = DEFAULTGRAYCOLOR;
        self.origin_nameLabel.font = [UIFont systemFontOfSize:10.0];
        [self.contentView addSubview:self.origin_nameLabel];
        [self.origin_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(originImageView.mas_top).with.offset(0.0);
            make.left.equalTo(originImageView.mas_right).with.offset(5.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10.0);
            make.height.equalTo(@10.0);
        }];
        
        self.numberLabel = [[UILabel alloc] init];
        self.numberLabel.textColor = DEFAULTGRAYCOLOR;
        self.numberLabel.font = [UIFont systemFontOfSize:10.0];
        self.numberLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.numberLabel];
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(originImageView.mas_bottom).with.offset(15.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10.0);
            make.width.equalTo(@50.0);
            make.height.equalTo(@20.0);
        }];
        
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.textColor = DEFAULTBROWNCOLOR;
        self.priceLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(originImageView.mas_bottom).with.offset(10.0);
            make.left.equalTo(self.goodsImageView.mas_right).with.offset(10.0);
            make.right.equalTo(self.numberLabel.mas_left).with.offset(-10.0);
            make.height.equalTo(@20.0);
        }];
        
        self.logistics_snLabel = [[UILabel alloc] init];
        self.logistics_snLabel.textColor = DEFAULTTEXTCOLOR;
        self.logistics_snLabel.font = [UIFont systemFontOfSize:8.0];
        [self.contentView addSubview:self.logistics_snLabel];
        [self.logistics_snLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.priceLabel.mas_bottom).with.offset(5.0);
            make.left.equalTo(self.contentView.mas_left).with.offset(10.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10.0);
            make.height.equalTo(@10.0);
        }];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
