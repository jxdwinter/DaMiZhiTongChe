//
//  Main_banner.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/3/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 首页条幅
 */
@interface Main_Banner : NSObject

/*
 "title": "广告标题",
 "imgurl": "广告图片",
 "linkurl": "链接地址",
 "content": "图文混排内容",
 "goods_id": "平台商品ID",
 "type": "0:链接 1:图文混排内容 2:平台商品"
 */

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *imgurl;
@property (nonatomic, copy)   NSString *linkurl;
@property (nonatomic, copy)   NSString *content;
@property (nonatomic, copy)   NSString *goods_id;
@property (nonatomic, copy)   NSString *type;

- (instancetype) initWithBannerInfo : (NSDictionary *) bannerInfo;

@end
