//
//  MyImagesCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/25.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "MyImagesCell.h"

@implementation MyImagesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 7.5;
    self.layer.masksToBounds = YES;
}

@end
