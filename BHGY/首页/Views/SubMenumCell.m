//
//  SubMenumCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "SubMenumCell.h"

@implementation SubMenumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected) {
           self.titleLab.textColor = Color_Theme;

       }else{
           self.titleLab.textColor = Color_3;

       }
}

@end
