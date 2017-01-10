//
//  SecondInterfaceViewController.m
//  Notes
//
//  Created by 王灿 on 2017/1/9.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "SecondInterfaceViewController.h"
#import "WCalertView.h"

@interface SecondInterfaceViewController ()

@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)UITextField *oldPassword;
@property(nonatomic,strong)UITextField *NewPassword;
@property(nonatomic,strong)UITextField *surePassword;
@property(nonatomic,strong)UIAlertController *alert;
@end

@implementation SecondInterfaceViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

-(void)setUI{
    self.view.backgroundColor = [UIColor whiteColor];
    for (NSInteger index = 0; index<3; index++) {
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(0, 64+(50*index), 100, 50);
        label.text = self.array[index];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:15];
        UIView *lineView = [UIView new];
        lineView.frame = CGRectMake(0, 115+(50*index), SCREEN_W, 1);
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:lineView];
        [self.view addSubview:label];
    }
    [self.view addSubview:self.oldPassword];
    [self.view addSubview:self.NewPassword];
    [self.view addSubview:self.surePassword];
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    sureButton.center = CGPointMake(self.view.center.x, self.view.center.y);
    sureButton.backgroundColor = [UIColor colorWithRed:0 green:255 blue:151 alpha:1];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton setTitle:@"确认修改" forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureClicked) forControlEvents:UIControlEventTouchUpInside];
    sureButton.layer.cornerRadius = 10;
    [self.view addSubview:sureButton];
}
-(void)sureClicked{
    if (!(self.NewPassword.text.length>6||self.surePassword.text.length>6)) {
       UIAlertController *alert = [WCalertView title:@"警告" message:@"请输入6位以上密码" type:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:^{
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(remove) userInfo:nil repeats:NO];
        }];
    }else{
    if ([self.NewPassword.text isEqualToString:self.surePassword.text]) {
        //修改成功上传至服务器
        NSLog(@"修改成功");
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次输入的新密码不一致，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:^{
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(remove) userInfo:nil repeats:NO];
        }];
    }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)remove{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(NSArray *)array{
    if (!_array) {
        _array = @[@"旧密码:",@"新密码:",@"确认新密码:"];
    }
    return _array;
}


-(UITextField *)oldPassword{
    if (!_oldPassword) {
        _oldPassword = [[UITextField alloc]initWithFrame:CGRectMake(110, 70, 200, 40)];
        _oldPassword.borderStyle = UITextBorderStyleRoundedRect;
        _oldPassword.secureTextEntry = YES;
    }
    return _oldPassword;
}
-(UITextField *)NewPassword{
    if (!_NewPassword) {
        _NewPassword = [[UITextField alloc]initWithFrame:CGRectMake(110, 120, 200, 40)];
        _NewPassword.borderStyle = UITextBorderStyleRoundedRect;
        _NewPassword.secureTextEntry = YES;
    }
    return _NewPassword;
}
-(UITextField *)surePassword{
    if (!_surePassword) {
        _surePassword = [[UITextField alloc]initWithFrame:CGRectMake(110, 170, 200, 40)];
        _surePassword.borderStyle = UITextBorderStyleRoundedRect;
        _surePassword.secureTextEntry = YES;
    }
    return _surePassword;
}


@end
