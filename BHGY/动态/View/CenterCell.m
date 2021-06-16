//
//  CenterCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/23.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "CenterCell.h"

@implementation CenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if(selected){
        self.centerL.textColor = Color_Theme;
    }else{
        self.centerL.textColor = Color_3;
    }
}

@end
