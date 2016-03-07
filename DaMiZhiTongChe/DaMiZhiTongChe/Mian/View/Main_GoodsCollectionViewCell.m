//
//  Main_GoodsCollectionViewCell.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/7/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Main_GoodsCollectionViewCell.h"

@implementation Main_GoodsCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIImageView *rightLine = [[UIImageView alloc] init];
        rightLine.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [self.contentView addSubview:rightLine];
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(0.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
            make.width.equalTo(@4.0);
            make.height.equalTo(@(self.contentView.frame.size.height));
        }];
        UIImageView *bottomLine = [[UIImageView alloc] init];
        bottomLine.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [self.contentView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
            make.height.equalTo(@4.0);
        }];
        self.goodsImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(5.0);
            make.left.equalTo(self.contentView.mas_left).with.offset(10.0);
            make.right.equalTo(rightLine.mas_left).with.offset(-10.0);
            make.height.equalTo(@((SCREEN_WIDTH/2-30.0)*2/3));
        }];
        self.goods_nameLabel = [[UILabel alloc] init];
        self.goods_nameLabel.textColor = DEFAULTTEXTCOLOR;
        self.goods_nameLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:self.goods_nameLabel];
        [self.goods_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodsImageView.mas_bottom).with.offset(5.0);
            make.left.equalTo(self.contentView.mas_left).with.offset(10.0);
            make.right.equalTo(rightLine.mas_left).with.offset(-10.0);
            make.height.equalTo(@20.0);
        }];
        UIImageView *framerImageView = [[UIImageView alloc] init];
        framerImageView.image = [UIImage imageNamed:@"goods_framer"];
        [self.contentView addSubview:framerImageView];
        [framerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goods_nameLabel.mas_bottom).with.offset(5.0);
            make.left.equalTo(self.contentView.mas_left).with.offset(10.0);
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
            make.right.equalTo(rightLine.mas_left).with.offset(-10.0);
            make.height.equalTo(@10.0);
        }];
        UIImageView *originImageView = [[UIImageView alloc] init];
        originImageView.image = [UIImage imageNamed:@"goods_origin"];
        [self.contentView addSubview:originImageView];
        [originImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(framerImageView.mas_bottom).with.offset(5.0);
            make.left.equalTo(self.contentView.mas_left).with.offset(10.0);
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
            make.right.equalTo(rightLine.mas_left).with.offset(-10.0);
            make.height.equalTo(@10.0);
        }];
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.textColor = DEFAULTBROWNCOLOR;
        self.priceLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(originImageView.mas_bottom).with.offset(8.0);
            make.left.equalTo(self.contentView.mas_left).with.offset(8.0);
            make.right.equalTo(rightLine.mas_left).with.offset(-10.0);
            make.height.equalTo(@20.0);
        }];

    }
    return self;
}

@end
