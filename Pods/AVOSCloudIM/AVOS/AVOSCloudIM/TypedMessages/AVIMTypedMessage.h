//
//  AVIMTypedMessage.h
//  AVOSCloudIM
//
//  Created by Qihe Bian on 1/8/15.
//  Copyright (c) 2014 LeanCloud Inc. All rights reserved.
//

#import "AVIMMessage.h"

@class AVFile;
@class AVGeoPoint;

typedef int8_t AVIMMessageMediaType;

//SDK定义的消息类型，自定义类型使用大于0的值
enum : AVIMMessageMediaType {
    kAVIMMessageMediaTypeNone = 0,
    kAVIMMessageMediaTypeText = -1,
    kAVIMMessageMediaTypeImage = -2,
    kAVIMMessageMediaTypeAudio = -3,
    kAVIMMessageMediaTypeVideo = -4,
    kAVIMMessageMediaTypeLocation = -5,
    kAVIMMessageMediaTypeFile = -6
};

NS_ASSUME_NONNULL_BEGIN

@protocol AVIMTypedMessageSubclassing <NSObject>
@required
/*!
 子类实现此方法用于返回该类对应的消息类型
 @return 消息类型
 */
+ (AVIMMessageMediaType)classMediaType;
@end

/**
 *  Base class for rich media message.
 */
@interface AVIMTypedMessage : AVIMMessage

@property (nonatomic, assign)                     AVIMMessageMediaType  mediaType;  // 消息类型，可自定义
@property (nonatomic,   copy, nullable)           NSString             *text;       // 消息文本
@property (nonatomic, strong, nullable)           NSDictionary         *attributes; // 自定义属性
@property (nonatomic, strong, readonly, nullable) AVFile               *file;       // 附件
@property (nonatomic, strong, readonly, nullable) AVGeoPoint           *location;   // 位置

/**
 * Add custom property for message.
 *
 * @param object The property value.
 * @param key    The property name.
 */
- (void)setObject:(nullable id)object forKey:(NSString *)key;

/**
 *  子类调用此方法进行注册，一般可在子类的 [+(void)load] 方法里面调用
 */
+ (void)registerSubclass;

/*!
 使用本地文件，创建消息。
 @param text － 消息文本。
 @param attachedFilePath － 本地文件路径。
 @param attributes － 用户附加属性。
 */
+ (instancetype)messageWithText:(NSString *)text
               attachedFilePath:(NSString *)attachedFilePath
                     attributes:(nullable NSDictionary *)attributes;

/*!
 使用 AVFile，创建消息。
 @param text － 消息文本。
 @param file － AVFile 对象。
 @param attributes － 用户附加属性。
 */
+ (instancetype)messageWithText:(NSString *)text
                           file:(AVFile *)file
                     attributes:(nullable NSDictionary *)attributes;

@end

NS_ASSUME_NONNULL_END
