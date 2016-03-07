//
//  Main_goodsListApi.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/7/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "ConfigYTKRequest.h"

@interface Main_goodsListApi : ConfigYTKRequest

- (instancetype) initWithCategory_id : (NSString *) category_id
                        withTopic_id : (NSString *) topic_id
                          withSearch : (NSString *) search
                        withPage_num : (NSString *) page_num;
@end
