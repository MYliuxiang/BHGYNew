//
//  ExpectationAlert.h
//  BHGY
//
//  Created by liuxiang on 2020/7/23.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "LxCustomAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExpectationAlert : LxCustomAlert<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *cancleB;
@property(nonatomic,strong) NSArray *contents;
@property(nonatomic,strong) UIColor *btnColor;
@property(nonatomic,strong) NSArray *seletes;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;


@property(nonatomic,copy) void(^clickBlcok)(NSString *expectation);

- (instancetype)initWithContents:(NSArray *)contents seletes:(NSArray *)seletes;

@end

NS_ASSUME_NONNULL_END
