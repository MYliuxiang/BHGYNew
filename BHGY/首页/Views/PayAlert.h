//
//  PayAlert.h
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "LxCustomAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayAlert : LxCustomAlert
@property (weak, nonatomic) IBOutlet UIButton *czB;
@property (weak, nonatomic) IBOutlet UIButton *payB;
@property (weak, nonatomic) IBOutlet UIButton *seeB;

@property(nonatomic,copy) void(^clickBlock)(NSInteger index);
- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
