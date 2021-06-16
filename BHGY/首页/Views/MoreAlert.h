//
//  MoreAlert.h
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "LxCustomAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface MoreAlert : LxCustomAlert<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *cancleB;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property(nonatomic,strong) NSArray *contents;
@property(nonatomic,strong) UIColor *btnColor;


@property(nonatomic,copy) void(^clickBlcok)(NSInteger index);
- (instancetype)initWithContents:(NSArray *)contents;

@end

NS_ASSUME_NONNULL_END
