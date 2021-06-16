//
//  LXRedMessageContent.h
//  BHGY
//
//  Created by liuxiang on 2020/8/6.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

#define LXRedMessageTypeIdentifier @"LX:RedMsg"

NS_ASSUME_NONNULL_BEGIN

@interface LXRedMessageContent : RCMessageContent<NSCoding>
/*!
 测试消息的内容
 */
@property (nonatomic, strong) NSString *content;

@property (nonatomic, assign) int status;

@property (nonatomic, strong) NSString *redtitle;



/*!
 测试消息的附加信息
 */
@property (nonatomic, strong) NSString *extra;

/*!
 初始化测试消息

 @param content 文本内容
 @return        测试消息对象
 */
+ (instancetype)messageWithContent:(NSString *)content withTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
