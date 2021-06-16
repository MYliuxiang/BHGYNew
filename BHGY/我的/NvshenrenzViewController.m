//
//  NvshenrenzViewController.m
//  BHGY
//
//  Created by 李立 on 2020/7/12.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "NvshenrenzViewController.h"

@interface NvshenrenzViewController ()

@end

@implementation NvshenrenzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.customNavBar.title = @"女神认证";
    [self setui];
}

//初始化视图
-(void)setui{
    
    //图片
    UIImageView *iconimageview  = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-90)/2, Height_NavBar+60, 90, 90)];
    iconimageview.backgroundColor = [UIColor grayColor];
    [self.view addSubview:iconimageview];
    
    //若你对自己
    UILabel *abxlabel = [[UILabel alloc]initWithFrame:CGRectMake(43.5, iconimageview.bottom+30,kScreenWidth-87, 45)];
    abxlabel.font = [UIFont systemFontOfSize:16];
    abxlabel.textColor = [UIColor colorWithHexString:@"#333333"];
    abxlabel.text =@"若你对自己的颜值很有自信，可进行女神 认证，获得特殊标识";
    abxlabel.textAlignment =NSTextAlignmentCenter;
    abxlabel.numberOfLines = 0;
    [self.view addSubview:abxlabel];
    
    //上传照片
    UILabel *shangchuanlabel = [[UILabel alloc]initWithFrame:CGRectMake(49.5, abxlabel.bottom+17,kScreenWidth-99, 45)];
       shangchuanlabel.font = [UIFont systemFontOfSize:12];
       shangchuanlabel.textColor = [UIColor colorWithHexString:@"#666666"];
       shangchuanlabel.text =@"请上传你的本人露脸照片或视频，百花公园会对你的资料进行审核，你会在12小时内收到审核结果";
       shangchuanlabel.textAlignment =NSTextAlignmentCenter;
       shangchuanlabel.numberOfLines = 0;
       [self.view addSubview:shangchuanlabel];
    
    //添加图片按钮
    UIImageView *addimageview = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-75)/2, shangchuanlabel.bottom+32, 75, 75)];
//    addimageview.backgroundColor = [UIColor grayColor];
    addimageview.image = [UIImage imageNamed:@"编组 4"];
    [self.view addSubview:addimageview];
    
    //提交按钮
    UIButton *tijiaobutton = [UIButton buttonWithType:UIButtonTypeCustom];
    tijiaobutton.frame = CGRectMake((kScreenWidth-345)/2, addimageview.bottom+32, 345, 45);
    tijiaobutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
    tijiaobutton.titleLabel.font = [UIFont systemFontOfSize:15];
    [tijiaobutton setTitle:@"提交" forState:UIControlStateNormal];
    KViewBorderRadius(tijiaobutton, 22.5, 0.5, [UIColor clearColor]);
    [self.view addSubview:tijiaobutton];
}

@end
