//
//  DatabaseHelper.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/3/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKKeyValueStore.h>

@interface DatabaseHelper : NSObject

- (YTKKeyValueStore *) store;

@end
