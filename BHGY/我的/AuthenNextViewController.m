//
//  AuthenNextViewController.m
//  BHGY
//
//  Created by 李立 on 2020/7/13.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "AuthenNextViewController.h"
#import "DoneauthenViewController.h"
@interface AuthenNextViewController ()

@end

@implementation AuthenNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"真人认证";
      [self setui];
}

//初始化ui
-(void)setui{
    
    //上传照片
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(16.5, Height_NavBar+15.5, 78.5, 33);
    KViewBorderRadius(button1, 19.5, 1, [UIColor colorWithHexString:@"#FB78A3"]);
    [button1 setTitle:@"上传照片" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor colorWithHexString:@"#FB78A3"] forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:button1];
    
    //线条
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(button1.right, button1.top+16, 46, 1)];
    xtview.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
    [self.view addSubview:xtview];
    
    //面容识别
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
       button2.frame = CGRectMake(xtview.right, Height_NavBar+15.5, 78.5, 33);
       KViewBorderRadius(button2, 19.5, 1, [UIColor colorWithHexString:@"#FB78A3"]);
       [button2 setTitle:@"上传照片" forState:UIControlStateNormal];
       [button2 setTitleColor:[UIColor colorWithHexString:@"#FB78A3"] forState:UIControlStateNormal];
        button2.titleLabel.font = [UIFont systemFontOfSize:14];

       [self.view addSubview:button2];
    
    //线条
   UIView *xtview1 = [[UIView alloc]initWithFrame:CGRectMake(button2.right, button2.top+16, 46, 1)];
   xtview1.backgroundColor = [UIColor colorWithHexString:@"#BFBFBF"];
   [self.view addSubview:xtview1];
    
     //面容识别
      UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
     button3.frame = CGRectMake(xtview1.right, Height_NavBar+15.5, 78.5, 33);
     KViewBorderRadius(button3, 19.5, 1, [UIColor colorWithHexString:@"#999999"]);
     [button3 setTitle:@"面容识别" forState:UIControlStateNormal];
     [button3 setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
     button3.titleLabel.font = [UIFont systemFontOfSize:14];
     [self.view addSubview:button3];
    
    //面容认证图标
    UIImageView *iconimageview = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-82)/2, button1.bottom+41.5, 82, 82)];
    iconimageview.image = [UIImage imageNamed:@"真人认证图标"];
    [self.view addSubview:iconimageview];
    
    //面容识别
    UILabel *mianronglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, iconimageview.bottom+19, kScreenWidth, 22.5)];
    mianronglabel.font = [UIFont systemFontOfSize:16];
    mianronglabel.textColor = [UIColor colorWithHexString:@"#333333"];
    mianronglabel.text = @"面容识别";
    mianronglabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:mianronglabel];
    
    //说明
    UILabel *abexronglabel = [[UILabel alloc]initWithFrame:CGRectMake(39, mianronglabel.bottom+19, kScreenWidth-78, 50)];
      abexronglabel.font = [UIFont systemFontOfSize:11];
      abexronglabel.textColor = [UIColor colorWithHexString:@"#999999"];
      abexronglabel.text = @"将通过面容识别到你的照片是否为被人，请在光线充足的位置进行认证。";
      abexronglabel.textAlignment = NSTextAlignmentCenter;
      [self.view addSubview:abexronglabel];
    
    
      //提交按钮
       UIButton *tijiaobutton = [UIButton buttonWithType:UIButtonTypeCustom];
       tijiaobutton.frame = CGRectMake((kScreenWidth-345)/2, abexronglabel.bottom+40, 345, 45);
       tijiaobutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
       tijiaobutton.titleLabel.font = [UIFont systemFontOfSize:15];
       [tijiaobutton setTitle:@"开始识别" forState:UIControlStateNormal];
       [tijiaobutton addTarget:self action:@selector(tijiaobutton) forControlEvents:UIControlEventTouchUpInside];
       KViewBorderRadius(tijiaobutton, 22.5, 0.5, [UIColor clearColor]);
       [self.view addSubview:tijiaobutton];
    
}

//开始识别
-(void)tijiaobutton{
    DoneauthenViewController *vc = [[DoneauthenViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
