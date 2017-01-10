//
//  SMSViewController.m
//  Notes
//
//  Created by 王灿 on 2017/1/7.
//  Copyright © 2017年 MrJoker. All rights reserved.
//

#import "SMSViewController.h"
#import "RootViewController.h"
#import "WCButton.h"

@interface SMSViewController ()

@property(nonatomic,strong)UIButton *sendButton;//发送验证码
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)WCButton *login;
@property(nonatomic,strong)UITextField *phoneField;
@property(nonatomic,strong)UITextField *YZMField;

@end

// plus 屏幕宽 414  屏幕高  736

@implementation SMSViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    self.navigationController.navigationBar.barTintColor = [UIColor yellowColor];
    self.title = @"手机号登录";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self setUI];
    self.login.userInteractionEnabled = YES;
}

-(void)setUI{
    self.phoneField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 300/414.0*SCREEN_W, 50/736.0*SCREEN_H)];
    self.phoneField.center = CGPointMake(self.view.center.x, 100/736.0*SCREEN_H);
    self.phoneField.placeholder = @"请输入你的手机号码";
    [self.view addSubview:self.phoneField];
    self.YZMField = [[UITextField alloc]init];
    self.YZMField.placeholder = @"请输入验证码";
    [self.view addSubview:self.YZMField];
    [self.YZMField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneField.mas_left);
        make.top.equalTo(self.phoneField.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(200/414.0*SCREEN_W, 50/736.0*SCREEN_H));
    }];
    self.sendButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90/414.0*SCREEN_W, 50/736.0*SCREEN_H)];
    self.sendButton.layer.cornerRadius = 10;
    [_sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    _sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_sendButton addTarget:self action:@selector(sendClicked) forControlEvents:UIControlEventTouchUpInside];
    _sendButton.backgroundColor = [UIColor grayColor];
    [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_sendButton];
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.YZMField.mas_right).offset(10);
        make.top.equalTo(self.phoneField.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(130/414.0*SCREEN_W, 50/736.0*SCREEN_H));
    }];
    
}

-(void)sendClicked{
    if (self.phoneField.text.length == 11) {
        self.sendButton.userInteractionEnabled = NO;
        self.sendButton.alpha = 0.4;
        [self.sendButton setTitle:@"60秒后重新发送"forState:UIControlStateNormal];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeSendButton) userInfo:nil repeats:YES];
        [AVOSCloud requestSmsCodeWithPhoneNumber:self.phoneField.text callback:^(BOOL succeeded, NSError * _Nullable error) {
            NSLog(@"error == %@",error);
        }];
    }else{
        //用户输入的手机号码格式不正确
    }
    
    
}

-(void)changeSendButton{
    static NSInteger second = 59;
    [self.sendButton setTitle:[NSString stringWithFormat:@"%ld秒后重新发送",second] forState:UIControlStateNormal];
    if (second == 0) {
        [self.sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.sendButton.userInteractionEnabled = YES;
        self.sendButton.alpha = 1;
        [self.timer invalidate];
        second = 59;
    }
    second--;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(WCButton *)login{
    if (!_login) {
        _login = [[WCButton alloc]initWithFrame:CGRectMake(0, 0, 222/414.0*SCREEN_W, 50/736.0*SCREEN_H)];
        self.login.center = CGPointMake(self.view.center.x, self.view.center.y-100/736.0*SCREEN_H);
        [self.view addSubview:_login];
        __weak typeof(self) weakSelf = self;
        self.login.translateBlock = ^{
//            NSLog(@"跳转了哦");
            weakSelf.login.bounds = CGRectMake(0, 0, 44, 44);//??
            weakSelf.login.layer.cornerRadius = 22;
            [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:weakSelf.phoneField.text smsCode:weakSelf.YZMField.text block:^(AVUser * _Nullable user, NSError * _Nullable error) {
                if (!error) {
                    RootViewController *nextVC = [[RootViewController alloc]init];
                    [weakSelf presentViewController:nextVC animated:YES completion:nil];
                }else{
                    NSLog(@"error");
                    weakSelf.login = nil;
                    weakSelf.login.userInteractionEnabled = YES;
                }
            }];
            
        };
    }
    return _login;
}

@end
