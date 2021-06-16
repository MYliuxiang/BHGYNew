//
//  SendRedVC.h
//  BHGY
//
//  Created by liuxiang on 2020/7/12.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SendRedVC : BaseViewController<UITextFieldDelegate>

@property(nonatomic,copy) void(^sendBlock)(NSDictionary *redDic);
@property (nonatomic,copy) NSString *senderId;
@end

NS_ASSUME_NONNULL_END
