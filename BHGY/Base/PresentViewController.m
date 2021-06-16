//
//  PresentViewController.m
//  BHGY
//
//  Created by 李立 on 2020/7/4.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "PresentViewController.h"

@interface PresentViewController ()

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setui];
}

-(void)setui {
    UIButton *fanhuibutton = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhuibutton.frame = CGRectMake(12.5, 25, 40, 40);
    [fanhuibutton setImage:[UIImage imageNamed:@"模态返回"] forState:UIControlStateNormal];
    [fanhuibutton addTarget:self action:@selector(fanhuibuttonaciton) forControlEvents:UIControlEventTouchUpInside];
    fanhuibutton.backgroundColor = [UIColor grayColor];
    [self.view addSubview:fanhuibutton];
    
    
}


//返回按钮点击事件
-(void)fanhuibuttonaciton{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
@end
