//
//  Main_CategoryTableViewCell.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/4/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Main_CategoryTableViewCell.h"

@implementation Main_CategoryTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.picImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.picImageView];
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(0.0);
            make.left.equalTo(self.contentView.mas_left).with.offset(5.0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-5.0);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-5.0);
        }];
    }
    return self;
}

@end
