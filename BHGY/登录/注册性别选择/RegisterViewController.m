//
//  RegisterViewController.m
//  BHGY
//
//  Created by 李立 on 2020/7/5.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "RegisterViewController.h"
#import "GenderViewController.h"
@interface RegisterViewController ()<UITextFieldDelegate>

@end

@implementation RegisterViewController

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
     
//    fweefwf
    
    
     //返回按钮
     UIButton *fanhuibutton = [UIButton buttonWithType:UIButtonTypeCustom];
     fanhuibutton.frame = CGRectMake(12.5, Height_StatusBar+13.5, 30, 30);
     [fanhuibutton setImage:[UIImage imageNamed:@"模态返回按钮"] forState:UIControlStateNormal];
     [fanhuibutton addTarget:self action:@selector(fanhuibuttonaciton) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:fanhuibutton];
     
     //登录label
     UILabel *loginlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, fanhuibutton.bottom+35, 180, 37.5)];
     loginlabel.textColor = [UIColor whiteColor];
     loginlabel.text = @"注册";
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
     [baiseview addSubview:_iphoneTextField];
     
     //线条
     UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(21, _iphoneTextField.bottom+5, _iphoneTextField.width, 0.5)];
     xtview.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
     [baiseview addSubview:xtview];
     
     //验证码
     _codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, xtview.bottom+25.5, baiseview.width-140, 20)];
    _codeTextField.font = [UIFont systemFontOfSize:14];
    _codeTextField.placeholder = @"请输入验证码";
    _codeTextField.delegate = self;
    _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [baiseview addSubview:_codeTextField];
     
    //获取验证码
     _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
     _codeButton.frame = CGRectMake(_codeTextField.right+3, _codeTextField.top, 100, 16.5);
     _codeButton.titleLabel.font = [UIFont systemFontOfSize:12];
     _codeButton.titleLabel.textAlignment = NSTextAlignmentLeft;
     [_codeButton setTitleColor:[UIColor colorWithHexString:@"#FB78A3"] forState:UIControlStateNormal];
     [_codeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
     [_codeButton addTarget:self action:@selector(codeaction) forControlEvents:UIControlEventTouchUpInside];
     [baiseview addSubview:_codeButton];
    
    //线条1
    UIView *xtview1 = [[UIView alloc]initWithFrame:CGRectMake(21, _codeTextField.bottom+5, _iphoneTextField.width, 0.5)];
    xtview1.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    [baiseview addSubview:xtview1];
    
    
   
    
    //密码
     _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, xtview1.bottom+25.5, baiseview.width-50, 20)];
    _passwordTextField.font = [UIFont systemFontOfSize:14];
    _passwordTextField.placeholder = @"请设置密码";
    _passwordTextField.delegate = self;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [baiseview addSubview:_passwordTextField];
    
    //线条1
    UIView *xtview2 = [[UIView alloc]initWithFrame:CGRectMake(21, _passwordTextField.bottom+5, _passwordTextField.width, 0.5)];
    xtview2.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    [baiseview addSubview:xtview2];
    
    
      //下一步按钮
       UIButton *lijibutton = [UIButton buttonWithType:UIButtonTypeCustom];
       lijibutton.frame = CGRectMake(6.5, xtview2.bottom+10, baiseview.width-13, 45);
       KViewBorderRadius(lijibutton, 22.5, 0.5, [UIColor clearColor]);
       [lijibutton setTitle:@"下一步" forState:UIControlStateNormal];
       [lijibutton addTarget:self action:@selector(lijibuttonbuttonaciton) forControlEvents:UIControlEventTouchUpInside];
       [lijibutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       lijibutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
       [baiseview addSubview:lijibutton];
    
       //协议
    UILabel *xieyilabel = [[UILabel alloc]initWithFrame:CGRectMake(lijibutton.left+64, lijibutton.bottom+9, 145, 14)];
    xieyilabel.textAlignment = NSTextAlignmentCenter;
    xieyilabel.font = [UIFont systemFontOfSize:10];
    xieyilabel.textColor = [UIColor colorWithHexString:@"#999999"];
    xieyilabel.text = @"点击进入表示你已经阅读并同意";
    [baiseview addSubview:xieyilabel];
    
    //用户协议点击
    UIButton *xiyibutton = [UIButton buttonWithType:UIButtonTypeCustom];
    xiyibutton.frame = CGRectMake(xieyilabel.right-10, xieyilabel.top, 100, 14);
    [xiyibutton setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [xiyibutton setTitleColor:[UIColor colorWithHexString:@"#359EFF"] forState:UIControlStateNormal];
    xiyibutton.titleLabel.font = [UIFont systemFontOfSize:12];
    [xiyibutton addTarget:self action:@selector(xiyibuttonaciton) forControlEvents:UIControlEventTouchUpInside];
    [baiseview addSubview:xiyibutton];
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


//下一步
-(void)lijibuttonbuttonaciton{
    
    if (_iphoneTextField.text.length ==0) {
        [MBProgressHUD showError:@"请输入手机号/账号" toView:self.view];
        return;
    }
    if (_codeTextField.text.length ==0) {
        [MBProgressHUD showError:@"请输入验证码" toView:self.view];
        return;
    }
    
    if (_passwordTextField.text.length ==0) {
        [MBProgressHUD showError:@"请设置密码" toView:self.view];
        return;
    }
    
    if (_iphoneTextField.text.length !=11) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return;
    }
    
//    if (_codeTextField.text.length!=6) {
//        [MBProgressHUD showError:@"请输入6位验证码" toView:self.view];
//        return;
//    }
    //注册接口
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_register];
    entity.needCache = NO;
    entity.parameters = @{@"mobile":_iphoneTextField.text,@"password":_passwordTextField.text,@"verifyCode":_codeTextField.text};
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        
               NSDictionary *result = response;
               if ([result[@"code"] intValue] == 0) {
                   LoginModel *model = [LoginModel mj_objectWithKeyValues:result[@"data"]];
                   //设置网络请求头
                   NSString *user_token = [NSString stringWithFormat:@"%@",model.token];
                   NSDictionary *headerdic = @{@"user_token":user_token};
                   [BANetManager sharedBANetManager].httpHeaderFieldDictionary = headerdic;
                   GenderViewController *vc = [[GenderViewController alloc]init];
                   [self.navigationController pushViewController:vc animated:YES];

                   return;
                   
               }

        
    } failureBlock:^(NSError *error) {
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];

      
    
    
}



//返回按钮
-(void)fanhuibuttonaciton{
   
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

    
}

//发送验证码
-(void)codeaction{
    //验证手机号码是否合法
      
     if (_iphoneTextField.text.length!=11) {
         [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
           return;
       }
   
    
    //判断手机号是否注册
    [self panduaniphone];
    
}



//判断手机号是否注册
-(void)panduaniphone {
    
   
 //发送验证码接口
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_checkMobile];
    entity.needCache = NO;
    entity.parameters = @{@"mobile":_iphoneTextField.text};
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
//            BOOL ischeckmobile = [result [@"data"]  boolValue];
            if (![result [@"data"]  boolValue]) {
                [self getviecode];
            }else{
                [MBProgressHUD showMessag:@"手机号已注册" toView:self.view];
            }
            
        }
        
    } failureBlock:^(NSError *error) {
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}


//发送验证码
-(void)getviecode{
    
          //发送验证码接口
             BADataEntity *entity = [BADataEntity new];
             entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_getVerifyCode];
             entity.needCache = NO;
             entity.parameters = @{@"mobile":_iphoneTextField.text};
             [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
             [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
                 NSDictionary *result = response;
                 if ([result[@"code"] intValue] == 0) {
                  //倒计时
                  [self huoqu];
                     
                 }
                 
             } failureBlock:^(NSError *error) {
                 
                 
             } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                 
             }];
    
}
//倒计时
-(void)huoqu
{
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self->_codeButton setTitle:@"重新发送" forState:UIControlStateNormal];
                self->_codeButton.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self->_codeButton setTitle:[NSString stringWithFormat:@"重新发送（%.2d）", seconds] forState:UIControlStateNormal];
                self->_codeButton.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
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

//协议按钮点击
-(void)xiyibuttonaciton{
//   WYWebController *webVC = [WYWebController new];
//   webVC.url = @"https://www.baidu.com";
//   [self.navigationController pushViewController:webVC animated:YES];
    
}
@end
