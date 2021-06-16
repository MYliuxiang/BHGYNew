//
//  CommentCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.countL.layer.cornerRadius = 7.5;
    self.countL.layer.masksToBounds = YES;
}

@end
