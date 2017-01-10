//
//  WelcomeViewController.m
//  Notes
//
//  Created by 王灿 on 2017/1/7.
//  Copyright © 2017年 MrJoker. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LoginViewController.h"
#import "SMSViewController.h"

@interface WelcomeViewController ()

@end
#define SCREEN_W self.view.bounds.size.width
#define SCREEN_H self.view.bounds.size.height
// plus 屏幕宽 414  屏幕高  736

@implementation WelcomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    
}

-(void)setUI{
    UIButton *newUser = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 250/414.0*SCREEN_W, 40/736.0*SCREEN_H)];
    newUser.center = CGPointMake(self.view.center.x, 450/736.0*SCREEN_H);
    newUser.backgroundColor = [UIColor greenColor];
    [newUser setTitle:@"手机号登录" forState:UIControlStateNormal];
    [newUser setTintColor:[UIColor blackColor]];
    newUser.layer.cornerRadius = 5;
    UIButton *oldUser = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 250/414.0*SCREEN_W, 40/736.0*SCREEN_H)];
    oldUser.center = CGPointMake(self.view.center.x, 500/736.0*SCREEN_H);
    [oldUser setTitle:@"我是老用户，直接登录" forState:UIControlStateNormal];
    oldUser.backgroundColor = [UIColor greenColor];
    [oldUser setTintColor:[UIColor blackColor]];
    oldUser.layer.cornerRadius = 5;
    newUser.tag = 1000;
    [newUser addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventTouchUpInside];
    oldUser.tag = 1001;
    [oldUser addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:newUser];
    [self.view addSubview:oldUser];
    
}

-(void)Clicked:(UIButton *)button{
    if (button.tag == 1001) {
        LoginViewController *lvc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
    }else{
        SMSViewController *svc = [SMSViewController new];
        [self.navigationController pushViewController:svc animated:YES];
        self.navigationController.navigationBarHidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
