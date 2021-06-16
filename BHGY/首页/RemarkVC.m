//
//  RemarkVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "RemarkVC.h"

@interface RemarkVC ()
@property (weak, nonatomic) IBOutlet TXLimitedTextField *remarkF;
@property (weak, nonatomic) IBOutlet UITextView *contentT;

@end

@implementation RemarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"备注";
    [self.customNavBar wr_setRightButtonWithTitle:@"完成" titleColor:[UIColor whiteColor]];
    self.bottomView.backgroundColor = Color_bg;
    
    self.customNavBar.onClickRightButton = ^{
        //完成
    };
}

- (void)creatNav{
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
