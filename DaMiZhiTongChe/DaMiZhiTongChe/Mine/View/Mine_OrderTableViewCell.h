//
//  Mine_OrderTableViewCell.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/17/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mine_OrderTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *ent_nameLabel;
@property (nonatomic, strong) UILabel *linkmodeLabel;

@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UILabel *goods_nameLabel;
@property (nonatomic, strong) UILabel *farmer_nameLabel;
@property (nonatomic, strong) UILabel *origin_nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UILabel *logistics_snLabel;

@end
