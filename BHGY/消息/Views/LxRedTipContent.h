//
//  LxRedTipContent.h
//  BHGY
//
//  Created by liuxiang on 2020/8/6.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

NS_ASSUME_NONNULL_BEGIN
#define LxRedTipMessageIdentifier @"LX:RedTip"


@interface LxRedTipContent : RCMessageContent

@property (nonatomic, strong) NSString *redMessageID;

+ (instancetype)messageWithredMessageID:(NSString *)messageID;
@end

NS_ASSUME_NONNULL_END
