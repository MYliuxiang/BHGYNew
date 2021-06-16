//
//  LXRedMessageCell.h
//  BHGY
//
//  Created by liuxiang on 2020/8/6.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
#import "LXRedMessageContent.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXRedMessageCell : RCMessageBaseCell

/*!
 背景View
 */
@property (nonatomic, strong) UIView *redView;

@property (nonatomic,strong) UIImageView *redImg;

@property (nonatomic,strong) UILabel *titleLab;

@property (nonatomic,strong) UILabel *statesLab;

@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) UILabel *logoLab;





/*!
 根据消息内容获取显示的尺寸

 @param message 消息内容

 @return 显示的View尺寸
 */
+ (CGSize)getBubbleBackgroundViewSize:(LXRedMessageContent *)message;
@end

NS_ASSUME_NONNULL_END
