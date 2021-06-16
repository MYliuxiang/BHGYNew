//
//  SubDynamicVC.h
//  BHGY
//
//  Created by liuxiang on 2020/7/8.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BaseViewController.h"
#import "DynamicCell.h"
#import "DetailDynamicVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubDynamicVC : BaseViewController<JXPagerViewListViewDelegate>
@property(nonatomic,strong) NSMutableArray *dataList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
