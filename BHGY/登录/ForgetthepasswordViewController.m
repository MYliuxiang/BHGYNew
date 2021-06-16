//
//  ForgetthepasswordViewController.m
//  BHGY
//
//  Created by 李立 on 2020/7/5.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "ForgetthepasswordViewController.h"

@interface ForgetthepasswordViewController ()<UITextFieldDelegate>

@end

@implementation ForgetthepasswordViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFF2F4"];
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    [self setui];
}

//初始化ui
-(void)setui{
    //粉红色背景
     UIView *topbjview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
     topbjview.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
    topbjview.userInteractionEnabled = YES;
     [self.view addSubview:topbjview];
     
     //返回按钮
     UIButton *fanhuibutton = [UIButton buttonWithType:UIButtonTypeCustom];
     fanhuibutton.frame = CGRectMake(12.5, Height_StatusBar+9, 30, 30);
     [fanhuibutton setImage:[UIImage imageNamed:@"模态返回按钮"] forState:UIControlStateNormal];
     [fanhuibutton addTarget:self action:@selector(fanhuibuttonaciton) forControlEvents:UIControlEventTouchUpInside];
    fanhuibutton.userInteractionEnabled = YES;
     [topbjview addSubview:fanhuibutton];
     
     //登录label
     UILabel *loginlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, fanhuibutton.bottom+35, 180, 37.5)];
     loginlabel.textColor = [UIColor whiteColor];
     loginlabel.text = @"重置密码";
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
    
    
      //立即重置按钮
       UIButton *lijibutton = [UIButton buttonWithType:UIButtonTypeCustom];
       lijibutton.frame = CGRectMake(6.5, xtview2.bottom+10, baiseview.width-13, 45);
       KViewBorderRadius(lijibutton, 22.5, 0.5, [UIColor clearColor]);
       [lijibutton setTitle:@"立即重置" forState:UIControlStateNormal];
       [lijibutton addTarget:self action:@selector(lijibuttonbuttonaciton) forControlEvents:UIControlEventTouchUpInside];
       [lijibutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       lijibutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
       [baiseview addSubview:lijibutton];
}

-(void)fanhuibutton{
    
}

//立即重置
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
        //重置密码接口
        BADataEntity *entity = [BADataEntity new];
           entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_resetPassword];
           entity.needCache = NO;
    entity.parameters = @{@"mobile":_iphoneTextField.text,@"password":_passwordTextField.text,@"verifyCode":_codeTextField.text};
           [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
           [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
               NSDictionary *result = response;
               if ([result[@"code"] intValue] == 0) {
                [MBProgressHUD showSuccess:@"重置成功" toView:self.view];
                [self.navigationController popViewControllerAnimated:YES];
               }
               
           } failureBlock:^(NSError *error) {
           } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
               
           }];
    
    
}



//返回按钮
-(void)fanhuibuttonaciton{
   
    [self.navigationController popViewControllerAnimated:YES];

    
}

//发送验证码
-(void)codeaction{
    //验证手机号码是否合法
    
      if (_iphoneTextField.text.length!=11) {
          [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
            return;
        }
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
@end
