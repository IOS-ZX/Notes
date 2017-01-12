//
//  RecordModel.h
//  Notes
//
//  Created by rimi on 2017/1/11.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

typedef NS_ENUM(NSInteger,RecordType){
    text = 0,
    image,
    file,
    record
};

#import <Foundation/Foundation.h>

@interface RecordModel : NSObject

/** id **/
@property(nonatomic,assign)NSInteger nid;

/** 标题 **/
@property(nonatomic,strong)NSString *title;

/** content **/
@property(nonatomic,strong)NSString *content;

/** 类型 **/
@property(nonatomic,assign)RecordType type;

/** 图片 **/
@property(nonatomic,strong)NSString *images;

/** 文件 **/
@property(nonatomic,strong)NSString *files;

/** 修改时间 **/
@property(nonatomic,strong)NSString *date;

/** 草稿标识符 **/
@property(nonatomic,assign)NSInteger isTemp;

/** 储存到服务器 **/
- (void)saveInCloud;

/** 储存到本地 **/
- (void)saveInLocation;

@end
