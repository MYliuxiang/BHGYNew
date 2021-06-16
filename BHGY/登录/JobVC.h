//
//  JobVC.h
//  BHGY
//
//  Created by liuxiang on 2020/7/20.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy) void(^jobBlock)(NSString *job);

@end

NS_ASSUME_NONNULL_END
