//
//  ApplicationcodeVC.m
//  BHGY
//
//  Created by 李立 on 2020/7/26.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "ApplicationcodeVC.h"

@interface ApplicationcodeVC ()<UITextFieldDelegate>

@end

@implementation ApplicationcodeVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setui];
}

//初始化ui
-(void)setui{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFF2F4"];
    //粉红色背景
     UIView *topbjview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
     topbjview.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
    topbjview.userInteractionEnabled = YES;
     [self.view addSubview:topbjview];
     
     //返回按钮
     UIButton *fanhuibutton = [UIButton buttonWithType:UIButtonTypeCustom];
     fanhuibutton.frame = CGRectMake(12.5, Height_StatusBar+29, 30, 30);
     [fanhuibutton setImage:[UIImage imageNamed:@"模态返回按钮"] forState:UIControlStateNormal];
     [fanhuibutton addTarget:self action:@selector(fanhuibuttonaciton) forControlEvents:UIControlEventTouchUpInside];
    fanhuibutton.userInteractionEnabled = YES;
     [topbjview addSubview:fanhuibutton];
     
     //登录label
     UILabel *loginlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, fanhuibutton.bottom+35, 180, 37.5)];
     loginlabel.textColor = [UIColor whiteColor];
     loginlabel.text = @"申请邀请码";
     loginlabel.font = [UIFont boldSystemFontOfSize:27];
     [self.view addSubview:loginlabel];
     
     //白色视图
     UIView *baiseview = [[UIView alloc] init];
     baiseview.frame = CGRectMake(15,loginlabel.bottom+26,kScreenWidth-30,300);
     baiseview.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
     baiseview.layer.cornerRadius = 7.5;
     [self.view addSubview:baiseview];
     
     //电话号码输入框
     _iphoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, 39, baiseview.width-50, 20)];
     _iphoneTextField.font = [UIFont systemFontOfSize:14];
     _iphoneTextField.placeholder = @"请输入所在地";
     _iphoneTextField.delegate = self;
//     _iphoneTextField.keyboardType = UIKeyboardTypeNumberPad;
     //    _iphoneTextField.clearButtonMode = UITextFieldViewModeAlways;
     [baiseview addSubview:_iphoneTextField];
     
     //线条
     UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(21, _iphoneTextField.bottom+5, _iphoneTextField.width, 0.5)];
     xtview.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
     [baiseview addSubview:xtview];
     
     //验证码
     _codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, xtview.bottom+25.5, baiseview.width-40, 20)];
    _codeTextField.font = [UIFont systemFontOfSize:14];
    _codeTextField.placeholder = @"请输入信息渠道";
    _codeTextField.delegate = self;
//    _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [baiseview addSubview:_codeTextField];
     
    
    //线条1
    UIView *xtview1 = [[UIView alloc]initWithFrame:CGRectMake(21, _codeTextField.bottom+5, _iphoneTextField.width, 0.5)];
    xtview1.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    [baiseview addSubview:xtview1];
    
    
   
    
    //密码
     _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, xtview1.bottom+25.5, baiseview.width-50, 20)];
    _passwordTextField.font = [UIFont systemFontOfSize:14];
    _passwordTextField.placeholder = @"微信号";
    _passwordTextField.delegate = self;
//    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [baiseview addSubview:_passwordTextField];
    
    //线条1
    UIView *xtview2 = [[UIView alloc]initWithFrame:CGRectMake(21, _passwordTextField.bottom+5, _passwordTextField.width, 0.5)];
    xtview2.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    [baiseview addSubview:xtview2];
    
    //推荐人
        _tuijianrTextField= [[UITextField alloc]initWithFrame:CGRectMake(25, xtview2.bottom+25.5, baiseview.width-50, 20)];
       _tuijianrTextField.font = [UIFont systemFontOfSize:14];
       _tuijianrTextField.placeholder = @"推荐人（非必填）";
       _tuijianrTextField.delegate = self;
//       _tuijianrTextField.secureTextEntry = YES;
//       _tuijianrTextField.keyboardType = UIKeyboardTypeASCIICapable;
       [baiseview addSubview:_tuijianrTextField];
       
       //线条1
       UIView *xtview3 = [[UIView alloc]initWithFrame:CGRectMake(21, _tuijianrTextField.bottom+5, _tuijianrTextField.width, 0.5)];
       xtview3.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
       [baiseview addSubview:xtview3];
    
    
    
      //立即重置按钮
       UIButton *lijibutton = [UIButton buttonWithType:UIButtonTypeCustom];
       lijibutton.frame = CGRectMake(6.5, xtview3.bottom+10, baiseview.width-13, 45);
       KViewBorderRadius(lijibutton, 22.5, 0.5, [UIColor clearColor]);
       [lijibutton setTitle:@"提交申请" forState:UIControlStateNormal];
       [lijibutton addTarget:self action:@selector(lijibuttonbuttonaciton) forControlEvents:UIControlEventTouchUpInside];
       [lijibutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       lijibutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
       [baiseview addSubview:lijibutton];
}




//返回按钮
-(void)fanhuibuttonaciton{
    [self.navigationController popViewControllerAnimated:YES];
    
}


//提交申请
-(void)lijibuttonbuttonaciton{
    
    
    if (_iphoneTextField.text.length ==0 || _codeTextField.text.length ==0 || _passwordTextField.text.length ==0) {
        [MBProgressHUD showError:@"请完善申请信息" toView:self.view];
        return;
    }

         //查看邀请码
           BADataEntity *entity = [BADataEntity new];
           entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_applyInviteCode];
           entity.needCache = NO;
    entity.parameters = @{@"channel":_codeTextField.text,@"invite":_tuijianrTextField.text,@"location":_iphoneTextField.text,@"wechat":_passwordTextField.text};
           [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
           [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
               NSDictionary *result = response;
               if ([result[@"code"] intValue] == 0) {

                       //申请成功
                       [self tancan];

               }
           } failureBlock:^(NSError *error) {
           } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {

           }];
}


//弹窗
-(void)tancan{
    _bjview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bjview.backgroundColor = [UIColor blackColor];
    _bjview.alpha = 0.6;
    [self.view addSubview:_bjview];
    
    //白色提示框视图
    _baiseview = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-285)/2, 250, 285, 170)];
    _baiseview.backgroundColor = [UIColor whiteColor];
    KViewBorderRadius(_baiseview, 7.5, 0.5, [UIColor clearColor]);
    [self.view addSubview:_baiseview];
    
    //申请成功
    UILabel *cglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 22.5, _baiseview.width, 21)];
    cglabel.textAlignment = NSTextAlignmentCenter;
    cglabel.font = [UIFont systemFontOfSize:15];
    cglabel.text = @"成功提交申请";
    [_baiseview addSubview:cglabel];
    
    //提示内容
    UILabel *tslabel = [[UILabel alloc]initWithFrame:CGRectMake(32, cglabel.bottom+14, 228, 37)];
    tslabel.font = [UIFont systemFontOfSize:13];
    tslabel.text = @"我们将尽快处理你的申请。审核通过，您将在消息中心收到我们发放邀请码";
    tslabel.numberOfLines = 0;
    tslabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [_baiseview addSubview:tslabel];
    
    //确定按钮
    UIButton *qudingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    qudingbutton.frame = CGRectMake(28, tslabel.bottom+15, 227, 39);
    qudingbutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
    [qudingbutton setTitle:@"确定" forState:UIControlStateNormal];
    qudingbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [qudingbutton addTarget:self action:@selector(qudingbuttonaciton) forControlEvents:UIControlEventTouchUpInside];
    KViewBorderRadius(qudingbutton, 7.5, 0.5, [UIColor clearColor]);
    [_baiseview addSubview:qudingbutton];
}




//确定按钮点击事件
-(void)qudingbuttonaciton{
    [self.navigationController popViewControllerAnimated:YES];
    [_baiseview removeFromSuperview];
    [_bjview removeFromSuperview];

    [[NSNotificationCenter defaultCenter] postNotificationName:Application object:nil];
}
@end
