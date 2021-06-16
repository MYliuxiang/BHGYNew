//
//  PhotoSetAlert.h
//  BHGY
//
//  Created by liuxiang on 2020/7/25.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "LxCustomAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoSetAlert : LxCustomAlert
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *cancleB;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property(nonatomic,strong) NSArray *contents;
@property(nonatomic,assign) NSInteger seletedIndex;


@property(nonatomic,copy) void(^clickBlcok)(NSInteger index);
- (instancetype)initWithContents:(NSArray *)contents withIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
