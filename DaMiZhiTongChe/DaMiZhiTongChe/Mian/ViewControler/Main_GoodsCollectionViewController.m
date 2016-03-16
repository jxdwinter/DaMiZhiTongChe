//
//  Main_GoodsCollectionViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/7/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "Main_GoodsCollectionViewController.h"
#import "Main_GoodsCollectionViewCell.h"
#import "Main_goodsListApi.h"
#import <MJRefresh.h>
#import "Main_Goods.h"
#import "Main_GoodsDetailViewController.h"

@interface Main_GoodsCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) double collectionViewCellHight;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSUInteger page_num;

@end

@implementation Main_GoodsCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    if (IS_IPHONE_4_OR_LESS) {
        self.collectionViewCellHight = 180.0;
    }else if (IS_IPHONE_5) {
        self.collectionViewCellHight = 180.0;
    }else if (IS_IPHONE_6) {
        self.collectionViewCellHight = 200.0;
    }else if (IS_IPHONE_6P) {
        self.collectionViewCellHight = 220.0;
    }
    self.page_num = 1;
    self.dataSource = [[NSMutableArray alloc] initWithCapacity:1];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(5.0);
        make.left.equalTo(self.view.mas_left).with.offset(5.0);
        make.right.equalTo(self.view.mas_right).with.offset(-5.0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-5.0);
    }];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Main_GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MAIN_GOODSCOLLECTIONVIEWCELL" forIndexPath:indexPath];
    Main_Goods *goods = self.dataSource[indexPath.row];
    [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goods.imgurl] placeholderImage:nil];
    cell.goods_nameLabel.text = goods.goods_name;
    cell.farmer_nameLabel.text = [NSString stringWithFormat:@"农户:%@",goods.farmer_name];
    cell.origin_nameLabel.text = [NSString stringWithFormat:@"产地:%@",goods.origin_name];
    NSString *string = [NSString stringWithFormat:@"￥%@    原价￥%@",goods.goods_price,goods.market_price];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
    [attr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlinePatternSolid | NSUnderlineStyleSingle] range:[string rangeOfString:[NSString stringWithFormat:@"￥%@",goods.market_price]]];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10.0] range:[string rangeOfString:[NSString stringWithFormat:@"原价￥%@",goods.market_price]]];
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
    Main_Goods *goods = self.dataSource[indexPath.row];
    Main_GoodsDetailViewController *main_GoodsDetailViewController = [[Main_GoodsDetailViewController alloc] init];
    main_GoodsDetailViewController.title = goods.goods_name;
    main_GoodsDetailViewController.goods_id = goods._id;
    [self.navigationController pushViewController:main_GoodsDetailViewController animated:YES];
}

#pragma mark - privete method

- (void) loadData {
    [self getGoodsDataWithShowShouldShowHUD:YES withShouldRefreshData:YES];
}

- (void) loadNewData {
    self.page_num = 1;
    [self.collectionView.mj_footer resetNoMoreData];
    [self getGoodsDataWithShowShouldShowHUD:NO withShouldRefreshData:YES];
}

- (void) loadMoreData {
    self.page_num++;
    [self getGoodsDataWithShowShouldShowHUD:NO withShouldRefreshData:NO];
}

- (void) getGoodsDataWithShowShouldShowHUD : (BOOL) shouldShowHUD withShouldRefreshData : (BOOL) shouldRefreshData {
    Main_goodsListApi *api = [[Main_goodsListApi alloc] initWithCategory_id:self.category_id?self.category_id:@""
                                                               withTopic_id:self.topic_id?self.topic_id:@""
                                                                 withSearch:self.search?self.search:@""
                                                               withPage_num:[NSString stringWithFormat:@"%lu",(unsigned long)self.page_num]];
    if (shouldShowHUD){
        RequestAccessory *accessory = [[RequestAccessory alloc] initAccessoryWithView:self.navigationController.view];
        [api addAccessory:accessory];
    }
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
        if (dic) {
            NSLog(@"%@",dic[@"result"]);
            if ([dic[@"result"] isEqualToString:@"0"]) {
                [self configDataWithMainData:dic[@"data"] withShouldRefreshData:shouldRefreshData];
            }else if ([dic[@"result"] isEqualToString:@"1"]){
                [self configDataWithMainData:nil withShouldRefreshData:shouldRefreshData];
                [self configErrorOrNoMoreDataWithShouldRefreshData:shouldRefreshData];
            }else{
                [MBProgressHUD showHUDwithSuccess:NO WithTitle:dic[@"msg"] withView:self.navigationController.view];
                [self configErrorOrNoMoreDataWithShouldRefreshData:shouldRefreshData];
            }
        }
    } failure:^(YTKBaseRequest *request) {
        [self configErrorOrNoMoreDataWithShouldRefreshData:shouldRefreshData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}

- (void) configErrorOrNoMoreDataWithShouldRefreshData  : (BOOL) shouldRefreshData {
    //如果是加载更多
    if (!shouldRefreshData) {
        self.page_num--;
        if (self.page_num <= 1) {
            self.page_num = 1;
        }
    }
}

- (void) configDataWithMainData : (NSArray *) data withShouldRefreshData :(BOOL) shouldRefreshData {
    if ( data && [data count]) {
        NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithCapacity:1];
        for (NSDictionary *goodsDic in data) {
            Main_Goods *goods = [[Main_Goods alloc] initWithGoodsInfo:goodsDic];
            if (goods) {
                [tmpArray addObject:goods];
            }
        }
        NSMutableArray *tmpDataSource = [self.dataSource mutableCopy];
        if (shouldRefreshData) {
            [tmpDataSource removeAllObjects];
            [tmpDataSource addObjectsFromArray:tmpArray];
        }else{
            NSMutableArray *tmp = [[NSMutableArray alloc] initWithCapacity:1];
            for (Main_Goods *newGoods in tmpArray) {
                BOOL isExist = NO;
                for (Main_Goods *oldGoods in tmpDataSource) {
                    if ([newGoods._id isEqualToString:oldGoods._id]) {
                        isExist = YES;
                    }
                }
                if (!isExist) {
                    [tmp addObject:newGoods];
                }
            }
            [tmpDataSource addObjectsFromArray:tmp];
        }
        self.dataSource = nil;
        self.dataSource  = [tmpDataSource mutableCopy];
        if ([tmpArray count] < PAGENUMBER) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }else{
            self.collectionView.mj_footer = nil;
            self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        }
    } else {
        if (shouldRefreshData) {
            [self.dataSource removeAllObjects];
        }else{
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
    }
    [self configUI];
}

- (void) configUI {
    [self.collectionView reloadData];
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

#pragma mark - getter and setter

- (UICollectionView *) collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[Main_GoodsCollectionViewCell class] forCellWithReuseIdentifier:@"MAIN_GOODSCOLLECTIONVIEWCELL"];
        _collectionView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"好大米马上来..." forState:MJRefreshStateRefreshing];
        header.stateLabel.font = [UIFont systemFontOfSize:14];
        header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:10];
        header.stateLabel.textColor = DEFAULTBROWNCOLOR;
        header.lastUpdatedTimeLabel.textColor = DEFAULTBROWNCOLOR;
        header.lastUpdatedTimeLabel.hidden = YES;
        _collectionView.mj_header = header;
    }
    return _collectionView;
}

@end
