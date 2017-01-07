//
//  ChatViewController.m
//  Notes
//
//  Created by rimi on 2017/1/7.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "ChatViewController.h"
#import "MessageCell.h"
#import "Message.h"

@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 消息 **/
@property (nonatomic, strong) NSMutableArray * messages;

/** 发送框 **/
@property (strong, nonatomic)UITextField *textField;

/** tableView **/
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.view.backgroundColor = [UIColor hexColor:@"f1f2f3"];
    self.tableView.estimatedRowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(backView:)];
    self.navigationItem.leftBarButtonItem = back;
}

- (void)backView:(UIBarButtonItem*)item{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    cell.message = self.messages[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((Message *)self.messages[indexPath.row]).height;
}

- (void)updateDataSourceWithType:(MessageWho) messageType {
    Message *aMessage = [[Message alloc] init];
    aMessage.text = self.textField.text;
    aMessage.time = @"now";
    aMessage.type = messageType;
    [self.messages addObject:aMessage];
    [self.tableView reloadData];
//    self.textField.text = nil;
    
}

#pragma mark - 懒加载

- (NSMutableArray *)messages {
    if (!_messages) {
        NSMutableArray *currentsMessage = @[].mutableCopy;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
        NSArray *messageArray = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *aMessageDic in messageArray) {
            Message *aMessage = [Message messageWithDic:aMessageDic];
            [currentsMessage addObject:aMessage];
        }
        _messages = currentsMessage;
        
    }
    return _messages;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0);
        [_tableView registerClass:[MessageCell class] forCellReuseIdentifier:@"MessageCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //预估一个行高
        _tableView.estimatedRowHeight = 80;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

@end
