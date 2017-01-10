//
//  MainTableHeaderView.m
//  Notes
//
//  Created by rimi on 2017/1/10.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "MainTableHeaderView.h"

@interface MainTableHeaderView()

/** 左边图标 **/
@property(nonatomic,strong)UIImageView *leftImage;
/** 右边图标 **/
@property(nonatomic,strong)UIImageView *rightImage;

/** 底部分割线 **/
@property(nonatomic,strong)UIView *bottomLine;

@end

@implementation MainTableHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_W - 20, 40);
        self.backgroundColor = [UIColor whiteColor];
        [self setUpUI];
        self.leftLabel.text = @"笔记";
        [self.rightBtn setTitle:@"全部" forState:UIControlStateNormal];
    }
    return self;
}


- (void)setUpUI{
    __weak typeof(self) weakSelf = self;
    [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10);
    }];
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(weakSelf.leftImage.mas_height);
        make.width.mas_equalTo(20);
        make.right.equalTo(weakSelf.mas_right);
        make.centerY.equalTo(weakSelf.leftImage.mas_centerY);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(weakSelf.leftImage.mas_height);
        make.width.mas_equalTo(45);
        make.centerY.equalTo(weakSelf.rightImage.mas_centerY);
        make.right.equalTo(weakSelf.rightImage.mas_left);
    }];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.leftImage.mas_centerY);
        make.height.equalTo(weakSelf.mas_height);
        make.left.equalTo(weakSelf.leftImage.mas_right).offset(10);
        make.right.equalTo(weakSelf.rightBtn.mas_right).offset(-10);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.mas_width);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
    }];
}

#pragma mark - 懒加载

- (UIImageView *)leftImage{
    if (!_leftImage) {
        _leftImage = [UIImageView new];
        _leftImage.image = [UIImage imageNamed:@"笔记"];
        [self addSubview:_leftImage];
    }
    return _leftImage;
}

- (UIImageView *)rightImage{
    if (!_rightImage) {
        _rightImage = [UIImageView new];
        _rightImage.image = [UIImage imageNamed:@"前进"];
        [self addSubview:_rightImage];
    }
    return _rightImage;
}

- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [UILabel new];
        _leftLabel.textColor = [UIColor hexColor:@"00CCFF"];
        [self addSubview:_leftLabel];
    }
    return _leftLabel;
}

- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton new];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_rightBtn setTitleColor:[UIColor hexColor:@"00CCFF"] forState:UIControlStateNormal];
        [self addSubview:_rightBtn];
    }
    return _rightBtn;
}

- (UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = [UIColor hexColor:@"f1f2f3"];
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

@end
