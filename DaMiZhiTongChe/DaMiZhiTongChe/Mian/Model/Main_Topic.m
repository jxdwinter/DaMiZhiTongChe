//
//  Main_Topic.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/3/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Main_Topic.h"
#import "Main_Goods.h"

@implementation Main_Topic

- (instancetype) initWithTopicInfo : (NSDictionary *) topicInfo {
    self = [super init];
    if (self) {
        self._id = topicInfo[@"id"];
        self.imgurl = topicInfo[@"imgurl"];;
        self.name = topicInfo[@"name"];;
        self.des = topicInfo[@"des"];;
        NSMutableArray *tmpGoods = [[NSMutableArray alloc] initWithCapacity:1];
        for (NSDictionary *dic in topicInfo[@"goods"]) {
            Main_Goods *goods = [[Main_Goods alloc] initWithGoodsInfo:dic];
            if (goods) {
                [tmpGoods addObject:goods];
            }
        }
        self.goods = [tmpGoods copy];
    }
    return self;
}

@end
