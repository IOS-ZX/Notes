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

@interface RecordViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableview **/
@property(nonatomic,strong)UITableView *tableView;

/** 添加按钮 **/
@property(nonatomic,strong)UIButton *addBtn;

/** 按钮数组 **/
@property(nonatomic,strong)NSMutableArray *btns;

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
}

/** 添加按钮点击事件 **/
- (void)addNotes:(UIButton*)sender{
    __weak typeof(self) weakSelf = self;
    [self.btns enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:NO block:^(NSTimer * _Nonnull timer) {
            [weakSelf btnStartAnim:btn];
        }];
    }];
}

/** 其他按钮点击事件 **/
- (void)btnClicks:(UIButton*)sender{
    NSLog(@"click:%ld",sender.tag);
}

/** 动画 **/
- (void)btnStartAnim:(UIButton*)btn{
    if (btn.center.y > SCREEN_W) {
        [UIView animateWithDuration:0.5 animations:^{
            btn.center = CGPointMake(SCREEN_W - 60, btn.center.y);
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            btn.center = CGPointMake(SCREEN_W + 40, btn.center.y);
        }];
    }
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
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
    cell.title.text = @"这是一个标题";
    cell.time.text = @"2017/01/09";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            [btn setImage:[UIImage imageNamed:images[index]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClicks:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            [_btns addObject:btn];
        }
    }
    return _btns;
}

@end
