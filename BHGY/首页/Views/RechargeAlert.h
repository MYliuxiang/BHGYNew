//
//  RechargeAlert.h
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "LxCustomAlert.h"
#import "RechargeCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface RechargeAlert : LxCustomAlert<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (instancetype)init;
@end

NS_ASSUME_NONNULL_END
