//
//  SigninViewController.m
//  BHGY
//
//  Created by 李立 on 2020/7/4.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "SigninViewController.h"
#import "ForgetthepasswordViewController.h"
#import "PerfectVC.h"
#import "GenderViewController.h"
@interface SigninViewController ()<UITextFieldDelegate>

@end

@implementation SigninViewController
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
    UILabel *loginlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, fanhuibutton.bottom+35, 80, 37.5)];
    loginlabel.textColor = [UIColor whiteColor];
    loginlabel.text = @"登录";
    loginlabel.font = [UIFont boldSystemFontOfSize:27];
    [self.view addSubview:loginlabel];
    
    //白色视图
    UIView *baiseview = [[UIView alloc] init];
    baiseview.frame = CGRectMake(15,loginlabel.bottom+26,kScreenWidth-30,260);
    baiseview.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    baiseview.layer.cornerRadius = 7.5;
    [self.view addSubview:baiseview];
    
    //电话号码输入框
    _iphoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, 39, baiseview.width-50, 20)];
    _iphoneTextField.font = [UIFont systemFontOfSize:14];
    _iphoneTextField.placeholder = @"请输入手机号/账号";
    _iphoneTextField.delegate = self;
    _iphoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    //    _iphoneTextField.clearButtonMode = UITextFieldViewModeAlways;
    _iphoneTextField.text = @"18665923312";
    [baiseview addSubview:_iphoneTextField];
    
    //线条
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(21, _iphoneTextField.bottom+5, _iphoneTextField.width, 0.5)];
    xtview.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    [baiseview addSubview:xtview];
    
    //密码
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, xtview.bottom+25.5, baiseview.width-50, 20)];
    _passwordTextField.font = [UIFont systemFontOfSize:14];
    _passwordTextField.placeholder = @"请输入密码";
    _passwordTextField.delegate = self;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.keyboardType = UIKeyboardTypeEmailAddress;
    _passwordTextField.text = @"123456";
    
    [baiseview addSubview:_passwordTextField];
    
    //线条1
    UIView *xtview1 = [[UIView alloc]initWithFrame:CGRectMake(21, _passwordTextField.bottom+5, _passwordTextField.width, 0.5)];
    xtview1.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    [baiseview addSubview:xtview1];
    
    //登录按钮
    UIButton *loginbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginbutton.frame = CGRectMake(6.5, xtview1.bottom+10, baiseview.width-13, 45);
    KViewBorderRadius(loginbutton, 22.5, 0.5, [UIColor clearColor]);
    [loginbutton setTitle:@"登录" forState:UIControlStateNormal];
    [loginbutton addTarget:self action:@selector(loginbuttonaciton) forControlEvents:UIControlEventTouchUpInside];
    [loginbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginbutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
    [baiseview addSubview:loginbutton];
    
    //忘记密码
    UIButton *forgetbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetbutton setTitleColor:[UIColor colorWithHexString:@"#FB78A3"] forState:UIControlStateNormal];
    forgetbutton.frame = CGRectMake(21, loginbutton.bottom+20, 80, 20);
    [forgetbutton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    forgetbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [forgetbutton addTarget:self action:@selector(forgetbutton) forControlEvents:UIControlEventTouchUpInside];
    [baiseview addSubview:forgetbutton];
    
    //其他登录方式
    UILabel *othelabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-156)/2, baiseview.bottom+64, 156, 18.5)];
    if (Height_StatusBar ==44) {
        othelabel.frame = CGRectMake((kScreenWidth-156)/2, baiseview.bottom+84, 156, 18.5);
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

//返回按钮
-(void)fanhuibuttonaciton{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


//第三方登录按钮点击事件
-(void)othebuttonaciton:(UIButton *)button{
    if (button.tag ==50) {
        //微信登录
    }else if (button.tag == 51){
        //qq登录
    }else {
        //苹果登录
    }
}


//登录按钮点击事件
-(void)loginbuttonaciton{
    
    
    if (self.iphoneTextField.text.length ==0) {
        [MBProgressHUD showError:@"请输入手机号/账号" toView:self.view];
        return;
    }
    
    if (self.iphoneTextField.text.length !=11 || ![AppService validateContactNumber:self.iphoneTextField.text]) {
        [MBProgressHUD showError:@"请输入正确的手机号码" toView:self.view];
        return;
    }
    
    if (self.passwordTextField.text.length ==0) {
        [MBProgressHUD showError:@"请输入密码" toView:self.view];
        return;
    }
    
    //调用注册接口
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_login];
    entity.needCache = NO;
    entity.parameters = @{@"mobile":_iphoneTextField.text,@"password":_passwordTextField.text};
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            LoginModel *model = [LoginModel mj_objectWithKeyValues:result[@"data"]];
            //设置网络请求头
            NSString *user_token = [NSString stringWithFormat:@"%@",model.token];
            NSDictionary *headerdic = @{@"user_token":user_token};
            [BANetManager sharedBANetManager].httpHeaderFieldDictionary = headerdic;
            
            NSString *status = [NSString stringWithFormat:@"%@",result[@"data"][@"status"]];
            NSString *sex = [NSString stringWithFormat:@"%@",result[@"data"][@"sex"]];
            
            if ([sex intValue] ==-1) {
                //没有设置性别
                GenderViewController *vc = [[GenderViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
            
            if ([status isEqualToString:@"0"]) {
                //没完善信息
                PerfectVC *vc = [[PerfectVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                /*
                 a2kiSLdWoO+GAgbpyp19V/OJmbsnGD8m4Sj9Itp0/XN/rC9g56Fc9V033jjgBuA5@82ap.cn.rongnav.com;82ap.cn.rongcfg.com
                 a2kiSLdWoO+GAgbpyp19V/OJmbsnGD8m4Sj9Itp0/XN/rC9g56Fc9V033jjgBuA5@82ap.cn.rongnav.com;82ap.cn.rongcfg.com
                 a2kiSLdWoO+GAgbpyp19V/OJmbsnGD8m4Sj9Itp0/XN/rC9g56Fc9V033jjgBuA5@82ap.cn.rongnav.com;82ap.cn.rongcfg.com
                 */
                
                [[RCIM sharedRCIM] connectWithToken:model.rongCloudTOken
                                           dbOpened:^(RCDBErrorCode code) {
                    //消息数据库打开，可以进入到主页面
                    [LoginManger sharedManager].currentLoginModel = model;

                    dispatch_async(dispatch_get_main_queue(), ^{
                           [HandleTool switchMainVC];
                       });
                    
                }
                                            success:^(NSString *userId) {
                    //连接成功
                }
                                              error:^(RCConnectErrorCode status) {
                    if (status == RC_CONN_TOKEN_INCORRECT) {
                        //从 APP 服务获取新 token，并重连
                    } else {
                        //无法连接到 IM 服务器，请根据相应的错误码作出对应处理
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD showError:@"系统错误" toView:lxWindow];
                                          });
                    
                }];
                
                
                
            }
            
            
            return;
            }
            
        }
        
    } failureBlock:^(NSError *error) {
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}



//忘记密码按钮点击
-(void)forgetbutton{
    ForgetthepasswordViewController *vc = [[ForgetthepasswordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


//textfield代理方法
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //   NSLog(@"已经结束编辑时执行的方法%@", textField.text);
    if (textField == self.iphoneTextField) {
        if (textField.text.length ==0) {
            [MBProgressHUD showError:@"请输入手机号/账号" toView:self.view];
            
        }else if (textField.text.length !=11){
            [MBProgressHUD showError:@"请输入正确的手机号码" toView:self.view];
        }
    }
    
    
}
@end
