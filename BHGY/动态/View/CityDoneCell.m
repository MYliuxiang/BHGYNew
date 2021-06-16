//
//  CityDoneCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/20.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "CityDoneCell.h"

@implementation CityDoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 11;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = Color_Theme.CGColor;
    self.layer.borderWidth = 1;
}

@end
