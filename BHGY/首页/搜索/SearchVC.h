//
//  SearchVC.h
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchVC : BaseViewController
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *online;
@property(nonatomic,copy)NSString *cities;
@property(nonatomic,assign) int index;

@end

NS_ASSUME_NONNULL_END
