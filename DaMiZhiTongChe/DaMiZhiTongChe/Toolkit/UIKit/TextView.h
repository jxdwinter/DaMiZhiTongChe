//
//  TextView.h
//  TangPassport
//
//  Created by Xiaodong Jiang on 7/29/15.
//  Copyright (c) 2015 黑龙江龙卫中新医药连锁有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextView : UITextView

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
