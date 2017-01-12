//
//  RecordModel.m
//  Notes
//
//  Created by rimi on 2017/1/11.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "RecordModel.h"
#import "NotesSQLiteManager.h"

@interface RecordModel()

/** 上传count **/
@property(nonatomic,assign)NSInteger fileCount;

/** images Urls **/
@property(nonatomic,strong)NSMutableArray *imageArray;

/** files url **/
@property(nonatomic,strong)NSMutableArray *fileArray;

@end

@implementation RecordModel

- (void)saveInCloud{
    if (self.images || self.files) {
        [self uploadImages];
    }else{
        [self saveInfo];
    }
}

- (void)saveInfo{
    self.isTemp = 0;
    AVObject *obj = [AVObject objectWithClassName:@"noteContent"];
    [obj setObject:self.title forKey:@"title"];
    [obj setObject:self.content forKey:@"content"];
    if (self.imageArray.count > 0) {
        [obj setObject:[self.imageArray componentsJoinedByString:@"<image>"] forKey:@"images"];
    }
    if (self.fileArray.count > 0) {
        [obj setObject:[self.fileArray componentsJoinedByString:@"<file>"] forKey:@"images"];
    }
    switch (self.type) {
        case text:
            [obj setObject:@"text" forKey:@"type"];
            break;
        case image:
            [obj setObject:@"image" forKey:@"type"];
            break;
        case file:
            [obj setObject:@"file" forKey:@"type"];
            break;
        case record:
            [obj setObject:@"record" forKey:@"type"];
            break;
    }
    [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"存储云端失败:%@",error);
            self.isTemp = 1;
            [self saveInLocation];
        }else{
            NSLog(@"存储云端成功");
            [self saveInLocation];
        }
    }];
}

- (void)saveInLocation{
    NSLog(@"存储model：%@",self);
    BOOL success = [[NotesSQLiteManager sheardManager]insertData:self];
    if (success) {
        NSLog(@"本地存储成功");
    }else{
        NSLog(@"本地存储失败");
    }
}

- (void)uploadImages{
    __weak typeof(self) weakSelf = self;
    [self addObserver:self forKeyPath:@"fileCount" options:NSKeyValueObservingOptionNew context:nil];
    NSArray *image1 = [self.images componentsSeparatedByString:@"<file>"];
    [image1 enumerateObjectsUsingBlock:^(NSString * _Nonnull path, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"images"];
        imagePath = [imagePath stringByAppendingPathComponent:path];
        [weakSelf uploadFile:path path:imagePath type:image];
    }];
    
    NSArray *files = [self.files componentsSeparatedByString:@"<file>"];
    [files enumerateObjectsUsingBlock:^(NSString * _Nonnull path, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"files"];
        filePath = [filePath stringByAppendingPathComponent:path];
        [weakSelf uploadFile:path path:filePath type:file];
    }];
}

- (void)uploadFile:(NSString*)fileName path:(NSString*)path type:(RecordType)type{
    __weak typeof(self) weakSelf = self;
    AVFile *file1 = [AVFile fileWithName:fileName contentsAtPath: path];
    [file1 saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        //上传处理
        if (error) {
            NSLog(@"上传失败：%@",error);
        }else{
            weakSelf.fileCount++;
            NSLog(@"上传成功");
            if (type == image) {
                [weakSelf.imageArray addObject:file1.url];
            }else if(type == file){
                [weakSelf.fileArray addObject:file1.url];
            }
        }
    } progressBlock:^(NSInteger percentDone) {
        //上传进度
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSArray *images = [self.images componentsSeparatedByString:@"<image>"];
    NSArray *files = [self.files componentsSeparatedByString:@"<file>"];
    if (self.fileCount == images.count + files.count) {
        NSLog(@"所有数据上传成功");
        [self removeObserver:self forKeyPath:@"fileCount"];
        [self saveInfo];
    }
}

- (NSString *)description{
    return [NSString stringWithFormat:@"id:%ld,title:%@,content:%@,type:%ld,temp:%ld",self.nid,self.title,self.content,self.type,self.isTemp];
}

- (NSMutableArray *)fileArray{
    if (!_fileArray) {
        _fileArray = [NSMutableArray array];
    }
    return _fileArray;
}

- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

@end
