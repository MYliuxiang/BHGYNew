//
//  ReportCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/8.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "ReportCell.h"

@implementation ReportCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected) {
        self.stateI.image = [UIImage imageNamed:@"gouxuan"];

    }else{
        self.stateI.image = [UIImage imageNamed:@"椭圆形33"];

    }
}

@end
