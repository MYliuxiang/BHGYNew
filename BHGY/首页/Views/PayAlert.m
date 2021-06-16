//
//  PayAlert.m
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "PayAlert.h"

@implementation PayAlert

- (instancetype)init{
 
    self = [super init];
    if (self) {
        
        [self setupAutoHeightWithBottomView:self.czB bottomMargin:30];
        self.width = kScreenWidth;
        self.layer.cornerRadius = 7.5;
        self.layer.masksToBounds = YES;
        self.
        self.czB.layer.cornerRadius = 20;
        self.czB.layer.masksToBounds = YES;
        self.payB.layer.cornerRadius = 20;
        self.payB.layer.masksToBounds = YES;
//        self.offsetBotom =  - (Height_TabBar - 49);
        self.type = LxCustomAlertTypeSheet;
        
       
    }
    return self;
    
    
}
- (IBAction)czAC:(id)sender {
    if (self.clickBlock != nil) {
        self.clickBlock(1);
    }
    [self disMiss];
}
- (IBAction)payAC:(id)sender {
    if (self.clickBlock != nil) {
        self.clickBlock(2);
    }
    [self disMiss];
}
- (IBAction)seeAC:(id)sender {
    if (self.clickBlock != nil) {
        self.clickBlock(0);
    }
    [self disMiss];
}

@end
