//
//  MeViewController.m
//  Notes
//
//  Created by rimi on 2017/1/7.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我";
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(backView:)];
    self.navigationItem.leftBarButtonItem = back;
}

- (void)backView:(UIBarButtonItem*)item{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    if (self.navigationController.navigationBar.hidden) {
        NSLog(@"隐藏");
    }else{
        NSLog(@"显示");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
