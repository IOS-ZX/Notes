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

/** username **/
@property(nonatomic,strong)WCTextField *nameText;
/** password **/
@property(nonatomic,strong)WCTextField *pwd;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view.layer addSublayer: [self backgroundLayer]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (void)login{
    NSString *username = self.nameText.textField.text;
    NSString *password = self.pwd.textField.text;
    NSLog(@"username:%@,pwd:%@",username,password);
    [AVUser logInWithUsernameInBackground:username password:password block:^(AVUser *user, NSError *error) {
        if (error) {
            NSLog(@"login error:%@",error);
        } else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
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
    [self.view addSubview:self.nameText];
    [self.view addSubview:self.pwd];
    
    WCButton *login = [[WCButton alloc]initWithFrame:CGRectMake(0, 0, 200/414.0*SCREEN_W, 44/736.0*SCREEN_H)];
    
    login.center = CGPointMake(self.view.center.x, self.pwd.center.y+100/736.0*SCREEN_H);
    [self.view addSubview:login];
    
    __block WCButton *button = login;
    
    login.translateBlock = ^{
        NSLog(@"跳转了哦");
        button.bounds = CGRectMake(0, 0, 44, 44);//??
        button.layer.cornerRadius = 22;
        [self login];
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


- (WCTextField *)nameText{
    if (!_nameText) {
        _nameText = [[WCTextField alloc]initWithFrame:CGRectMake(0, 0, (270/414.0)*SCREEN_W, 30/736.0*SCREEN_H)];
        _nameText.center = CGPointMake(self.view.center.x, 350/736.0*SCREEN_H);
        _nameText.ly_placeholder = @"用户名";
        _nameText.tag = 0;
    }
    return _nameText;
}

- (WCTextField *)pwd{
    if (!_pwd) {
        _pwd = [[WCTextField alloc]initWithFrame:CGRectMake(0, 0, 270/414.0*SCREEN_W, 30/736.0*SCREEN_H)];
        _pwd.center = CGPointMake(self.view.center.x, self.nameText.center.y+60/736.0*SCREEN_H);
        _pwd.ly_placeholder = @"密码";
        _pwd.tag = 1;
    }
    return _pwd;
}



@end
