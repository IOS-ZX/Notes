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

@interface FriendViewController ()

/** 好友列表 **/
@property(nonatomic,strong)NSArray *friends;

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.view.backgroundColor = [UIColor hexColor:@"f1f2f3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendTableViewCell" bundle:nil] forCellReuseIdentifier:@"FriendTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count:%ld",(unsigned long)self.friends.count);
    return self.friends.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendTableViewCell" forIndexPath:indexPath];
    cell.name.text = @"aaa";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatViewController *chat = [ChatViewController new];
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:chat];
    [self presentViewController:nav animated:YES completion:nil];
}

- (NSArray *)friends{
    if (!_friends) {
        _friends = [[FriendSQLiteManager sheardManager] selectAllData];
    }
    return _friends;
}

@end
