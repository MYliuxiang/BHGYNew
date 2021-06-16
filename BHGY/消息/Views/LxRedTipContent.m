//
//  LxRedTipContent.m
//  BHGY
//
//  Created by liuxiang on 2020/8/6.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "LxRedTipContent.h"

@implementation LxRedTipContent
///初始化
+ (instancetype)messageWithredMessageID:(NSString *)messageID{
    LxRedTipContent *text = [[LxRedTipContent alloc] init];
    if (text) {
        text.redMessageID = messageID;
        
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
        self.redMessageID = [aDecoder decodeObjectForKey:@"redMessageID"];
       
        
    }
    return self;
}

/// NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.redMessageID forKey:@"redMessageID"];
  

    
}

///将消息内容编码成json
- (NSData *)encode {
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [dataDict setObject:self.redMessageID forKey:@"redMessageID"];

   

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
            self.redMessageID = dictionary[@"redMessageID"];
            NSDictionary *userinfoDic = dictionary[@"user"];
            [self decodeUserInfo:userinfoDic];
        }
    }
}

/// 会话列表中显示的摘要
- (NSString *)conversationDigest {
    
    if ([self.senderUserInfo.userId isEqualToString:[RCIM sharedRCIM].currentUserInfo.userId]) {
        return [NSString stringWithFormat:@"你领取了红包"];
    }
    
    RCUserInfo *userInfo = [[RCIM sharedRCIM] getUserInfoCache:self.senderUserInfo.userId];
    
    return [NSString stringWithFormat:@"%@收取了红包",userInfo.name];
}

///消息的类型名
+ (NSString *)getObjectName {
    return LxRedTipMessageIdentifier;
}
@end
