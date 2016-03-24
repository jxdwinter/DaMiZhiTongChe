//
//  MainViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 2/23/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "MainViewController.h"
#import "Main_homeApi.h"
#import "Main_Goods.h"
#import "Main_Banner.h"
#import "Main_Topic.h"
#import "Main_Category.h"
#import <SDCycleScrollView.h>
#import <TOWebViewController.h>
#import <MJRefresh.h>
#import "Main_TopicCollectionViewCell.h"
#import "Main_CategoryTableViewCell.h"
#import "Main_GoodsCollectionViewController.h"
#import "Main_GoodsDetailViewController.h"
#import "WebViewController.h"

#define HEADERVIEWHIGHT 40.0

@interface MainViewController ()<UISearchBarDelegate,SDCycleScrollViewDelegate,UICollectionViewDelegate,
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, assign) double collectionViewCellHight;

@property (nonatomic, assign) BOOL isKeyboardShown;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) NSMutableArray *bannerItems;
@property (nonatomic, strong) NSMutableArray *bannerImageStringItems;
//@property (nonatomic, strong) NSMutableArray *bannerTitleItems;
@property (nonatomic, strong) NSMutableArray *topicItems;
@property (nonatomic, strong) NSMutableArray *categoryItems;

@end

@implementation MainViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Listen for keyboard appearances and disappearances
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    self.isKeyboardShown = NO;
    
    if (IS_IPHONE_4_OR_LESS) {
        self.collectionViewCellHight = 230.0;
    }else if (IS_IPHONE_5) {
        self.collectionViewCellHight = 230.0;
    }else if (IS_IPHONE_6) {
        self.collectionViewCellHight = 250.0;
    }else if (IS_IPHONE_6P) {
        self.collectionViewCellHight = 270.0;
    }

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_navigationbar_blank"]]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_navigationbar_blank"]]];
    self.navigationItem.titleView = self.searchBar;
    
    self.bannerItems = [[NSMutableArray alloc] initWithCapacity:1];
    self.bannerImageStringItems = [[NSMutableArray alloc] initWithCapacity:1];
    //self.bannerTitleItems = [[NSMutableArray alloc] initWithCapacity:1];
    self.topicItems = [[NSMutableArray alloc] initWithCapacity:1];
    self.categoryItems = [[NSMutableArray alloc] initWithCapacity:1];
    
    [self getMainDataWithShowShouldShowHUD:YES];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark - privete method

- (void)keyboardDidShow: (NSNotification *) notif{
    self.isKeyboardShown = YES;
}

- (void)keyboardDidHide: (NSNotification *) notif{
    self.isKeyboardShown = NO;
}

- (void) loadData {
    [self getMainDataWithShowShouldShowHUD:NO];
}

- (void) getMainDataWithShowShouldShowHUD : (BOOL) shouldShowHUD {
    Main_homeApi *api = [[Main_homeApi alloc] init];
    if (shouldShowHUD){
        RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
        [api addAccessory:accessory];
    }
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
        if (dic) {
            if ([dic[@"result"] isEqualToString:@"0"]) {
                [self configDataWithMainData:dic[@"data"]];
            }else{
                [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
            }
        }
    } failure:^(YTKBaseRequest *request) {
        [self.scrollView.mj_header endRefreshing];
    }];
}

- (void) configDataWithMainData : (NSDictionary *) data {
    [self.bannerItems removeAllObjects];
    [self.bannerImageStringItems removeAllObjects];
    [self.topicItems removeAllObjects];
    [self.categoryItems removeAllObjects];
    for (NSDictionary *bannerDic in data[@"ad_list"]) {
        Main_Banner *banner = [[Main_Banner alloc] initWithBannerInfo:bannerDic];
        if (banner) {
            [self.bannerItems addObject:banner];
            [self.bannerImageStringItems addObject:banner.imgurl];
            //[self.bannerTitleItems addObject:banner.title];
        }
    }
    for (NSDictionary *topicDic in data[@"topic_list"]) {
        Main_Topic *topic = [[Main_Topic alloc] initWithTopicInfo:topicDic];
        if (topic) {
            [self.topicItems addObject:topic];
        }
    }
    for (NSDictionary *categoryDic in data[@"category_list"]) {
        Main_Category *category = [[Main_Category alloc] initWithCategoryInfo:categoryDic];
        if (category) {
            [self.categoryItems addObject:category];
        }
    }
    [self configUI];
}

- (void) configUI {
    [self cleanUI];
    self.cycleScrollView.imageURLStringsGroup = self.bannerImageStringItems;
    //self.cycleScrollView.titlesGroup = self.bannerTitleItems;
    NSUInteger number = [self.topicItems count]/2;
    if ([self.topicItems count] % 2 > 0) {
        number++;
    }
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
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cycleScrollView.mas_bottom).with.offset(5.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(5.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-5.0);
        make.height.equalTo(@(self.collectionViewCellHight * number));
    }];
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).with.offset(5.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(5.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-5.0);
        make.height.equalTo(@(SCREEN_WIDTH/3 * [self.categoryItems count] + HEADERVIEWHIGHT));
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tableView.mas_bottom).with.offset(50.0);
    }];

}

- (void) cleanUI {
    [self.cycleScrollView removeFromSuperview];
    self.cycleScrollView = nil;
    [self.collectionView removeFromSuperview];
    self.collectionView = nil;
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    [self.contentView removeFromSuperview];
    self.contentView = nil;
    [self.scrollView removeFromSuperview];
    self.scrollView = nil;
}

- (void) dismissKeyboard {
    [self.searchBar resignFirstResponder];
    
}

#pragma mark - searchBar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    Main_GoodsCollectionViewController *main_GoodsCollectionViewController = [[Main_GoodsCollectionViewController alloc] init];
    main_GoodsCollectionViewController.search = searchBar.text;
    main_GoodsCollectionViewController.title = @"搜索";
    [self.navigationController pushViewController:main_GoodsCollectionViewController animated:YES];
}

#pragma mark - Collection View Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.topicItems count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Main_TopicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MAIN_TOPICCOLLECTIONVIEWCELL" forIndexPath:indexPath];
    Main_Topic *topic = self.topicItems[indexPath.row];
    [cell.logoImageView sd_setImageWithURL:[NSURL URLWithString:topic.imgurl] placeholderImage:nil];
    cell.nameLabel.text = topic.name;
    cell.desLabel.text = topic.des;
    [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:topic.goods.imgurl] placeholderImage:nil];
    cell.goods_nameLabel.text = topic.goods.goods_name;
    cell.farmer_nameLabel.text = [NSString stringWithFormat:@"农户:%@",topic.goods.farmer_name];
    cell.origin_nameLabel.text = [NSString stringWithFormat:@"产地:%@",topic.goods.origin_name];
    NSString *string = [NSString stringWithFormat:@"￥%@    原价￥%@",topic.goods.goods_price,topic.goods.market_price];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
    [attr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlinePatternSolid | NSUnderlineStyleSingle] range:[string rangeOfString:[NSString stringWithFormat:@"￥%@",topic.goods.market_price]]];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10.0] range:[string rangeOfString:[NSString stringWithFormat:@"原价￥%@",topic.goods.market_price]]];
    cell.priceLabel.attributedText = attr;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH - 10.0)/2, self.collectionViewCellHight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissKeyboard];
    Main_Topic *topic = self.topicItems[indexPath.row];
    Main_GoodsCollectionViewController *main_GoodsCollectionViewController = [[Main_GoodsCollectionViewController alloc] init];
    main_GoodsCollectionViewController.topic_id = topic._id;
    main_GoodsCollectionViewController.title = topic.name;
    [self.navigationController pushViewController:main_GoodsCollectionViewController animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    [self dismissKeyboard];
    Main_Banner *banner = self.bannerItems[index];
    if ([banner.type isEqualToString:@"0"]) {
        TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:[NSURL URLWithString:banner.linkurl]];
        webViewController.navigationButtonsHidden = YES;
        webViewController.loadingBarTintColor = DEFAULTBROWNCOLOR;
        webViewController.showUrlWhileLoading = NO;
        [self.navigationController pushViewController:webViewController animated:YES];
    }else if ([banner.type isEqualToString:@"1"]){
        WebViewController *webViewController = [[WebViewController alloc] init];
        webViewController.htmlString = banner.content;
        [self.navigationController pushViewController:webViewController animated:YES];
    }else if ([banner.type isEqualToString:@"2"]){
        Main_GoodsDetailViewController *main_GoodsDetailViewController = [[Main_GoodsDetailViewController alloc] init];
        main_GoodsDetailViewController.goods_id = banner.goods_id;
        [self.navigationController pushViewController:main_GoodsDetailViewController animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.categoryItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CELL = @"CELL";
    Main_CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL];
    if(cell == nil){
        cell = [[Main_CategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL];
    }
    Main_Category *category = self.categoryItems[indexPath.row];
    [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:category.category_image] placeholderImage:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissKeyboard];
    Main_Category *category = self.categoryItems[indexPath.row];
    Main_GoodsCollectionViewController *main_GoodsCollectionViewController = [[Main_GoodsCollectionViewController alloc] init];
    main_GoodsCollectionViewController.category_id = category._id;
    main_GoodsCollectionViewController.title = category.category_name;
    [self.navigationController pushViewController:main_GoodsCollectionViewController animated:YES];

}
#pragma mark - scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        if (self.isKeyboardShown) {
            [self dismissKeyboard];
        }
    }
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
        _scrollView.mj_header = header;
        _scrollView.delegate = self;
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

- (UISearchBar *) searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
        [_searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"main_navigationbar_searchbar"]forState:UIControlStateNormal];
        _searchBar.placeholder = @"搜索好大米";
        _searchBar.delegate = self;
        [_searchBar sizeToFit];
        _searchBar.barTintColor = DEFAULTCOLOR;
        _searchBar.tintColor = DEFAULTCOLOR;
        UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
        searchField.textColor = DEFAULTBROWNCOLOR;
        [searchField setValue:DEFAULTBROWNCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        [_searchBar sizeToFit];
    }
    return _searchBar;
}

- (SDCycleScrollView *) cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.currentPageDotColor = DEFAULTBROWNCOLOR;
        _cycleScrollView.pageDotColor = [UIColor whiteColor];
        _cycleScrollView.autoScrollTimeInterval = 10;
    }
    return _cycleScrollView;
}

- (UICollectionView *) collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[Main_TopicCollectionViewCell class] forCellWithReuseIdentifier:@"MAIN_TOPICCOLLECTIONVIEWCELL"];
        _collectionView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    }
    return _collectionView;
}

- (UITableView *) tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundView = nil;
        _tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        _tableView.rowHeight = SCREEN_WIDTH/3;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (UIView *) headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, HEADERVIEWHIGHT)];
        _headerView.backgroundColor = [UIColor whiteColor];
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.image = [UIImage imageNamed:@"main_categoryIcon"];
        [_headerView addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headerView.mas_top).with.offset(15.0);
            make.left.equalTo(_headerView.mas_left).with.offset(10.0);
            make.width.equalTo(@18.5);
            make.height.equalTo(@13.5);
        }];
        UILabel *label = [[UILabel alloc] init];
        label.textColor = DEFAULTBROWNCOLOR;
        label.font = [UIFont systemFontOfSize:12.0];
        NSString *string = @"好好吃顿饭|选购原产优质食材";
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
        [attr addAttribute:NSForegroundColorAttributeName value:DEFAULTGRAYCOLOR range:[string rangeOfString:@"|选购原产优质食材"]];
        label.attributedText = attr;
        [_headerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headerView.mas_top).with.offset(10.0);
            make.left.equalTo(iconImageView.mas_right).with.offset(10.0);
            make.height.equalTo(@20.0);
        }];
    }
    return _headerView;
}

@end
