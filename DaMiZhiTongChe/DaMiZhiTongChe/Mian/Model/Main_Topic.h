//
//  Main_Topic.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/3/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Main_Goods.h"

/*
 首页专题
 */
@interface Main_Topic : NSObject


/*
 "id": "专题ID",
 "imgurl": "专题图片",
 "name": "专题名称",
 "des": "专题介绍",
 "goods": {
 
 }
 */

@property (nonatomic, copy)   NSString *_id;
@property (nonatomic, copy)   NSString *imgurl;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *des;
@property (nonatomic, strong)   Main_Goods *goods;

- (instancetype) initWithTopicInfo : (NSDictionary *) topicInfo;

@end
