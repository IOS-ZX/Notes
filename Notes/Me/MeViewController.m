//
//  MeViewController.m
//  Notes
//
//  Created by rimi on 2017/1/7.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "MeViewController.h"
#import "ChangePersonTableView.h"

@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIView *personalView;
@property(nonatomic,strong)UIButton *headBtn;
@property(nonatomic,strong)UILabel *personalName;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)ChangePersonTableView *cvc;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self setUI];
}

- (void)initView{
    self.view.backgroundColor = [UIColor hexColor:@"f1f2f3"];
    self.title = @"我";
<<<<<<< HEAD
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(backView:)];
    self.navigationItem.leftBarButtonItem = back;
    UIBarButtonItem *loginOut = [[UIBarButtonItem alloc]initWithTitle:@"退出登录" style:UIBarButtonItemStylePlain target:self action:@selector(LoginOut)];
    self.navigationItem.rightBarButtonItem = loginOut;
}
-(void)LoginOut{
    NSLog(@"退出");
}
-(void)setUI{
    [self.view addSubview:self.personalView];
    //判断是否有设置头像
    [self.headBtn setImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
    [self.headBtn addTarget:self action:@selector(setHead) forControlEvents:UIControlEventTouchDragInside];
    [self.personalView addSubview:self.headBtn];
    self.personalName.text = @"ooooo";
    [self.personalView addSubview:self.personalName];
    self.tableView.scrollEnabled = NO;
}
-(void)setHead{
    NSLog(@"设置头像");
=======
>>>>>>> origin/master
}

- (void)backView:(UIBarButtonItem*)item{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    if (self.navigationController.navigationBar.hidden) {
        NSLog(@"隐藏");
    }else{
        NSLog(@"显示");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            //修改个人信息
            [self.navigationController pushViewController:self.cvc animated:YES];
            break;
        case 1:
            //我的笔迹
            break;
        case 2:
            //修改主题
            break;
        case 3:
            //软件设置
            break;
            
        default:
            //清除缓存
            break;
    }
}
#pragma 懒加载
-(UIView *)personalView{
    if (!_personalView) {
        _personalView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 64+(200/736.0*SCREEN_H))];
        _personalView.backgroundColor = [UIColor lightGrayColor];
    }
    return _personalView;
}
-(UIButton *)headBtn{
    if (!_headBtn) {
        _headBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100/414.0*SCREEN_W, 100/414.0*SCREEN_W)];
        _headBtn.center = CGPointMake(self.personalView.center.x, self.personalView.center.y);
        _headBtn.layer.cornerRadius = 50/414.0*SCREEN_W;
    }
    return _headBtn;
}
-(UILabel *)personalName{
    if (!_personalName) {
        _personalName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200/414.0*SCREEN_W, 50/736.0*SCREEN_H)];
        _personalName.center = CGPointMake(self.view.center.x, self.headBtn.center.y+(70/736.0*SCREEN_H));
        _personalName.textAlignment = NSTextAlignmentCenter;
    }
    return _personalName;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.top.equalTo(self.personalView.mas_bottom);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        _tableView.tableFooterView = [[UITableView alloc]initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"修改个人信息",@"我的笔迹",@"修改主题",@"软件设置",@"清除缓存"];
    }
    return _titleArray;
}
-(ChangePersonTableView *)cvc{
    if (!_cvc) {
        _cvc = [[ChangePersonTableView alloc]init];
    }
    return _cvc;
}
@end
