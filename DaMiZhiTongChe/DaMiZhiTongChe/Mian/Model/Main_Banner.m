//
//  Main_banner.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/3/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Main_Banner.h"

@implementation Main_Banner

- (instancetype) initWithBannerInfo : (NSDictionary *) bannerInfo {
    self = [super init];
    if (self) {
        self.title = bannerInfo[@"title"];
        self.imgurl = bannerInfo[@"imgurl"];
        self.linkurl = bannerInfo[@"linkurl"];
        self.content = bannerInfo[@"content"];
        self.goods_id = bannerInfo[@"goods_id"];
        self.type = bannerInfo[@"type"];
    }
    return self;
}

@end
