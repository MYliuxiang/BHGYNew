//
//  SeeRedVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/12.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "SeeRedVC.h"

@interface SeeRedVC ()
@property (weak, nonatomic) IBOutlet UIButton *doneB;

@end

@implementation SeeRedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.doneB.layer.cornerRadius = 20;
    self.doneB.layer.masksToBounds = YES;
    self.customNavBar.title = @"维拉贝尔";
    self.bottomView.backgroundColor = [UIColor clearColor];
    
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"编组 5"]];
       
       __weak typeof(self) weakSelf = self;
       self.customNavBar.onClickRightButton = ^{
           
          
           
       };
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
