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
#import "MessageSQLiteManager.h"
#import "ConversationModel.h"
#import "ConversationSQLiteManager.h"

@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,AVIMClientDelegate>

/** 消息 **/
@property (nonatomic, strong) NSMutableArray * messages;

/** 发送框 **/
@property (strong, nonatomic)UITextField *textField;

/** tableView **/
@property(nonatomic,strong)UITableView *tableView;

/** send **/
@property(nonatomic,strong)UIButton *send;

/** client **/
//@property(nonatomic,strong)AVIMClient *client;

/** 会话 **/
@property(nonatomic,strong)AVIMConversation *conversation;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self setUpUI];
    __weak typeof(self) weakSelf = self;
    [self.client openWithCallback:^(BOOL succeeded, NSError * _Nullable error) {
        [weakSelf getUserConversation];
    }];
    NSLog(@"所有会话：%@",[[ConversationSQLiteManager sheardManager]selectAllData]);
}

- (void)initView{
    self.view.backgroundColor = [UIColor hexColor:@"f1f2f3"];
    self.tableView.estimatedRowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(backView:)];
    self.navigationItem.leftBarButtonItem = back;
    self.title = self.model.uname;
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

// 获取用户会话
- (void)getUserConversation{
    ConversationModel *model = [[ConversationSQLiteManager sheardManager]selectById:[NSString stringWithFormat:@"%@%@",[AVUser currentUser].objectId,self.model.uid]];
    NSLog(@"会话:%@",model);
    if (model.conversationid) {
        // 根据本地数据获取会话
        NSLog(@"获取本地会话");
        self.conversation = [self.client conversationForId:model.uid];
        __weak typeof(self) weakSelf = self;
        AVIMConversationQuery *query = [self.client conversationQuery];
        [query whereKey:@"name" equalTo:self.model.uname];
        [query findConversationsWithCallback:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//            AVIMConversation *con = 
            NSLog(@"con:%@",objects);
        }];
//        [query getConversationById:@"551260efe4b01608686c3e0f" callback:^(AVIMConversation *conversation, NSError *error) {
//            weakSelf.conversation = conversation;
//            if (!error) {
//                NSLog(@"会话获取成功");
//            }else{
//                NSLog(@"会话获取失败:%@",error);
//                // 创建会话
//                [self createConversation];
//            }
//        }];
    }else{
        [self createConversation];
    }
}

- (void)createConversation{
    // 创建会话
    NSLog(@"创建会话");
    // 打开会话
    [self.client createConversationWithName:self.model.uname clientIds:@[self.model.uid,[AVUser currentUser].objectId] callback:^(AVIMConversation * _Nullable conversation, NSError * _Nullable error) {
        if (!error) {
            // 会话创建成功
            self.conversation = conversation;
            ConversationModel *model = [ConversationModel new];
            model.uid = [NSString stringWithFormat:@"%@%@",[AVUser currentUser].objectId,self.model.uid];
            model.conversationid = conversation.conversationId;
            // 储存会话信息
            BOOL success = [[ConversationSQLiteManager sheardManager]insertData:model];
            NSLog(@"创建会话成功:%@",conversation.conversationId);
            if (!success) {
                NSLog(@"会话储存失败");
            }else{
                NSLog(@"会话储存成功");
            }
        }else{
            NSLog(@"会话创建失败：%@",error);
        }
    }];
}

// 发送消息
- (void)sendMessage:(UIButton*)sender{
    [self updateDataSourceWithType:MessageWhoIsMe text:self.textField.text];
    if (!self.conversation) {
        NSLog(@"会话尚未建立");
        return;
    }
    [self.conversation sendMessage:[AVIMTextMessage messageWithText:self.textField.text attributes:nil] callback:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"发送消息错误:%@",error);
        }else{
            NSLog(@"发送成功");
        }
    }];
}

//接收消息
- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {
    [self updateDataSourceWithType:MessageWHoIsAnother text:message.text];
    NSLog(@"%@", message.text); // 耗子，起床！
}

- (void)updateDataSourceWithType:(MessageWho) messageType text:(NSString*)msg{
    Message *aMessage = [[Message alloc] init];
    aMessage.text = msg;
    aMessage.time = @"now";
    aMessage.type = messageType;
    aMessage.isSelf = messageType;
    aMessage.uid = [NSString stringWithFormat:@"%@%@",[AVUser currentUser].objectId,self.model.uid];
    [self.messages addObject:aMessage];
    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.messages.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    [[MessageSQLiteManager sheardManager]insertData:aMessage];
    self.textField.text = nil;
}

- (void)setUpUI{
    __weak typeof(self) weakSelf = self;
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.view.mas_width).offset(-85);
        make.height.mas_equalTo(40);
        make.left.equalTo(weakSelf.view.mas_left).offset(15);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-10);
    }];
    [self.send mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.equalTo(weakSelf.textField.mas_height).offset(-2);
        make.right.equalTo(weakSelf.view.mas_right).offset(-15);
        make.centerY.equalTo(weakSelf.textField.mas_centerY);
    }];
}

#pragma mark - 懒加载

- (NSMutableArray *)messages {
    if (!_messages) {
        _messages = [NSMutableArray arrayWithArray:[[MessageSQLiteManager sheardManager]selectAllData:[NSString stringWithFormat:@"%@%@",[AVUser currentUser].objectId,self.model.uid]]];
    }
    return _messages;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 60)];
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

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:_textField];
    }
    return _textField;
}

- (UIButton *)send{
    if (!_send) {
        _send = [UIButton new];
        _send.layer.cornerRadius = 4;
        _send.layer.masksToBounds = YES;
        _send.backgroundColor = [UIColor orangeColor];
        [_send setTitle:@"发送" forState:UIControlStateNormal];
        [_send addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_send];
    }
    return _send;
}

//- (AVIMClient *)client{
//    if (!_client) {
//        _client = [AVIMClient defaultClient];
//        _client.delegate = self;
//    }
//    return _client;
//}

- (AVIMConversation *)conversation{
    if (!_conversation) {
        if (self.messages.count > 0) {
            
        }
    }
    return _conversation;
}

@end
