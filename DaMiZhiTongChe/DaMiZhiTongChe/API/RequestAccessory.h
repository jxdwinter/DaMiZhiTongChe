//
//  RequestAccessory.h
//  TangPassport
//
//  Created by Xiaodong Jiang on 8/6/15.
//  Copyright (c) 2015 黑龙江龙卫中新医药连锁有限公司. All rights reserved.
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
