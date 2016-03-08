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

@interface Main_GoodsDetailViewController () <UIWebViewDelegate>

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

@end

@implementation Main_GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(.0);
        make.left.equalTo(self.view.mas_left).with.offset(0.0);
        make.right.equalTo(self.view.mas_right).with.offset(0.0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0);
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
        make.left.equalTo(self.priceLabel.mas_right).with.offset(10.0);
        make.right.equalTo(self.infoView.mas_right).with.offset(-10.0);
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
        make.left.equalTo(self.brownRoundedCornerImageView.mas_left).with.offset(35.0);
        make.right.equalTo(self.brownRoundedCornerImageView.mas_right).with.offset(-35.0);
        make.bottom.equalTo(self.brownRoundedCornerImageView.mas_bottom).with.offset(-4.0);
    }];
    
    [self.brownRoundedCornerImageView addSubview:self.plusButton];
    [self.plusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.brownRoundedCornerImageView.mas_top).with.offset(5.0);
        make.left.equalTo(self.whiteRoundedCornerImageView.mas_right).with.offset(5.0);
        make.right.equalTo(self.brownRoundedCornerImageView.mas_right).with.offset(-5.0);
        make.bottom.equalTo(self.brownRoundedCornerImageView.mas_bottom).with.offset(-5.0);
    }];
    
    [self.brownRoundedCornerImageView addSubview:self.minusButton];
    [self.minusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.brownRoundedCornerImageView.mas_top).with.offset(5.0);
        make.left.equalTo(self.brownRoundedCornerImageView.mas_left).with.offset(5.0);
        make.right.equalTo(self.whiteRoundedCornerImageView.mas_left).with.offset(-5.0);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    float height = [result floatValue];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView.mas_bottom).with.offset(.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        make.height.equalTo(@(height));
    }];
    self.scrollView.contentSize = CGSizeMake(self.contentView.frame.size.width,
                                             SCREEN_WIDTH/3*2 + height + 50.0);
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(webView.mas_bottom).with.offset(50.0);
    }];
    [self.scrollView.mj_header endRefreshing];
}

#pragma mark - privete method

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

- (void) configUI {
    self.topicLine.hidden = NO;
    self.framerImageView.hidden = NO;
    self.originImageView.hidden = NO;
    self.brownRoundedCornerImageView.hidden = NO;
    self.cycleScrollView.imageURLStringsGroup = self.goodsDetailInfo.imgs;
    self.goods_nameLabel.text = self.goodsDetailInfo.goods_name;
    self.farmer_nameLabel.text = [NSString stringWithFormat:@"农户:%@",self.goodsDetailInfo.farmer_name];
    self.origin_nameLabel.text = [NSString stringWithFormat:@"产地:%@",self.goodsDetailInfo.origin_name];
    NSString *string = [NSString stringWithFormat:@"￥%@    原价￥%@",self.goodsDetailInfo.goods_price,self.goodsDetailInfo.market_price];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
    [attr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlinePatternSolid | NSUnderlineStyleSingle] range:[string rangeOfString:[NSString stringWithFormat:@"￥%@",self.goodsDetailInfo.market_price]]];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10.0] range:[string rangeOfString:[NSString stringWithFormat:@"原价￥%@",self.goodsDetailInfo.market_price]]];
    self.priceLabel.attributedText = attr;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.goodsDetailInfo.detail_url]]];
}

- (void) gotoCommentViewController {
    
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
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
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
        [_rightButton addTarget:self action:@selector(gotoCommentViewController) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton setImage:[UIImage imageNamed:@"goods_pingjia"] forState:UIControlStateNormal];
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
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT - 50.0, SCREEN_WIDTH, 50.0)];
        _bottomView.backgroundColor = [UIColor yellowColor];//[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    }
    return _bottomView;
}

@end
