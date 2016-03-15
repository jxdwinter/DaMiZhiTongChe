//
//  CartAddressListViewController.h
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/10/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "BaseViewController.h"

@class Cart_address;

@protocol SelectAddressDelegate <NSObject>

@required
- (void) setDefaultAdressWithAddress : (Cart_address *) address;

@end

@interface CartAddressListViewController : BaseViewController

//标记从哪个页面来此页
//0订单页面,只能选择
//1地址管理页面,修改
@property (nonatomic, assign) int type;
@property (nonatomic, weak) id<SelectAddressDelegate> selectAddressDelegate;

@end
