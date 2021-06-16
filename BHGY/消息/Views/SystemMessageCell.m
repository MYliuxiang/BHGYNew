//
//  SystemMessageCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/8.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "SystemMessageCell.h"

@implementation SystemMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.countL.text = @"1";
    self.countL.layer.cornerRadius = 8;
    self.countL.layer.masksToBounds = YES;
   
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.countL sizeToFit];
    CGFloat width;
    if (self.countL.width + 8 < 16) {
        width = 16;
    }else{
        width = self.countL.width + 8;
    }
    self.countL.frame = CGRectMake(60 - width / 2, 11, width, 16);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
