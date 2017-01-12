//
//  RecordViewController.m
//  Notes
//
//  Created by rimi on 2017/1/7.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "RecordViewController.h"
#import "MainNotesCell.h"
#import "MainTableHeaderView.h"
#import "CreateTextController.h"
#import "CreateRecordController.h"
#import "CreateRemindController.h"
#import "CreateImageWithTextController.h"
#import "NotesSQLiteManager.h"

@interface RecordViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableview **/
@property(nonatomic,strong)UITableView *tableView;

/** 添加按钮 **/
@property(nonatomic,strong)UIButton *addBtn;

/** 按钮数组 **/
@property(nonatomic,strong)NSMutableArray *btns;

/** 遮罩层 **/
@property(nonatomic,strong)UIView *maskView;

/** 数据 **/
@property(nonatomic,strong)NSArray *dataSource;

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self setUpUI];
}

- (void)initView{
    self.view.backgroundColor = [UIColor hexColor:@"f1f2f3"];
//    self.tableView.tableHeaderView = [MainTableHeaderView new];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadDatas];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 自定义方法

- (void)setUpUI{
    __weak typeof(self) weakSelf = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.view.mas_width).offset(-20);
        make.height.equalTo(weakSelf.view.mas_height).offset(-20);
        make.top.equalTo(weakSelf.view.mas_top).offset(10);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-30);
        make.right.equalTo(weakSelf.view.mas_right).offset(-20);
    }];
    [self.view layoutIfNeeded];
}

/** 添加按钮点击事件 **/
- (void)addNotes:(UIButton*)sender{
    __weak typeof(self) weakSelf = self;
//    self.maskView.hidden = !self.maskView.hidden;
    [self.btns enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf btnStartAnim:btn];
    }];
}

/** 其他按钮点击事件 **/
- (void)btnClicks:(UIButton*)sender{
    NSLog(@"click:%ld",sender.tag);
    switch (sender.tag - 1000) {
        case 0:
            // 文字
        {
            CreateTextController *text = [CreateTextController new];
            BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:text];
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 1:
            // 图片
        {
            CreateImageWithTextController *image = [CreateImageWithTextController new];
            BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:image];
            [self presentViewController:nav animated:YES completion:nil];
        }

            break;
        case 2:
            // 录音
        {
            CreateRecordController *record = [CreateRecordController new];
            BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:record];
            [self presentViewController:nav animated:YES completion:nil];
        }

            break;
        case 3:
            // 提醒
        {
            CreateRemindController *remind = [CreateRemindController new];
            BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:remind];
            [self presentViewController:nav animated:YES completion:nil];
        }

            break;
            
        default:
            break;
    }
    [self addNotes:self.addBtn];
}

/** 动画 **/
- (void)btnStartAnim:(UIButton*)btn{
    CGFloat time = 0.5 + (btn.tag - 1000) * 0.09;
    if (btn.center.x > SCREEN_W) {
        [UIView animateWithDuration:time animations:^{
            btn.center = CGPointMake(self.addBtn.center.x, btn.center.y);
        }];
    }else{
        time = 0.8 - (btn.tag - 1000) * 0.09;
        [UIView animateWithDuration:time animations:^{
            btn.center = CGPointMake(SCREEN_W + 40, btn.center.y);
        }];
    }
}

/** 重新加载数据 **/
- (void)reloadDatas{
    self.dataSource = [[NotesSQLiteManager sheardManager]selectAllData];
    [self.tableView reloadData];
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [MainTableHeaderView new];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainNotesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainNotesCell" forIndexPath:indexPath];
    RecordModel *model = self.dataSource[indexPath.row];
    cell.title.text = model.title;
    cell.time.text = model.date;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (model.isTemp == 1) {
        cell.temp.text = @"[草稿]";
    }else{
        cell.temp.text = @"";
    }
    return cell;
}

#pragma mark - 懒加载

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.layer.cornerRadius = 5;
        _tableView.layer.masksToBounds = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerNib:[UINib nibWithNibName:@"MainNotesCell" bundle:nil] forCellReuseIdentifier:@"MainNotesCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton new];
        _addBtn.layer.cornerRadius = 20;
        _addBtn.backgroundColor = [UIColor whiteColor];
        _addBtn.layer.masksToBounds = YES;
        _addBtn.layer.shadowColor = [UIColor blackColor].CGColor;
        _addBtn.layer.shadowOffset = CGSizeMake(2, 2);
        _addBtn.layer.shadowRadius = 2;
        _addBtn.layer.shadowOpacity = 1;
        [_addBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addNotes:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_addBtn];
    }
    return _addBtn;
}

- (NSMutableArray *)btns{
    if (!_btns) {
        _btns = [NSMutableArray array];
        NSArray *images = [NSArray arrayWithObjects:@"文字",@"图片",@"录音",@"提醒", nil];
        for (NSInteger index = 0; index < 4; index ++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W + 40, self.addBtn.frame.origin.y - (index + 1) * 60, 40, 40)];
            btn.tag = 1000 + index;
            btn.layer.cornerRadius = 20;
            btn.layer.masksToBounds = YES;
            btn.backgroundColor = [UIColor whiteColor];
            [btn setImage:[UIImage imageNamed:images[index]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClicks:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            [_btns addObject:btn];
        }
    }
    return _btns;
}

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _maskView.hidden = YES;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_maskView];
    }
    return _maskView;
}

- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

@end
