//
//  Main_goodsListApi.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/7/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Main_goodsListApi.h"

@interface Main_goodsListApi ()

@property (nonatomic, copy) NSString *category_id;
@property (nonatomic, copy) NSString *topic_id;
@property (nonatomic, copy) NSString *search;
@property (nonatomic, copy) NSString *page_num;

@end

@implementation Main_goodsListApi

- (instancetype) initWithCategory_id : (NSString *) category_id
                        withTopic_id : (NSString *) topic_id
                          withSearch : (NSString *) search
                        withPage_num : (NSString *) page_num {
    self = [super init];
    if (self) {
        self.category_id = category_id;
        self.topic_id = topic_id;
        self.search = search;
        self.page_num = page_num;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/Goods";
}

- (id)requestArgument {
    return [ConfigArgument configArgument:@{
                                            @"action" : @"goodsList",
                                            @"category_id" : self.category_id,
                                            @"topic_id" : self.topic_id,
                                            @"search" : self.search,
                                            @"page_num" : self.page_num,
                                            @"page_size" : [NSString stringWithFormat:@"%ld",(long)PAGENUMBER]
                                            }];
}

@end
