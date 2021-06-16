//
//  PrivateChatAlert.h
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "LxCustomAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface PrivateChatAlert : LxCustomAlert
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property(nonatomic,copy) void(^btnclickBlock)(NSInteger index);
- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
