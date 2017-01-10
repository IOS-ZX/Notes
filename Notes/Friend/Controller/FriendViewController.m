//
//  FriendViewController.m
//  Notes
//
//  Created by rimi on 2017/1/7.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "FriendViewController.h"
#import "FriendTableViewCell.h"
#import "ChatViewController.h"
#import "BaseNavigationController.h"
#import "FriendSQLiteManager.h"
#import "GetUserFriend.h"

@interface FriendViewController ()<AVIMClientDelegate>

/** 好友列表 **/
@property(nonatomic,strong)NSArray *friends;

/** client **/
@property(nonatomic,strong)AVIMClient *client;

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self requestData];
    if (self.friends.count == 0) {
        [self requestData];
    }
}

- (void)initView{
    __block typeof(self) weakSelf = self;
    self.view.backgroundColor = [UIColor hexColor:@"f1f2f3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendTableViewCell" bundle:nil] forCellReuseIdentifier:@"FriendTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
}

- (void)requestData{
    __weak typeof(self) weakSelf = self;
    [GetUserFriend requestFriendData:^(NSArray *arr) {
        weakSelf.friends = arr;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 接受消息
- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {
    NSLog(@"1212%@", message.text); // 耗子，起床！
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friends.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendTableViewCell" forIndexPath:indexPath];
    FriendModel *model = self.friends[indexPath.row];
    cell.name.text = model.uname;
    NSURL *url = [NSURL URLWithString:model.img];
    [cell.headImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"用户"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendModel *model = self.friends[indexPath.row];
    ChatViewController *chat = [ChatViewController new];
    chat.model = model;
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:chat];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - 懒加载

- (NSArray *)friends{
    if (!_friends) {
        _friends = [[FriendSQLiteManager sheardManager] selectAllData];
    }
    return _friends;
}

- (AVIMClient *)client{
    if (!_client) {
        _client = [[AVIMClient alloc]initWithClientId:[AVUser currentUser].objectId];
        _client.delegate = self;
    }
    return _client;
}

@end
