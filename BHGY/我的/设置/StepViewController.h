//
//  StepViewController.h
//  BHGY
//
//  Created by 李立 on 2020/7/9.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface StepViewController : BaseViewController
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign)  float sizsirng; //计算缓存
@end

NS_ASSUME_NONNULL_END
