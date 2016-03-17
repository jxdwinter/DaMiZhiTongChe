//
//  Mine_enterprise.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/17/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mine_enterprise : NSObject

@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *linkmode;
@property (nonatomic, strong) NSArray *goods_list;

- (instancetype) initWitEnterpriseInfo : (NSDictionary *) enterpriseInfo;

@end
