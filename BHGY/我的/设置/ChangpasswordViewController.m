//
//  ChangpasswordViewController.m
//  BHGY
//
//  Created by 李立 on 2020/7/11.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "ChangpasswordViewController.h"

@interface ChangpasswordViewController ()<UITextFieldDelegate>

@end

@implementation ChangpasswordViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFF2F4"];
    [self setui];
}

//初始化ui
-(void)setui{
    //粉红色背景
     UIView *topbjview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
     topbjview.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
     [self.view addSubview:topbjview];
     
     //返回按钮
     UIButton *fanhuibutton = [UIButton buttonWithType:UIButtonTypeCustom];
     fanhuibutton.frame = CGRectMake(12.5, Height_StatusBar+13.5, 30, 30);
     [fanhuibutton setImage:[UIImage imageNamed:@"模态返回按钮"] forState:UIControlStateNormal];
     [fanhuibutton addTarget:self action:@selector(fanhuibuttonaciton) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:fanhuibutton];
     
     //登录label
     UILabel *loginlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, fanhuibutton.bottom+35, 180, 37.5)];
     loginlabel.textColor = [UIColor whiteColor];
     loginlabel.text = @"修改密码";
     loginlabel.font = [UIFont boldSystemFontOfSize:27];
     [self.view addSubview:loginlabel];
    
    //说明
    UILabel *shuominglabel =[[UILabel alloc]initWithFrame:CGRectMake(15, loginlabel.bottom+3, 200, 15)];
    shuominglabel.textColor = [UIColor whiteColor];
    shuominglabel.text = @"用户需先绑定手机号才可设置登录密码";
    shuominglabel.font = [UIFont boldSystemFontOfSize:11];
    [self.view addSubview:shuominglabel];
    
     //白色视图
     UIView *baiseview = [[UIView alloc] init];
     baiseview.frame = CGRectMake(15,loginlabel.bottom+26,kScreenWidth-30,260);
     baiseview.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
     baiseview.layer.cornerRadius = 7.5;
     [self.view addSubview:baiseview];
     
     //电话号码输入框
     _oldpasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, 39, baiseview.width-50, 20)];
     _oldpasswordTextField.font = [UIFont systemFontOfSize:14];
     _oldpasswordTextField.placeholder = @"原密码";
     _oldpasswordTextField.delegate = self;
     _oldpasswordTextField.keyboardType = UIKeyboardTypeASCIICapable;
     //    _iphoneTextField.clearButtonMode = UITextFieldViewModeAlways;
     [baiseview addSubview:_oldpasswordTextField];
     
     //线条
     UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(21, _oldpasswordTextField.bottom+5, _oldpasswordTextField.width, 0.5)];
     xtview.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
     [baiseview addSubview:xtview];
     
     //验证码
     _newpasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, xtview.bottom+25.5, _oldpasswordTextField.width, 20)];
    _newpasswordTextField.font = [UIFont systemFontOfSize:14];
    _newpasswordTextField.placeholder = @"设置新密码，不少于6位";
    _newpasswordTextField.delegate = self;
    _newpasswordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [baiseview addSubview:_newpasswordTextField];
     
    //线条1
    UIView *xtview1 = [[UIView alloc]initWithFrame:CGRectMake(21, _newpasswordTextField.bottom+5, xtview.width, 0.5)];
    xtview1.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    [baiseview addSubview:xtview1];
    
    
      //保存按钮
       UIButton *lijibutton = [UIButton buttonWithType:UIButtonTypeCustom];
       lijibutton.frame = CGRectMake(6.5, xtview1.bottom+10, baiseview.width-13, 45);
       KViewBorderRadius(lijibutton, 22.5, 0.5, [UIColor clearColor]);
       [lijibutton setTitle:@"保存" forState:UIControlStateNormal];
       [lijibutton addTarget:self action:@selector(lijibuttonbuttonaciton) forControlEvents:UIControlEventTouchUpInside];
       [lijibutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       lijibutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
       [baiseview addSubview:lijibutton];
}


//保存
-(void)lijibuttonbuttonaciton{
    
    if (_oldpasswordTextField.text.length ==0) {
        [MBProgressHUD showError:@"请输入旧密码" toView:self.view];
        return;
    }
    if (_newpasswordTextField.text.length ==0) {
        [MBProgressHUD showError:@"请输入新密码" toView:self.view];
        return;
    }
    if (_newpasswordTextField.text.length <6) {
           [MBProgressHUD showError:@"新密码不得少于6位字符" toView:self.view];
           return;
    }
    
    
    
}



//返回按钮
-(void)fanhuibuttonaciton{
   
    [self.navigationController popViewControllerAnimated:YES];

    
}


@end
