//
//  ViewController.m
//  Notes
//
//  Created by rimi on 2017/1/7.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "RootViewController.h"
#import "FriendViewController.h"
#import "RecordViewController.h"
#import "MeViewController.h"

@interface RootViewController ()

/** 设置按钮 **/
@property(nonatomic,strong)UIButton *settingBtn;

/** 刷新按钮 **/
@property(nonatomic,strong)UIButton *refreshBtn;

/** 搜索按钮 **/
@property(nonatomic,strong)UIButton *searchBtn;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self makeContentView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 自定义方法

- (void)initView{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self setTabBarFrame:CGRectMake(0, 20, screenSize.width, 44)
        contentViewFrame:CGRectMake(0, 64, screenSize.width, screenSize.height - 64)];
    self.tabBar.backgroundColor = [UIColor hexColor:@"FFFFFF"];
    self.tabBar.itemSelectedBgColor = [UIColor hexColor:@"00CCFF"];
    self.tabBar.itemTitleColor = [UIColor hexColor:@"929292"];
    self.tabBar.itemTitleSelectedColor = [UIColor hexColor:@"00CCFF"];
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:15];
    self.tabBar.itemTitleSelectedFont = [UIFont systemFontOfSize:15];;
    self.tabBar.itemFontChangeFollowContentScroll = YES;
    self.tabBar.itemSelectedBgScrollFollowContent = YES;
    [self.tabBar setScrollEnabledAndItemWidth:80];
    [self.tabBar setLeftAndRightSpacing:(screenSize.width - 160)/2];
    [self.tabBar setItemSelectedBgInsets:UIEdgeInsetsMake(40, 15, 0, 15) tapSwitchAnimated:YES];
    [self setContentScrollEnabledAndTapSwitchAnimated:YES];
    self.loadViewOfChildContollerWhileAppear = YES;
    
    [self.tabBar addSubview:self.settingBtn];
    [self.tabBar addSubview:self.refreshBtn];
    [self.tabBar addSubview:self.searchBtn];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor hexColor:@"00CCFF"]];
}

- (void)makeContentView{
    FriendViewController *friend = [[FriendViewController alloc]init];
    friend.yp_tabItemTitle = @"笔友";
    
    RecordViewController *record = [[RecordViewController alloc]init];
    record.yp_tabItemTitle = @"笔记";
    
    self.viewControllers = [NSMutableArray arrayWithObjects:record, friend, nil];
}

#pragma mark - action

// 设置按钮
- (void)goToSettingPage{
    MeViewController *me = [MeViewController new];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:me animated:YES];
}

// 刷新按钮
- (void)refreshClick:(UIButton*)sender{
    NSLog(@"refresh");
}

// 搜索按钮
- (void)searchClick{
    NSLog(@"search");
}


#pragma mark - 懒加载

- (UIButton *)settingBtn{
    if (!_settingBtn) {
        _settingBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
        [_settingBtn setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
        [_settingBtn addTarget:self action:@selector(goToSettingPage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingBtn;
}

- (UIButton *)refreshBtn{
    if (!_refreshBtn) {
        _refreshBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 60, 12, 20, 20)];
        [_refreshBtn setImage:[UIImage imageNamed:@"刷新"] forState:UIControlStateNormal];
        [_refreshBtn addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshBtn;
}

- (UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 30, 12, 20, 20)];
        [_searchBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

@end
