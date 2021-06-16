//
//  LogingViewController.m
//  BHGY
//
//  Created by 李立 on 2020/7/4.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "LogingViewController.h"
#import "SigninViewController.h"
#import "RegisterViewController.h"
#import "InvitationcodeVC.h"
@interface LogingViewController ()

@end

@implementation LogingViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //登录页背景
    UIImageView *bjimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bjimageview.image = [UIImage imageNamed:@"登录页背景"];
    [self.view addSubview:bjimageview];
    
    
    //log图标
    UIImageView *logimageview = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-90)/2, Height_StatusBar+87.5, 90, 90)];
    logimageview.image = [UIImage imageNamed:@"log图标"];
    [self.view addSubview:logimageview];
    
    //app名称
    UILabel *appnamelabel = [[UILabel alloc] init];
    appnamelabel.frame = CGRectMake(0,logimageview.bottom+22.5,kScreenWidth,28);
    appnamelabel.font = [UIFont systemFontOfSize:20];
    appnamelabel.textColor = [UIColor colorWithHexString:@"#000000"];
    appnamelabel.textAlignment = NSTextAlignmentCenter;
    appnamelabel.text = @"百花公园";
    [self.view addSubview:appnamelabel];

    //登录按钮
    UIButton *loginbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginbutton.frame = CGRectMake(23, appnamelabel.bottom+58.5, kScreenWidth-46, 45);
    KViewBorderRadius(loginbutton, 22.5, 0.5, [UIColor clearColor]);
    [loginbutton setTitle:@"登录" forState:UIControlStateNormal];
    [loginbutton addTarget:self action:@selector(loginbuttonaciton) forControlEvents:UIControlEventTouchUpInside];
    [loginbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginbutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
    [self.view addSubview:loginbutton];
    
    
    //注册按钮按钮
    UIButton *registerbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerbutton.frame = CGRectMake(23, loginbutton.bottom+21, kScreenWidth-46, 45);
    KViewBorderRadius(registerbutton, 22.5, 0.5, [UIColor clearColor]);
    [registerbutton setTitle:@"手机号注册" forState:UIControlStateNormal];
    [registerbutton addTarget:self action:@selector(registerbuttonaciton) forControlEvents:UIControlEventTouchUpInside];
    [registerbutton setTitleColor:[UIColor colorWithHexString:@"#FB78A3"] forState:UIControlStateNormal];
    registerbutton.backgroundColor = [UIColor colorWithHexString:@"#FFD9E6"];
    [self.view addSubview:registerbutton];

    
    //其他登录方式
    UILabel *othelabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-156)/2, registerbutton.bottom+54, 156, 18.5)];
    
    if (Height_StatusBar ==44) {
        loginbutton.frame = CGRectMake(23, appnamelabel.bottom+88.5, kScreenWidth-46, 45);
        registerbutton.frame = CGRectMake(23, loginbutton.bottom+21, kScreenWidth-46, 45);
        othelabel.frame = CGRectMake((kScreenWidth-156)/2, registerbutton.bottom+74, 156, 18.5);
    }
    othelabel.textColor = [UIColor colorWithHexString:@"#999999"];
    othelabel.font = [UIFont systemFontOfSize:13];
    othelabel.textAlignment = NSTextAlignmentCenter;
    othelabel.text = @"——    其他登录方式  ——";
    [self.view addSubview:othelabel];
    
    //微信登录
    UIButton *wechatbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    wechatbutton.frame = CGRectMake(othelabel.left-31.5, othelabel.bottom+25, 36, 36);
    [wechatbutton setImage:[UIImage imageNamed:@"微信登录"] forState:UIControlStateNormal];
    wechatbutton.tag = 50;
    [wechatbutton addTarget:self action:@selector(othebuttonaciton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wechatbutton];
    
    //qq登录
    UIButton *qqbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    qqbutton.frame = CGRectMake(wechatbutton.right+25, othelabel.bottom+25, 36, 36);
    [qqbutton setImage:[UIImage imageNamed:@"QQ登录"] forState:UIControlStateNormal];
    qqbutton.tag = 51;
    [qqbutton addTarget:self action:@selector(othebuttonaciton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqbutton];
    
    
    //苹果登录
    UIButton *applebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    applebutton.frame = CGRectMake(qqbutton.right+25, othelabel.bottom+30, 117, 26);
    [applebutton setImage:[UIImage imageNamed:@"苹果登录"] forState:UIControlStateNormal];
    applebutton.tag = 52;
    [applebutton addTarget:self action:@selector(othebuttonaciton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:applebutton];
}

//注册按钮点击事件
-(void)registerbuttonaciton{
     RegisterViewController *vc = [[RegisterViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
           nav.modalPresentationStyle = 0;
        [self presentViewController:nav animated:YES completion:nil];
    
}

//登录按钮点击事件
-(void)loginbuttonaciton{
    SigninViewController *vc = [[SigninViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
       nav.modalPresentationStyle = 0;
    [self presentViewController:nav animated:YES completion:nil];
    
}


//第三方登录按钮点击事件
-(void)othebuttonaciton:(UIButton *)button{
    if (button.tag ==50) {
        //微信登录
    }else if (button.tag == 51){
        //qq登录
    }else {
        //苹果登录
        InvitationcodeVC *vc = [[InvitationcodeVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
