//
//  CommentOneCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "CommentOneCell.h"

@implementation CommentOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleL.layer.cornerRadius = 7.5;
    self.titleL.layer.masksToBounds = YES;
}

@end
