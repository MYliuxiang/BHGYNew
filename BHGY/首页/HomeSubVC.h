//
//  HomeSubVC.h
//  BHGY
//
//  Created by liuxiang on 2020/7/6.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeSubVC : BaseViewController<JXCategoryListContentViewDelegate>
@property(nonatomic,assign) int index;

@property(nonatomic,assign) NSString *sex;
@property(nonatomic,assign) NSString *online;
@property(nonatomic,copy) NSString *cities;


@end

NS_ASSUME_NONNULL_END
