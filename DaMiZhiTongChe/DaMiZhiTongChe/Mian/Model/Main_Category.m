//
//  Main_Category.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/3/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Main_Category.h"

@implementation Main_Category

- (instancetype) initWithCategoryInfo : (NSDictionary *) categoryInfo {
    self = [super init];
    if (self) {
        self._id = categoryInfo[@"id"];
        self.category_name = categoryInfo[@"category_name"];
        self.category_image = categoryInfo[@"category_image"];
    }
    return self;
}

@end
