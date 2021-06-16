//
//  MyBlackCell.h
//  BHGY
//
//  Created by liuxiang on 2020/7/21.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyBlackCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (nonatomic,strong) UserModel *model;
@end

NS_ASSUME_NONNULL_END
