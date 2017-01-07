//
//  BaseNavigationController.m
//  Notes
//
//  Created by rimi on 2017/1/7.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTintColor:[UIColor hexColor:@"00CCFF"]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor hexColor:@"00CCFF"]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
