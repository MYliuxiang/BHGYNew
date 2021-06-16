//
//  PrivateChatAlert.m
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "PrivateChatAlert.h"

@implementation PrivateChatAlert

- (instancetype)init{
 
    self = [super init];
    if (self) {
        
        [self setupAutoHeightWithBottomView:self.btn2 bottomMargin:15];
        self.width = kScreenWidth - 100;
        self.layer.cornerRadius = 7.5;
        self.layer.masksToBounds = YES;
        self.btn2.layer.cornerRadius = 20;
        self.btn2.layer.masksToBounds = YES;
        self.btn1.layer.cornerRadius = 20;
        self.btn1.layer.masksToBounds = YES;
        
        self.btn1.layer.borderColor = Color_9.CGColor;
        self.btn1.layer.borderWidth = 1;
    }
    return self;
    
    
}

- (IBAction)btn2AC:(id)sender {
    if (self.btnclickBlock != nil) {
        self.btnclickBlock(1);
    }
    [self disMiss];
}
- (IBAction)btnAC:(id)sender {
    if (self.btnclickBlock != nil) {
           self.btnclickBlock(0);
      
    }
    [self disMiss];

}
- (IBAction)closeAC:(id)sender {
    [self disMiss];
}

@end
