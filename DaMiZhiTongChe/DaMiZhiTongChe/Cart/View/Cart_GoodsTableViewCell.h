//
//  Cart_GoodsTableViewCell.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/9/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cart_GoodsTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *checkBoxButton;
@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UILabel *goods_nameLabel;
@property (nonatomic, strong) UILabel *farmer_nameLabel;
@property (nonatomic, strong) UILabel *origin_nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *numberLabel;

@end
