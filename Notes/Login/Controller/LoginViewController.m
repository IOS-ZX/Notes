//
//  LoginViewController.m
//  Notes
//
//  Created by 王灿 on 2017/1/7.
//  Copyright © 2017年 MrJoker. All rights reserved.
//

#import "LoginViewController.h"
#import "WelcomeViewController.h"
#import "WCTextField.h"
#import "WCButton.h"
#import "RootViewController.h"


// plus 屏幕宽 414  屏幕高  736

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view.layer addSublayer: [self backgroundLayer]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self setUp];
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}
-(void)setUp{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200/414.0*SCREEN_W, 50)];
    titleLabel.center = CGPointMake(self.view.center.x, 150);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"CLOVER";
    titleLabel.font = [UIFont systemFontOfSize:40.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300/414.0*SCREEN_W, 30/736.0*SCREEN_H)];
    detail.center = CGPointMake(self.view.center.x,100/736.0*SCREEN_H);
    detail.textColor = [UIColor whiteColor];
    detail.text = @"Don`t have an account yet? Sign Up";
    detail.font = [UIFont systemFontOfSize:13.f];
    detail.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:detail];
    
    WCTextField *username = [[WCTextField alloc]initWithFrame:CGRectMake(0, 0, (270/414.0)*SCREEN_W, 30/736.0*SCREEN_H)];
    username.center = CGPointMake(self.view.center.x, 350/736.0*SCREEN_H);
    username.ly_placeholder = @"用户名";
    username.tag = 0;
    [self.view addSubview:username];
    
    WCTextField *password = [[WCTextField alloc]initWithFrame:CGRectMake(0, 0, 270/414.0*SCREEN_W, 30/736.0*SCREEN_H)];
    password.center = CGPointMake(self.view.center.x, username.center.y+60/736.0*SCREEN_H);
    password.ly_placeholder = @"密码";
    password.tag = 1;
    [self.view addSubview:password];
    
    WCButton *login = [[WCButton alloc]initWithFrame:CGRectMake(0, 0, 200/414.0*SCREEN_W, 44/736.0*SCREEN_H)];
    
    login.center = CGPointMake(self.view.center.x, password.center.y+100/736.0*SCREEN_H);
    [self.view addSubview:login];
    
    __block WCButton *button = login;
    
    login.translateBlock = ^{
        NSLog(@"跳转了哦");
        button.bounds = CGRectMake(0, 0, 44, 44);//??
        button.layer.cornerRadius = 22;
        
            RootViewController *nextVC = [[RootViewController alloc]init];
            [self presentViewController:nextVC animated:YES completion:nil];
        
    };
}


-(CAGradientLayer *)backgroundLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,(__bridge id)[UIColor whiteColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    gradientLayer.locations = @[@0.65,@1];
    return gradientLayer;
}



@end
