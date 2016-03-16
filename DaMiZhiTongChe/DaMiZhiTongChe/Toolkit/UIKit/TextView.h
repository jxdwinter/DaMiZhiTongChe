//
//  TextView.h
//  TangPassport
//
//  Created by Xiaodong Jiang on 7/29/15.
//  Copyright (c) 2015 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextView : UITextView

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
