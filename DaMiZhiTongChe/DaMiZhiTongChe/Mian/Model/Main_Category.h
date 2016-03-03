//
//  Main_Category.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/3/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 首页分类
 */
@interface Main_Category : NSObject

/*
 "id": "分类ID",
 "category_name": "分类名称",
 "category_image": "分类图片"
 */

@property (nonatomic, copy)   NSString *_id;
@property (nonatomic, copy)   NSString *category_name;
@property (nonatomic, copy)   NSString *category_image;

- (instancetype) initWithCategoryInfo : (NSDictionary *) categoryInfo;

@end
