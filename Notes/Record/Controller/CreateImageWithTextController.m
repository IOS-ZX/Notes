//
//  CreateImageWithTextController.m
//  Notes
//
//  Created by rimi on 2017/1/10.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "CreateImageWithTextController.h"

@interface CreateImageWithTextController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,YYTextViewDelegate>

/** 标题栏 **/
@property(nonatomic,strong)UITextField *titleText;

/** 富文本 **/
@property(nonatomic,strong)NSMutableAttributedString *text;

/** 内容 **/
@property(nonatomic,strong)YYTextView *textView;

/** model **/
@property(nonatomic,strong)RecordModel *model;

/** 是否已经储存 **/
@property(nonatomic,assign)BOOL isSave;

/** 图片选择 **/
@property(nonatomic,strong)UIImagePickerController *picker;

/** 工具栏 **/
@property(nonatomic,strong)UIView *bottomTool;

/** 图片识别 **/
@property(nonatomic,strong)UIButton *images;

/** 语音输入 **/
@property(nonatomic,strong)UIButton *record;

/** 添加图片 **/
@property(nonatomic,strong)UIButton *addImage;

@end

@implementation CreateImageWithTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 自定义方法

- (void)initView{
    self.view.backgroundColor = [UIColor hexColor:@"f1f2f3"];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(backView:)];
    self.navigationItem.leftBarButtonItem = back;
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)backView:(UIBarButtonItem*)item{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification

{
    CGRect frame = self.view.frame;
    //键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.4 animations:^{
        self.view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, SCREEN_H - keyBoardFrame.size.height);
    }];
}



-(void)keyboardWillBeHidden:(NSNotification*)aNotification

{
    CGRect frame = self.view.frame;
    //键盘高度
    //    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.4 animations:^{
        self.view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, SCREEN_H);
    }];
}

- (void)saveNotes:(UIBarButtonItem*)sender{
    self.model.title = self.titleText.text;
    self.model.content = self.textView.text;
    self.isSave = YES;
    [self.model saveInCloud];
}

- (void)saveLocation{
    NSString *title = self.titleText.text;
    NSString *content = self.textView.text;
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    if (!self.isSave && content.length > 0) {
        self.model.title = title;
        self.model.content = content;
        self.model.type = text;
        self.model.isTemp = 1;
        self.model.date = [formatter stringFromDate:date];
        [self.model saveInLocation];
    }
}

- (void)initDatas{
    self.isSave = NO;
    if (self.model.content.length > 0) {
        NSLog(@"存在草稿数据");
        self.titleText.text = self.model.title;
        self.textView.text = self.model.content;
    }else{
        NSLog(@"没有草稿数据");
    }
}

- (void)setUpUI{
    __weak typeof(self) weakSelf = self;
    [self.titleText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.view.mas_width).offset(-20);
        make.height.mas_equalTo(35);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.top.equalTo(weakSelf.view.mas_top).offset(74);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.titleText.mas_width);
        make.centerX.equalTo(weakSelf.titleText.mas_centerX);
        make.top.equalTo(weakSelf.titleText.mas_bottom).offset(10);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-50);
    }];
    
    [self.bottomTool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_W, 40));
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.left.equalTo(weakSelf.view.mas_left);
    }];
    [self.images mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(weakSelf.bottomTool.mas_centerY);
        make.centerX.mas_equalTo(- SCREEN_W * 0.3);
    }];
    [self.record mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.images.mas_width);
        make.height.equalTo(weakSelf.images.mas_height);
        make.centerY.equalTo(weakSelf.images.mas_centerY);
        make.centerX.mas_equalTo(0);
    }];
    [self.addImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.record.mas_width);
        make.height.equalTo(weakSelf.record.mas_height);
        make.centerY.equalTo(weakSelf.record.mas_centerY);
        make.centerX.mas_equalTo(SCREEN_W * 0.3);
    }];
}

- (void)showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *chooseAlert = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self openImagePicker];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self openImagePicker];
    }];
    [alert addAction:chooseAlert];
    [alert addAction:camera];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)openImagePicker{
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        NSLog(@"资源类型不存在");
//        return;
//    }
    if (self.picker.sourceType == UIImagePickerControllerSourceTypeCamera && ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"相机不可用");
        return;
    }
    [self presentViewController:self.picker animated:YES completion:nil];
}

- (void)textViewDidChange:(YYTextView *)textView{
    self.text = [[NSMutableAttributedString alloc]initWithAttributedString:textView.attributedText];
}

/** 选择图片 **/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
    imageView.image = image;
    NSMutableAttributedString *str = nil;
    str = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.frame.size alignToFont:[UIFont systemFontOfSize:16] alignment:YYTextVerticalAlignmentCenter];
    [self.text appendAttributedString:str];
    self.textView.attributedText = self.text;
    NSLog(@"text:%@",self.textView.attributedText);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 图片识别
- (void)imageDiscernment:(UIButton*)sender{
    
}

// 语音输入
- (void)audioInput:(UIButton*)sender{
    
}

// 添加图片
- (void)addImages:(UIButton*)sender{
    
}


#pragma mark - 懒加载

- (UITextField *)titleText{
    if (!_titleText) {
        _titleText = [UITextField new];
        _titleText.placeholder = @"标题（可选）";
        _titleText.backgroundColor = [UIColor whiteColor];
        _titleText.layer.cornerRadius = 3;
        _textView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _titleText.layer.masksToBounds = YES;
        [self.view addSubview:_titleText];
    }
    return _titleText;
}

- (YYTextView *)textView{
    if (!_textView) {
        _textView = [YYTextView new];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.placeholderText = @"内容最少20字";
        _textView.layer.cornerRadius = 6;
        _textView.layer.masksToBounds = YES;
        _textView.delegate = self;
        [self.view addSubview:_textView];
    }
    return _textView;
}

- (RecordModel *)model{
    if (!_model) {
        _model = [[NotesSQLiteManager sheardManager]selectByTemp:@1 type:text];
        NSLog(@"草稿信息：%@",_model);
    }
    return _model;
}

- (UIView *)bottomTool{
    if (!_bottomTool) {
        _bottomTool = [UIView new];
        _bottomTool.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_bottomTool];
    }
    return _bottomTool;
}

- (UIButton *)images{
    if (!_images) {
        _images = [UIButton new];
        [_images setImage:[UIImage imageNamed:@"人机识别"] forState:UIControlStateNormal];
        [_images addTarget:self action:@selector(imageDiscernment:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomTool addSubview:_images];
    }
    return _images;
}

- (UIButton *)record{
    if (!_record) {
        _record = [UIButton new];
        [_record setImage:[UIImage imageNamed:@"语音输入"] forState:UIControlStateNormal];
        [_record addTarget:self action:@selector(audioInput:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomTool addSubview:_record];
    }
    return _record;
}

- (UIButton *)addImage{
    if (!_addImage) {
        _addImage = [UIButton new];
        [_addImage addTarget:self action:@selector(addImages:) forControlEvents:UIControlEventTouchUpInside];
        [_addImage setImage:[UIImage imageNamed:@"添加图片"] forState:UIControlStateNormal];
        [_addImage addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomTool addSubview:_addImage];
    }
    return _addImage;
}

- (UIImagePickerController *)picker{
    if (!_picker) {
        _picker = [[UIImagePickerController alloc]init];
        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _picker.delegate = self;
        _picker.allowsEditing = YES;
    }
    return _picker;
}

- (NSMutableAttributedString *)text{
    if (!_text) {
        _text = [NSMutableAttributedString new];
    }
    return _text;
}

@end
