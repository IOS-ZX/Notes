//
//  ChangePersonTableView.m
//  Notes
//
//  Created by 王灿 on 2017/1/9.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "ChangePersonTableView.h"
#import "SecondInterfaceViewController.h"

@interface ChangePersonTableView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)UIAlertController *alert;
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIButton *sureButton;
@property(nonatomic,strong)UIButton *cancelButton;

@end

@implementation ChangePersonTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:[NSString stringWithFormat:@"%ld",indexPath.row] forKey:@"tag"];
    if (indexPath.row == 0) {
    SecondInterfaceViewController *svc = [[SecondInterfaceViewController alloc]init];
        [self.navigationController pushViewController:svc animated:YES];
    }else if(indexPath.row == 1){
        self.alert.textFields[0].text = @"";
        [self presentViewController:self.alert animated:YES completion:nil];
    }else if (indexPath.row == 2){
        [self.view addSubview:self.pickerView];
        [self.view addSubview:self.sureButton];
        [self.view addSubview:self.cancelButton];
    }
   
}
#pragma pickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 30)];
    label.center = self.pickerView.center;
    label.textAlignment = NSTextAlignmentCenter;
    if (row == 0) {
        label.text = @"男";
    }else{
        label.text = @"女";
    }
    
    return label;
}
-(void)clickedCancel{
    [self.pickerView removeFromSuperview];
    [self.sureButton removeFromSuperview];
    [self.cancelButton removeFromSuperview];
}
-(void)clickedSure{
    [self.sureButton removeFromSuperview];
    [self.cancelButton removeFromSuperview];
    [self.pickerView removeFromSuperview];
}

#pragma 懒加载
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"修改密码",@"修改昵称",@"修改性别"];
    }
    return _titleArray;
}
-(UIAlertController *)alert{
    if (!_alert) {
        _alert = [UIAlertController alertControllerWithTitle:@"修改昵称" message:@"请输入你要修改的昵称" preferredStyle:UIAlertControllerStyleAlert];
        [_alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入你的新昵称";
        }];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"输入框中的文字%@",_alert.textFields[0].text);
        }];
        [_alert addAction:action];
        [_alert addAction:sureAction];
    }
    return _alert;
}
-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 100)];
        _pickerView.center = CGPointMake(self.view.center.x, self.view.center.y);
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        
        
    }
    return _pickerView;
}
-(UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 200, 40, 30)];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(clickedSure) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}
-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-50, 200, 40, 30)];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(clickedCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}


@end
