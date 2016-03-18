//
//  Main_GoodsDetailViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/7/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Main_GoodsDetailViewController.h"
#import "Main_getGoodsApi.h"
#import <SDCycleScrollView.h>
#import <MJRefresh.h>
#import "Main_GoodsDetail.h"
#import "BaseNavigationController.h"
#import "LoginViewController.h"
#import "Cart_addApi.h"
#import "Main_GoodsCommentViewController.h"
#import "Cart_goods.h"
#import "CartSettlementViewController.h"
#import "MineOrderViewController.h"
#import "WXApi.h"
#import <JGActionSheet.h>

@interface Main_GoodsDetailViewController () <UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) Main_GoodsDetail *goodsDetailInfo;
@property (nonatomic, strong) UILabel *goods_nameLabel;
@property (nonatomic, strong) UILabel *farmer_nameLabel;
@property (nonatomic, strong) UILabel *origin_nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIButton *plusButton;
@property (nonatomic, strong) UIButton *minusButton;
@property (nonatomic, strong) UIImageView *topicLine;
@property (nonatomic, strong) UIImageView *framerImageView;
@property (nonatomic, strong) UIImageView *originImageView;
@property (nonatomic, strong) UIImageView *brownRoundedCornerImageView;
@property (nonatomic, strong) UIImageView *whiteRoundedCornerImageView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *buyButton;
@property (nonatomic, strong) UIButton *cartButton;

@end

@implementation Main_GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:@"GOODDETAILSUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail) name:@"GOODDETAILCARTFAIL" object:nil];
    
    self.backButton.hidden = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    [self.view addSubview:self.bottomView];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(.0);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-50.0);
    }];
    
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    [self.contentView addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        make.height.equalTo(@(SCREEN_WIDTH/3));
    }];
    
    [self.contentView addSubview:self.infoView];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cycleScrollView.mas_bottom).with.offset(.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        make.height.equalTo(@(SCREEN_WIDTH/3));
    }];

    [self.infoView addSubview:self.goods_nameLabel];
    [self.goods_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView.mas_top).with.offset(5.0);
        make.left.equalTo(self.infoView.mas_left).with.offset(10.0);
        make.right.equalTo(self.infoView.mas_right).with.offset(-10.0);
        if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
            make.height.equalTo(@20.0);
        }else{
            make.height.equalTo(@30.0);
        }
    }];
    
    [self.infoView addSubview:self.topicLine];
    [self.topicLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goods_nameLabel.mas_bottom).with.offset(5.0);
        make.left.equalTo(self.infoView.mas_left).with.offset(10.0);
        make.width.equalTo(@150.0);
        make.height.equalTo(@2.5);
    }];
    
    [self.infoView addSubview:self.framerImageView];
    [self.framerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
            make.top.equalTo(_topicLine.mas_bottom).with.offset(5.0);
        }else{
            make.top.equalTo(_topicLine.mas_bottom).with.offset(10.0);
        }
        make.left.equalTo(self.contentView.mas_left).with.offset(10.0);
        make.width.equalTo(@10.0);
        make.height.equalTo(@10.0);
    }];

    [self.infoView addSubview:self.farmer_nameLabel];
    [self.farmer_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.framerImageView.mas_top).with.offset(0.0);
        make.left.equalTo(self.framerImageView.mas_right).with.offset(5.0);
        make.right.equalTo(self.infoView.mas_right).with.offset(-10.0);
        make.height.equalTo(@10.0);
    }];
    
    [self.infoView addSubview:self.originImageView];
    [self.originImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
            make.top.equalTo(self.framerImageView.mas_bottom).with.offset(5.0);
        }else{
            make.top.equalTo(self.framerImageView.mas_bottom).with.offset(10.0);
        }
        make.left.equalTo(self.infoView.mas_left).with.offset(10.0);
        make.width.equalTo(@10.0);
        make.height.equalTo(@10.0);
    }];

    [self.infoView addSubview:self.origin_nameLabel];
    [self.origin_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.originImageView.mas_top).with.offset(0.0);
        make.left.equalTo(self.originImageView.mas_right).with.offset(5.0);
        make.right.equalTo(self.infoView.mas_right).with.offset(-10.0);
        make.height.equalTo(@10.0);
    }];
    
    [self.infoView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.originImageView.mas_bottom).with.offset(8.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(8.0);
        make.width.equalTo(@(SCREEN_WIDTH/2));
        make.bottom.equalTo(self.infoView.mas_bottom).with.offset(0.0);
    }];
    
    self.brownRoundedCornerImageView = [[UIImageView alloc] init];
    self.brownRoundedCornerImageView.userInteractionEnabled = YES;
    self.brownRoundedCornerImageView.backgroundColor = DEFAULTBROWNCOLOR;
    self.brownRoundedCornerImageView.hidden = YES;
    CALayer * brownRoundedCornerImageViewLayer = [self.brownRoundedCornerImageView layer];
    [brownRoundedCornerImageViewLayer setMasksToBounds:YES];
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
        [brownRoundedCornerImageViewLayer setCornerRadius:17.0];
    }else if (IS_IPHONE_6){
        [brownRoundedCornerImageViewLayer setCornerRadius:17.0];
    }else{
        [brownRoundedCornerImageViewLayer setCornerRadius:20.0];
    }
    
    [self.infoView addSubview:self.brownRoundedCornerImageView];
    [self.brownRoundedCornerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.originImageView.mas_bottom).with.offset(8.0);
        make.left.equalTo(self.priceLabel.mas_right).with.offset(25.0);
        make.right.equalTo(self.infoView.mas_right).with.offset(-25.0);
        if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
            make.height.equalTo(@34.0);
        }else if (IS_IPHONE_6){
            make.height.equalTo(@34.0);
        }else {
            make.height.equalTo(@40.0);
        }
    }];
    
    self.whiteRoundedCornerImageView = [[UIImageView alloc] init];
    self.whiteRoundedCornerImageView.backgroundColor = [UIColor whiteColor];
    CALayer * whiteRoundedCornerImageViewLayer = [self.whiteRoundedCornerImageView layer];
    [whiteRoundedCornerImageViewLayer setCornerRadius:10.0];
    [self.brownRoundedCornerImageView addSubview:self.whiteRoundedCornerImageView];
    [self.whiteRoundedCornerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.brownRoundedCornerImageView.mas_top).with.offset(4.0);
        make.centerX.equalTo(self.brownRoundedCornerImageView.mas_centerX).with.offset(0.0);
        make.centerY.equalTo(self.brownRoundedCornerImageView.mas_centerY).with.offset(0.0);
        make.bottom.equalTo(self.brownRoundedCornerImageView.mas_bottom).with.offset(-4.0);
        make.width.equalTo(@60.0);
    }];
    
    [self.brownRoundedCornerImageView addSubview:self.plusButton];
    [self.plusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.brownRoundedCornerImageView.mas_top).with.offset(5.0);
        make.left.equalTo(self.whiteRoundedCornerImageView.mas_right).with.offset(0.0);
        make.right.equalTo(self.brownRoundedCornerImageView.mas_right).with.offset(-5.0);
        make.bottom.equalTo(self.brownRoundedCornerImageView.mas_bottom).with.offset(-5.0);
    }];
    
    [self.brownRoundedCornerImageView addSubview:self.minusButton];
    [self.minusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.brownRoundedCornerImageView.mas_top).with.offset(5.0);
        make.left.equalTo(self.brownRoundedCornerImageView.mas_left).with.offset(5.0);
        make.right.equalTo(self.whiteRoundedCornerImageView.mas_left).with.offset(0.0);
        make.bottom.equalTo(self.brownRoundedCornerImageView.mas_bottom).with.offset(-5.0);
    }];
    
    [self.whiteRoundedCornerImageView addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteRoundedCornerImageView.mas_top).with.offset(0.0);
        make.left.equalTo(self.whiteRoundedCornerImageView.mas_left).with.offset(0.0);
        make.right.equalTo(self.whiteRoundedCornerImageView.mas_right).with.offset(0.0);
        make.bottom.equalTo(self.whiteRoundedCornerImageView.mas_bottom).with.offset(0.0);
    }];
    
    [self.contentView addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView.mas_bottom).with.offset(.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
    }];
    [self getGoodsDetailInfoWithShowShouldShowHUD:YES];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GOODDETAILSUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GOODDETAILCARTFAIL" object:nil];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
    float nativeHight = webView.frame.size.height;
    NSString *output = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
    float jsHight = [output floatValue];
    float height = nativeHight >= jsHight ? nativeHight : jsHight;
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView.mas_bottom).with.offset(.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        make.height.equalTo(@(height));
    }];
    self.scrollView.contentSize = CGSizeMake(self.contentView.frame.size.width,
                                             SCREEN_WIDTH/3*2 + height);
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(webView.mas_bottom).with.offset(0.0);
    }];
    [self.scrollView.mj_header endRefreshing];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    NSLog(@"%@",[error description]);
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.goodsDetailInfo.detail_url]]];
}

#pragma mark - privete method

- (void) payFail {
    MineOrderViewController *mineOrderViewController = [[MineOrderViewController alloc] init];
    mineOrderViewController.selectIndex = 0;
    [self.navigationController pushViewController:mineOrderViewController animated:YES];
}

- (void) paySuccess {
    MineOrderViewController *mineOrderViewController = [[MineOrderViewController alloc] init];
    mineOrderViewController.selectIndex = 1;
    [self.navigationController pushViewController:mineOrderViewController animated:YES];
}

- (void) loadData {
    [self getGoodsDetailInfoWithShowShouldShowHUD:NO];
}

- (void) getGoodsDetailInfoWithShowShouldShowHUD : (BOOL) shouldShowHUD {
    Main_getGoodsApi *api = [[Main_getGoodsApi alloc] initWithGoods_id:self.goods_id];
    if (shouldShowHUD) {
        RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
        [api addAccessory:accessory];
    }
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
        if (dic) {
            if ([dic[@"result"] isEqualToString:@"0"]) {
                self.goodsDetailInfo = [[Main_GoodsDetail alloc] initWithGoodsDetailInfo:dic[@"data"]];
                [self configUI];
            }else{
                [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
            }
        }
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

- (void) shareToWeiXin {
    JGActionSheetSection *section = [JGActionSheetSection sectionWithTitle:@"分享微信" message:@"" buttonTitles:@[@"好友",@"朋友圈"] buttonStyle:JGActionSheetButtonStyleDefault];
    section.titleLabel.textColor = DEFAULTTEXTCOLOR;
    section.titleLabel.font = DEFAULFONT;
    JGActionSheetSection *cancelSection = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleCancel];
    NSArray *sections = @[section,cancelSection];
    JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
    [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
        [sheet dismissAnimated:YES];
        if (indexPath.section == 0 && indexPath.row == 0) {
            if([WXApi isWXAppInstalled]){
                [self shareToSession];
            }
            else{
                [MBProgressHUD showHUDwithSuccess:NO WithTitle:@"没有安装微信" withView:self.navigationController.view];
            }
        }else if (indexPath.section == 0 && indexPath.row == 1){
            if([WXApi isWXAppInstalled]){
                [self shareToTimeline];
            }else{
                [MBProgressHUD showHUDwithSuccess:NO WithTitle:@"没有安装微信" withView:self.navigationController.view];
            }
        }
    }];
    [sheet showInView:self.navigationController.view animated:YES];
}

- (void) shareToSession {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.goodsDetailInfo.goods.goods_name;
    message.description = @"向您推荐好大米";
    NSData *data = UIImageJPEGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/1/w/50/h/50",self.goodsDetailInfo.goods.imgurl]]]], 0.5);
    UIImage *image = [UIImage imageWithData:data];
    [message setThumbImage:image];
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = self.goodsDetailInfo.share_url;
    message.mediaObject = ext;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
}

- (void) shareToTimeline {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.goodsDetailInfo.goods.goods_name;
    message.description = @"向您推荐好大米";
    NSData *data = UIImageJPEGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/1/w/50/h/50",self.goodsDetailInfo.goods.imgurl]]]], 0.5);
    UIImage *image = [UIImage imageWithData:data];
    [message setThumbImage:image];
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = self.goodsDetailInfo.share_url;
    message.mediaObject = ext;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
}

- (void) configUI {
    self.topicLine.hidden = NO;
    self.framerImageView.hidden = NO;
    self.originImageView.hidden = NO;
    self.brownRoundedCornerImageView.hidden = NO;
    self.cycleScrollView.imageURLStringsGroup = self.goodsDetailInfo.imgs;
    self.goods_nameLabel.text = self.goodsDetailInfo.goods.goods_name;
    self.farmer_nameLabel.text = [NSString stringWithFormat:@"农户:%@",self.goodsDetailInfo.goods.farmer_name];
    self.origin_nameLabel.text = [NSString stringWithFormat:@"产地:%@",self.goodsDetailInfo.goods.origin_name];
    NSString *string = [NSString stringWithFormat:@"￥%@    原价￥%@",self.goodsDetailInfo.goods.goods_price,self.goodsDetailInfo.goods.market_price];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
    [attr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlinePatternSolid | NSUnderlineStyleSingle] range:[string rangeOfString:[NSString stringWithFormat:@"￥%@",self.goodsDetailInfo.goods.market_price]]];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10.0] range:[string rangeOfString:[NSString stringWithFormat:@"原价￥%@",self.goodsDetailInfo.goods.market_price]]];
    self.priceLabel.attributedText = attr;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.goodsDetailInfo.detail_url]]];
}

- (void) gotoCommentViewController {
    //Main_GoodsCommentViewController *main_GoodsCommentViewController = [[Main_GoodsCommentViewController alloc] init];
    //[self.navigationController pushViewController:main_GoodsCommentViewController animated:YES];
    /*
      */
}

- (void) plus {
    NSUInteger number = [self.numberLabel.text integerValue];
    number++;
    self.numberLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)number];
}

- (void) minus {
    NSUInteger number = [self.numberLabel.text integerValue];
    number--;
    if (number < 1) {
        number = 1;
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)number];
}

- (void) buy {
    if (![[AccountManager sharedAccountManager] getCurrentUser]) {
        [self presentLoginViewController];
    }else{
        Cart_goods *cart_goods = [[Cart_goods alloc] init];
        cart_goods.goods = self.goodsDetailInfo.goods;
        cart_goods.counts = self.numberLabel.text;
        cart_goods.isChecked = NO;
        NSMutableArray *dataSource = [[NSMutableArray alloc] initWithCapacity:1];
        [dataSource addObject:cart_goods];
        CartSettlementViewController *cartSettlementViewController = [[CartSettlementViewController alloc] init];
        cartSettlementViewController.dataSource = dataSource;
        cartSettlementViewController.allPrice = [self.goodsDetailInfo.goods.goods_price doubleValue] * [self.numberLabel.text integerValue];
        cartSettlementViewController.type = 1;
        [self.navigationController pushViewController:cartSettlementViewController animated:YES];
    }
}

- (void) cart {
    if (![[AccountManager sharedAccountManager] getCurrentUser]) {
        [self presentLoginViewController];
    }else{
        Cart_addApi *api = [[Cart_addApi alloc] initWithGoods_id:self.goods_id withCounts:self.numberLabel.text];
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
            if (dic) {
                if ([dic[@"result"] isEqualToString:@"0"]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"RELOADCART" object:nil];
                    [MBProgressHUD showHUDwithSuccess:YES WithTitle:dic[@"msg"] withView:self.navigationController.view];
                }else{
                    [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
                }
            }
        } failure:^(YTKBaseRequest *request) {
            
        }];
    }
}
/*
 * 弹出登录页面
 */
- (void) presentLoginViewController {
    [self.navigationController presentViewController:[[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]]
                                            animated:YES
                                          completion:^{
        
    }];
}

#pragma mark - getter and setter

- (UIScrollView *) scrollView {
    if (!_scrollView) {
        MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"好大米马上来..." forState:MJRefreshStateRefreshing];
        header.stateLabel.font = [UIFont systemFontOfSize:14];
        header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:10];
        header.stateLabel.textColor = DEFAULTBROWNCOLOR;
        header.lastUpdatedTimeLabel.textColor = DEFAULTBROWNCOLOR;
        header.lastUpdatedTimeLabel.hidden = YES;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.delegate = self;
        _scrollView.mj_header = header;
    }
    return _scrollView;
}

- (UIView *) contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    }
    return _contentView;
}

- (UIButton *) rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
        [_rightButton addTarget:self action:@selector(shareToWeiXin) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton setImage:[UIImage imageNamed:@"main_share"] forState:UIControlStateNormal];
    }
    return _rightButton;
}

- (SDCycleScrollView *) cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:nil placeholderImage:nil];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.currentPageDotColor = DEFAULTBROWNCOLOR;
        _cycleScrollView.pageDotColor = [UIColor whiteColor];
        _cycleScrollView.autoScrollTimeInterval = 10;
    }
    return _cycleScrollView;
}

- (UIView *) infoView {
    if (!_infoView) {
        _infoView = [[UIView alloc] initWithFrame:CGRectZero];
        _infoView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    }
    return _infoView;
}

- (UIWebView *) webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        _webView.scrollView.scrollEnabled = NO;
        _webView.delegate = self;
    }
    return _webView;
}

- (UILabel *) goods_nameLabel {
    if (!_goods_nameLabel) {
        _goods_nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _goods_nameLabel.textColor = DEFAULTTEXTCOLOR;
        _goods_nameLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _goods_nameLabel;
}

- (UILabel *) farmer_nameLabel {
    if (!_farmer_nameLabel) {
        _farmer_nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _farmer_nameLabel.textColor = DEFAULTGRAYCOLOR;
        _farmer_nameLabel.font = [UIFont systemFontOfSize:10.0];
    }
    return _farmer_nameLabel;
}

- (UILabel *) origin_nameLabel {
    if (!_origin_nameLabel) {
        _origin_nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _origin_nameLabel.textColor = DEFAULTGRAYCOLOR;
        _origin_nameLabel.font = [UIFont systemFontOfSize:10.0];
    }
    return _origin_nameLabel;
}

- (UILabel *) priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = DEFAULTBROWNCOLOR;
        _priceLabel.font = [UIFont systemFontOfSize:18.0];
    }
    return _priceLabel;
}

- (UILabel *) numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textColor = DEFAULTBROWNCOLOR;
        _numberLabel.font = [UIFont systemFontOfSize:12.0];
        _numberLabel.text = @"1";
        _numberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLabel;
}

- (UIButton *) plusButton {
    if (!_plusButton) {
        _plusButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_plusButton setTitle:@"+" forState:UIControlStateNormal];
        [_plusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_plusButton addTarget:self action:@selector(plus) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusButton;
}

- (UIButton *) minusButton {
    if (!_minusButton) {
        _minusButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_minusButton setTitle:@"-" forState:UIControlStateNormal];
        [_minusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_minusButton addTarget:self action:@selector(minus) forControlEvents:UIControlEventTouchUpInside];
    }
    return _minusButton;
}

- (UIImageView *) topicLine {
    if (!_topicLine) {
        _topicLine = [[UIImageView alloc] init];
        _topicLine.image = [UIImage imageNamed:@"topic_line"];
        _topicLine.hidden = YES;
    }
    return _topicLine;
}

- (UIImageView *) framerImageView {
    if (!_framerImageView) {
        _framerImageView = [[UIImageView alloc] init];
        _framerImageView.image = [UIImage imageNamed:@"goods_framer"];
        _framerImageView.hidden = YES;
    }
    return _framerImageView;
}

- (UIImageView *) originImageView {
    if (!_originImageView) {
        _originImageView = [[UIImageView alloc] init];
        _originImageView.image = [UIImage imageNamed:@"goods_origin"];
        _originImageView.hidden = YES;
    }
    return _originImageView;
}

- (UIView *) bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT - NAVIGATIONBARHEIGHT - 50.0, SCREEN_WIDTH, 50.0)];
        _bottomView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [_bottomView addSubview:self.buyButton];
        [_bottomView addSubview:self.cartButton];
    }
    return _bottomView;
}

- (UIButton *) buyButton {
    if (!_buyButton) {
        _buyButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0, 5.0, (SCREEN_WIDTH - 30.0)/2, 40.0)];
        [_buyButton.layer setMasksToBounds:YES];
        [_buyButton.layer setCornerRadius:20.0];
        [_buyButton addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
        _buyButton.titleLabel.font = DEFAULFONT;
        _buyButton.backgroundColor = [UIColor colorWithRed:0.98 green:0.65 blue:0.25 alpha:1];
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    }
    return _buyButton;
}

- (UIButton *) cartButton {
    if (!_cartButton) {
        _cartButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 + 5.0, 5.0, (SCREEN_WIDTH - 30.0)/2, 40.0)];
        [_cartButton.layer setMasksToBounds:YES];
        [_cartButton.layer setCornerRadius:20.0];
        [_cartButton addTarget:self action:@selector(cart) forControlEvents:UIControlEventTouchUpInside];
        _cartButton.titleLabel.font = DEFAULFONT;
        _cartButton.backgroundColor = [UIColor colorWithRed:0.99 green:0.37 blue:0.37 alpha:1];
        [_cartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    }
    return _cartButton;
}

@end
