//
//  CertificationprocessViewController.m
//  BHGY
//
//  Created by 李立 on 2020/7/12.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "CertificationprocessViewController.h"
#import "AuthenNextViewController.h"
@interface CertificationprocessViewController ()

@end

@implementation CertificationprocessViewController

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
    xtview.backgroundColor = [UIColor colorWithHexString:@"#BFBFBF"];
    [self.view addSubview:xtview];
    
    //面容识别
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
       button2.frame = CGRectMake(xtview.right, Height_NavBar+15.5, 78.5, 33);
       KViewBorderRadius(button2, 19.5, 1, [UIColor colorWithHexString:@"#999999"]);
       [button2 setTitle:@"上传照片" forState:UIControlStateNormal];
       [button2 setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
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
    
    //你的照片
    UILabel *youphone = [[UILabel alloc]initWithFrame:CGRectMake(15, button3.bottom+35, 150, 20)];
    youphone.textColor = [UIColor colorWithHexString:@"#333333"];
    youphone.font = [UIFont systemFontOfSize:14];
    youphone.text = @"你的照片";
    [self.view addSubview:youphone];
    
    //说明
    UILabel *shuominglabel = [[UILabel alloc]initWithFrame:CGRectMake(15, youphone.bottom+8.5, 250, 60)];
    shuominglabel.textColor = [UIColor colorWithHexString:@"#999999"];
    shuominglabel.font = [UIFont systemFontOfSize:11];
    shuominglabel.text = @"1:请上传1张形象良好的正脸照片\n2:保证照片像素清晰，五官可见\n3:通过认证后，此照片将上传到你的相册";
    shuominglabel.numberOfLines = 0;
    [self.view addSubview:shuominglabel];
    
    
    //添加图片按钮
   UIImageView *addimageview = [[UIImageView alloc]initWithFrame:CGRectMake(15, shuominglabel.bottom+15, 75, 75)];
      addimageview.image = [UIImage imageNamed:@"编组 4"];
   [self.view addSubview:addimageview];
    
    
    //提交按钮
    UIButton *tijiaobutton = [UIButton buttonWithType:UIButtonTypeCustom];
    tijiaobutton.frame = CGRectMake((kScreenWidth-345)/2, addimageview.bottom+32, 345, 45);
    tijiaobutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
    tijiaobutton.titleLabel.font = [UIFont systemFontOfSize:15];
    [tijiaobutton setTitle:@"下一步" forState:UIControlStateNormal];
    [tijiaobutton addTarget:self action:@selector(tijiaobutton) forControlEvents:UIControlEventTouchUpInside];
    KViewBorderRadius(tijiaobutton, 22.5, 0.5, [UIColor clearColor]);
    [self.view addSubview:tijiaobutton];
    
}



//提交按钮
-(void)tijiaobutton{
    AuthenNextViewController *vc = [[AuthenNextViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
