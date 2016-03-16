//
//  RequestAccessory.h
//  TangPassport
//
//  Created by Xiaodong Jiang on 8/6/15.
//  Copyright (c) 2015 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKBaseRequest.h>

@interface RequestAccessory : NSObject<YTKRequestAccessory>

@property (nonatomic,strong) UIView *view;

- (void)requestWillStart:(id)request;
- (void)requestWillStop:(id)request;
- (void)requestDidStop:(id)request;

- (instancetype) initAccessoryWithView : (UIView *)view;

@end
