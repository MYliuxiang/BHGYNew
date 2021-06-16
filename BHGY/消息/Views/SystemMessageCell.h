//
//  SystemMessageCell.h
//  BHGY
//
//  Created by liuxiang on 2020/7/8.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SystemMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imG;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *countL;


@end

NS_ASSUME_NONNULL_END
