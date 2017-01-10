//
//  MainNotesCell.h
//  Notes
//
//  Created by rimi on 2017/1/10.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainNotesCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UIView *bottomLine;

@end
