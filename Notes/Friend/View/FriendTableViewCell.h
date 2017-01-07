//
//  FriendTableViewCell.h
//  Notes
//
//  Created by rimi on 2017/1/7.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *num;

@end
