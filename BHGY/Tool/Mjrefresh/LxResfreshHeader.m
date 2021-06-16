//
//  LxResfreshHeader.m
//  XiangYin
//
//  Created by liuxiang on 2018/12/20.
//  Copyright © 2018年 liuxiang. All rights reserved.
//

#import "LxResfreshHeader.h"

@implementation LxResfreshHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)prepare
{
    [super prepare];
    self.stateLabel.textColor = [MyColor colorWithHexString:@"#858296"];
    self.lastUpdatedTimeLabel.hidden = YES;
}




@end
