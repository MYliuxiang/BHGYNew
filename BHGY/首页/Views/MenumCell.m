//
//  MenumCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/6.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "MenumCell.h"

@implementation MenumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected) {
        self.titleLab.textColor = [UIColor whiteColor];

    }else{
        self.titleLab.textColor = Color_3;

    }
}

@end
