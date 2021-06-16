//
//  HomeDetailVC.h
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BaseViewController.h"
#import "MoreAlert.h"
#import "PrivateChatAlert.h"
#import "PayAlert.h"
#import "RechargeAlert.h"
#import "RemarkVC.h"
#import "ReportVC.h"
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeDetailVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)HomeModel *model;

@property(nonatomic,copy) void(^blackBlock)(HomeModel *model);

@end

NS_ASSUME_NONNULL_END
