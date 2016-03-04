//
//  Main_Topic.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/3/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Main_Topic.h"

@implementation Main_Topic

- (instancetype) initWithTopicInfo : (NSDictionary *) topicInfo {
    self = [super init];
    if (self) {
        self._id = topicInfo[@"id"];
        self.imgurl = topicInfo[@"imgurl"];;
        self.name = topicInfo[@"name"];;
        self.des = topicInfo[@"des"];;
        self.goods = [[Main_Goods alloc] initWithGoodsInfo:topicInfo[@"goods"]];
    }
    return self;
}

@end
