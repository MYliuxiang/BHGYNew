//
//  HomeMenum.h
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeMenum : NibView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;

@end

NS_ASSUME_NONNULL_END
