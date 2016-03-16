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

@interface MineAboutUSViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AboutUSHeaderView *headerView;
@property (nonatomic, strong) AboutUSFooterView *footerView;

@end

@implementation MineAboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    self.title = @"关于我们";
    
    self.dataSource = @[@"客服电话 : 0451-87553921",@"微信公众号 : 大米直通车"];
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
    }
}

#pragma mark - getter and setter

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
