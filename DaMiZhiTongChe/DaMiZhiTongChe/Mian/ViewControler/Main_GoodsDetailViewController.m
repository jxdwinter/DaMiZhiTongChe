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
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) Main_GoodsDetail *goodsDetailInfo;

@end

@implementation Main_GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [self.contentView addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cycleScrollView.mas_bottom).with.offset(.0);
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
        make.top.equalTo(self.cycleScrollView.mas_bottom).with.offset(.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0.0);
        make.height.equalTo(@(height));
    }];
    self.scrollView.contentSize = CGSizeMake(self.contentView.frame.size.width,
                                             SCREEN_WIDTH/3 + height + 50.0);
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
    self.cycleScrollView.imageURLStringsGroup = self.goodsDetailInfo.imgs;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.goodsDetailInfo.detail_url]]];
}

- (void) gotoCommentViewController {
    
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
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 22.0, 33.0)];
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

- (UIWebView *) webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        _webView.scrollView.scrollEnabled = NO;
        _webView.delegate = self;
    }
    return _webView;
}

@end
