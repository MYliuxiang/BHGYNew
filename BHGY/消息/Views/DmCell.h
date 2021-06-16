//
//  DmCell.h
//  BHGY
//
//  Created by liuxiang on 2020/7/8.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DmCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIImageView *contentI;
@property (strong,nonatomic) DmModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *iconI;

@end

NS_ASSUME_NONNULL_END
