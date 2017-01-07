//
//  MessageCell.m
//  WeChatLayout
//
//  Created by Iracle Zhang on 5/10/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

#import "MessageCell.h"
#import "UIImage+Resizingable.h"
#import "IracleConfig.h"

@interface MessageCell ()

@property (strong, nonatomic)  UIImageView *anotherImageView;
@property (strong, nonatomic)  UIImageView *myselfImageView;
@property (strong, nonatomic)  UIButton *anotherMessageButton;
@property (strong, nonatomic)  UIButton *myselfMessageButton;
@property (strong, nonatomic)  UILabel *timeLabel;
@end

@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];

    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.anotherImageView];
    [self.contentView addSubview:self.myselfImageView];
    [self.contentView addSubview:self.anotherMessageButton];
    [self.contentView addSubview:self.myselfMessageButton];
}


- (NSString *)getPicture:(MessageWho) who {
    return who == MessageWhoIsMe? @"myself": @"another";
}

- (NSString *)getMessageBackPicture:(MessageWho) who {
    return who == MessageWhoIsMe? @"chat_send_nor": @"chat_recive_nor";
    
}

- (CGRect)updateMessageFrame:(NSString *)content type:(MessageWho) who{
    
    CGRect frame = [content boundingRectWithSize:CGSizeMake(200, 350) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
    //由于要向内设置偏移量，为了把把button里的label压缩的不见，所以要把自适应的宽和高增加一些。
    if (who == MessageWhoIsMe) {
        return  CRM(SCREEN_WIDTH - frame.size.width - 90, CGRectGetMaxY(self.timeLabel.frame), frame.size.width + 30, frame.size.height + 15);
    } else {
       return   CRM(CGRectGetMaxX(self.anotherImageView.frame) + 10, CGRectGetMaxY(self.timeLabel.frame), frame.size.width + 30, frame.size.height + 15);
    }
}

- (void)setMessage:(Message *)message {
    //获取数据
    _message = message;
    MessageWhoIsMe == _message.type?
    [self setShowButton:self.myselfMessageButton andIcon:self.myselfImageView withMessage:message]:
    [self setShowButton:self.anotherMessageButton andIcon:self.anotherImageView withMessage:message];
}

- (void)setShowButton:(UIButton *)text andIcon:(UIImageView *)icon withMessage:(Message*)message {
    //设置要展示的消息内容与头像
    _myselfImageView.hidden = _myselfMessageButton.hidden = (text != _myselfMessageButton);
    _anotherImageView.hidden = _anotherMessageButton.hidden = (text != _anotherMessageButton);
    
    [text setBackgroundImage:[UIImage resizeWithImageName:[self getMessageBackPicture:message.type]] forState:UIControlStateNormal];
    //根据消息文本计算标签的布局，更新frame
    text.frame = [self updateMessageFrame:message.text type:message.type];

    icon.image = [UIImage imageNamed:[self getPicture:message.type]];
    [text setTitle:message.text forState:UIControlStateNormal];
    _timeLabel.text = message.time;
    //计算cell的高度
    CGFloat textH = CGRectGetMaxY(text.frame);
    CGFloat iconH = CGRectGetMaxY(icon.frame);
    CGFloat cellH = MAX(textH, iconH) + 10;
    message.height = cellH;
}

#pragma mark -- getter

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.bounds = CRM(0, 0, MID_X, 20);
        _timeLabel.center = CPM(MID_X, 10);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:13];
//        _timeLabel.backgroundColor = [UIColor redColor];
        
    }
    return _timeLabel;
}

- (UIImageView *)anotherImageView {
    if (!_anotherImageView) {
        _anotherImageView = [[UIImageView alloc] initWithFrame:CRM(10, CGRectGetMaxY(self.timeLabel.frame), 40, 40)];
//        _anotherImageView.backgroundColor = [UIColor redColor];
    }
    return _anotherImageView;
}

- (UIImageView *)myselfImageView {
    if (!_myselfImageView) {
        _myselfImageView = [[UIImageView alloc] initWithFrame:CRM(SCREEN_WIDTH - 40 - 10, CGRectGetMaxY(self.timeLabel.frame), 40, 40)];
//        _myselfImageView.backgroundColor = [UIColor redColor];
        
        
    }
    return _myselfImageView;
}

- (UIButton *)anotherMessageButton {
    if (!_anotherMessageButton) {
        _anotherMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _anotherMessageButton.frame = CRM(CGRectGetMaxX(self.anotherImageView.frame) + 10, CGRectGetMaxY(self.timeLabel.frame), 120, 50);
//        _anotherMessageButton.backgroundColor = [UIColor yellowColor];
        [_anotherMessageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _anotherMessageButton.titleLabel.font = [UIFont systemFontOfSize:12];
        //设置标题显示多行
        _anotherMessageButton.titleLabel.numberOfLines = 0;
        //设置button的内偏移量，让按钮的title往里压缩
        _anotherMessageButton.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
     }
    return _anotherMessageButton;
}

- (UIButton *)myselfMessageButton {
    if (!_myselfMessageButton) {
        _myselfMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _myselfMessageButton.frame = CRM(SCREEN_WIDTH - 180, CGRectGetMaxY(self.timeLabel.frame), 120, 50);
//        _myselfMessageButton.backgroundColor = [UIColor yellowColor];
        [_myselfMessageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _myselfMessageButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _myselfMessageButton.titleLabel.numberOfLines = 0;
        _myselfMessageButton.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    }
    return _myselfMessageButton;
}


@end

















