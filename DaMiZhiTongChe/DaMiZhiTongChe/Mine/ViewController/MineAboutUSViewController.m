//
//  MineAboutUSViewController.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 3/16/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "MineAboutUSViewController.h"
#import "AboutUSHeaderView.h"
#import "AboutUSFooterView.h"
#import "AboutUSTableViewCell.h"
#import <JGActionSheet.h>
#import <VTAcknowledgementsViewController.h>

@interface MineAboutUSViewController () <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AboutUSHeaderView *headerView;
@property (nonatomic, strong) AboutUSFooterView *footerView;

@end

@implementation MineAboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于我们";
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.backBarButtonItem.title = @"";
    self.dataSource = @[@"客服电话 : 0451-87553921",@"微信公众号 : 大米直通车",@"开源组件许可"];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CELL = @"CELL";
    AboutUSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL];
    if(cell == nil){
        cell = [[AboutUSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL];
    }
    cell.titleLabel.text = self.dataSource[[indexPath row]];
    if (indexPath.row == 0) cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        JGActionSheetSection *section = [JGActionSheetSection sectionWithTitle:@"拨打电话" message:@"" buttonTitles:@[@"确认"] buttonStyle:JGActionSheetButtonStyleDefault];
        section.titleLabel.textColor = DEFAULTTEXTCOLOR;
        section.titleLabel.font = DEFAULFONT;
        JGActionSheetSection *cancelSection = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleCancel];
        NSArray *sections = @[section, cancelSection];
        JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
        [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
            [sheet dismissAnimated:YES];
            if (indexPath.section == 0 && indexPath.row == 0) {
                NSString *phoneNumber = @"telprompt://0451-87553921";
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
            }
        }];
        [sheet showInView:self.view animated:YES];
    }else if (indexPath.row == 2){
        VTAcknowledgementsViewController *viewController = [VTAcknowledgementsViewController acknowledgementsViewController];
        viewController.title = @"开源组件";
        viewController.headerText = @"大米直通车iOS版在开发过程中使用了下列第三方开源类库和组件,感谢开源社区对我们的帮助和对整个互联网的贡献";
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void) popToPreViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter and setter

- (UIButton *) backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
        [_backButton addTarget:self action:@selector(popToPreViewController) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setImage:[UIImage imageNamed:@"main_back"] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH,
                                                                   SCREEN_HEIGHT - NAVIGATIONBARHEIGHT)
                                                  style:UITableViewStyleGrouped];
        _tableView.backgroundView = nil;
        _tableView.backgroundColor = DEFAULTLIGHTGRAYCOLOR;
        _tableView.rowHeight = 50;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = self.footerView;
    }
    return _tableView;
}

- (AboutUSHeaderView *) headerView {
    if (!_headerView) {
        _headerView = [[AboutUSHeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 130.0)];
    }
    return _headerView;
}

- (AboutUSFooterView *) footerView {
    if (!_footerView) {
        _footerView = [[AboutUSFooterView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 40.0)];
    }
    return _footerView;
}


@end
