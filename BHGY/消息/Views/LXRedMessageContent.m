//
//  LXRedMessageContent.m
//  BHGY
//
//  Created by liuxiang on 2020/8/6.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "LXRedMessageContent.h"

@implementation LXRedMessageContent
///初始化
+ (instancetype)messageWithContent:(NSString *)content withTitle:(NSString *)title{
    LXRedMessageContent *text = [[LXRedMessageContent alloc] init];
    if (text) {
        text.content = content;
        text.status = 0;
        text.redtitle = title;
    }
    return text;
}

//消息是否存储，是否计入未读数
+ (RCMessagePersistent)persistentFlag {
    return (MessagePersistent_ISPERSISTED | MessagePersistent_ISCOUNTED);
}

// NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.status = [aDecoder decodeIntForKey:@"status"];
        self.extra = [aDecoder decodeObjectForKey:@"extra"];
        self.redtitle = [aDecoder decodeObjectForKey:@"redtitle"];

        
    }
    return self;
}

/// NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeInt:self.status forKey:@"status"];
    [aCoder encodeObject:self.extra forKey:@"extra"];
    
    [aCoder encodeObject:self.redtitle forKey:@"redtitle"];

    
}

///将消息内容编码成json
- (NSData *)encode {
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [dataDict setObject:self.content forKey:@"content"];
    [dataDict setObject:self.redtitle forKey:@"redtitle"];

    [dataDict setObject:[NSString stringWithFormat:@"%d",self.status] forKey:@"status"];
    if (self.extra) {
        [dataDict setObject:self.extra forKey:@"extra"];
    }

    if (self.senderUserInfo) {
        [dataDict setObject:[self encodeUserInfo:self.senderUserInfo] forKey:@"user"];
    }

    NSData *data = [NSJSONSerialization dataWithJSONObject:dataDict options:kNilOptions error:nil];
    return data;
}

///将json解码生成消息内容
- (void)decodeWithData:(NSData *)data {
    if (data) {
        __autoreleasing NSError *error = nil;

        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

        if (dictionary) {
            self.content = dictionary[@"content"];
            self.extra = dictionary[@"extra"];
            self.status = [dictionary[@"status"] intValue];
            self.redtitle = dictionary[@"redtitle"];

            
            NSDictionary *userinfoDic = dictionary[@"user"];
            [self decodeUserInfo:userinfoDic];
        }
    }
}

/// 会话列表中显示的摘要
- (NSString *)conversationDigest {
    return @"红包";
    return self.content;
}

///消息的类型名
+ (NSString *)getObjectName {
    
    return LXRedMessageTypeIdentifier;
}
@end
