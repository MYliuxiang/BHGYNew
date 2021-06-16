//
//  GenderViewController.m
//  BHGY
//
//  Created by 李立 on 2020/7/5.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "GenderViewController.h"
#import "PerfectVC.h"
#import "InvitationcodeVC.h"
@interface GenderViewController ()
@property(nonatomic,strong) LoginModel *model;
@end

@implementation GenderViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.model = [LoginManger sharedManager].currentLoginModel;
     self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
     [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@""]];
     self.customNavBar.backgroundColor = [UIColor whiteColor];
    [self setui];
}

//初始化ui
-(void)setui{
    //返回按钮
    UIButton *fanhuibutton = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhuibutton.frame = CGRectMake(12.5, Height_StatusBar+13.5, 30, 30);
    [fanhuibutton setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    [fanhuibutton addTarget:self action:@selector(fanhuibuttonaciton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhuibutton];
    
    //请选择性别
    UILabel *xuanzelable = [[UILabel alloc]initWithFrame:CGRectMake(0, Height_StatusBar+79, kScreenWidth, 37.5)];
    xuanzelable.font = [UIFont boldSystemFontOfSize:27];
    xuanzelable.text = @"Hi～请选择你的性别";
    xuanzelable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:xuanzelable];
    
    //无法修改
    UILabel *xiugailable = [[UILabel alloc]initWithFrame:CGRectMake(0, xuanzelable.bottom+12.5, kScreenWidth, 37.5)];
    xiugailable.font = [UIFont systemFontOfSize:15];
    xiugailable.text = @"性别选择后无法修改哦";
    xiugailable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:xiugailable];
    
    //男性视图
    _nanview = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-149*2-30)/2, xiugailable.bottom+67.5, 149, 149)];
    _nanview.backgroundColor = [UIColor colorWithHexString:@"#DCF4FF"];
    KViewBorderRadius(_nanview, 7.5, 2, [UIColor colorWithHexString:@"#82D8FF"]);
    [self.view addSubview:_nanview];
    
    UITapGestureRecognizer *nantap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nantapaciton)];
    [_nanview addGestureRecognizer:nantap];
    _boyimageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    _boyimageview.image = [UIImage imageNamed:@"性别选中"];
    _boyimageview.userInteractionEnabled = YES;
    self.sexsring = @"1";
    [_nanview addSubview:_boyimageview];
    //男性图标
    UIImageView *nanimageview = [[UIImageView alloc]initWithFrame:CGRectMake(34.5, 31.5, 77, 77)];
    nanimageview.image = [UIImage imageNamed:@"男性图标"];
    nanimageview.userInteractionEnabled = YES;
    [_nanview addSubview:nanimageview];
    
    //男士文字
    _boylabel = [[UILabel alloc]initWithFrame:CGRectMake(_nanview.left, _nanview.bottom+12.5, _nanview.width, 22.5)];
    _boylabel.font = [UIFont systemFontOfSize:16];
    _boylabel.textColor = [UIColor colorWithHexString:@"#82D8FF"];
    _boylabel.textAlignment = NSTextAlignmentCenter;
    _boylabel.text = @"男士";
    [self.view addSubview:_boylabel];
    
    //女士视图
    _nvview = [[UIView alloc]initWithFrame:CGRectMake(_nanview.right+30, xiugailable.bottom+67.5, 149, 149)];
    _nvview.backgroundColor = [UIColor colorWithHexString:@"#FEE3EB"];
    KViewBorderRadius(_nvview, 7.5, 2, [UIColor colorWithHexString:@"#FEE3EB"]);
    [self.view addSubview:_nvview];
    
    UITapGestureRecognizer *nvtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nvtaptapaciton)];
    [_nvview addGestureRecognizer:nvtap];
    
    _giryimageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    _giryimageview.image = [UIImage imageNamed:@"性别未选中"];
    _giryimageview.userInteractionEnabled = YES;
    [_nvview addSubview:_giryimageview];
    //女士图标
    UIImageView *nvimageview = [[UIImageView alloc]initWithFrame:CGRectMake(34.5, 31.5, 77, 77)];
    nvimageview.image = [UIImage imageNamed:@"女性图标"];
    nvimageview.userInteractionEnabled = YES;
    [_nvview addSubview:nvimageview];
    
    //女士文字
    _girllabel = [[UILabel alloc]initWithFrame:CGRectMake(_nvview.left, _nvview.bottom+12.5, _nvview.width, 22.5)];
    _girllabel.font = [UIFont systemFontOfSize:16];
    _girllabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _girllabel.textAlignment = NSTextAlignmentCenter;
    _girllabel.text = @"女士";
    [self.view addSubview:_girllabel];
    
    
    
      //确定按钮
       UIButton *quedingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
       quedingbutton.frame = CGRectMake(23, _girllabel.bottom+67, kScreenWidth-46, 45);
       KViewBorderRadius(quedingbutton, 22.5, 0.5, [UIColor clearColor]);
       [quedingbutton setTitle:@"确定" forState:UIControlStateNormal];
       [quedingbutton addTarget:self action:@selector(quedingbuttonaciton) forControlEvents:UIControlEventTouchUpInside];
       [quedingbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       quedingbutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
       [self.view addSubview:quedingbutton];
}



//点击男士图标
-(void)nantapaciton{
    _boylabel.textColor = [UIColor colorWithHexString:@"#82D8FF"];
    _boyimageview.image = [UIImage imageNamed:@"性别选中"];
    KViewBorderRadius(_nanview, 7.5, 2, [UIColor colorWithHexString:@"#82D8FF"]);
  
    _girllabel.textColor = [UIColor colorWithHexString:@"#333333"];
   _giryimageview.image = [UIImage imageNamed:@"性别未选中"];
   KViewBorderRadius(_nvview, 7.5, 2, [UIColor colorWithHexString:@"#FEE3EB"]);
 self.sexsring = @"1";
    
}

//女性图标选中
-(void)nvtaptapaciton{
    _boyimageview.image = [UIImage imageNamed:@"性别未选中"];
    _boylabel.textColor = [UIColor colorWithHexString:@"#333333"];
   KViewBorderRadius(_nanview, 7.5, 2, [UIColor colorWithHexString:@"#DCF4FF"]);
   
    _girllabel.textColor = [UIColor colorWithHexString:@"#FB78A3"];
    _giryimageview.image = [UIImage imageNamed:@"性别选中"];
    KViewBorderRadius(_nvview, 7.5, 2, [UIColor colorWithHexString:@"#FB78A3"]);
     self.sexsring = @"0";
}


//返回按钮点击事件
-(void)fanhuibuttonaciton{
    [self.navigationController popViewControllerAnimated:YES];
}


//确定按钮点击事件
-(void)quedingbuttonaciton{
    
    //黑色背景视图
    _bjview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bjview.backgroundColor = [UIColor blackColor];
    _bjview.alpha = .6;
    [self.view addSubview:_bjview];
    
       
    //白色背景视图
      _baiseview = [[UIView alloc] init];
     _baiseview .frame = CGRectMake(45.5,363,kScreenWidth-91,153);
     _baiseview .layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
     _baiseview .layer.cornerRadius = 7.5;
    [self.view addSubview:_baiseview];
    
    //提示文字
    UILabel *tishilabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 33, _baiseview.width, 21)];
    tishilabel.font = [UIFont systemFontOfSize:15];
    tishilabel.textColor = [UIColor colorWithHexString:@"#333333"];
    tishilabel.textAlignment = NSTextAlignmentCenter;
    tishilabel.text = @"注册后将不能修改性别，确定吗？";
    [_baiseview addSubview:tishilabel];
    
    //关闭按钮
    UIButton *guanbibutton = [UIButton buttonWithType:UIButtonTypeCustom];
     guanbibutton.frame = CGRectMake(_baiseview.width-18, 3, 16, 16);
     [guanbibutton addTarget:self action:@selector(baisebuttonaciton) forControlEvents:UIControlEventTouchUpInside];
    [guanbibutton setImage:[UIImage imageNamed:@"提示框关闭按钮"] forState:UIControlStateNormal];
     [_baiseview addSubview:guanbibutton];
    
    //确定按钮
  UIButton *quedingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
  quedingbutton.frame = CGRectMake(28, tishilabel.bottom+24.5, _baiseview.width-56, 39);
  KViewBorderRadius(quedingbutton, 19.5, 0.5, [UIColor clearColor]);
  [quedingbutton setTitle:@"确定" forState:UIControlStateNormal];
  [quedingbutton addTarget:self action:@selector(baisebuttonaciton) forControlEvents:UIControlEventTouchUpInside];
  [quedingbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  quedingbutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
  [_baiseview addSubview:quedingbutton];
    
}


//白色视图确定
-(void)baisebuttonaciton{
    [self.baiseview removeFromSuperview];
    [self.bjview removeFromSuperview];
    
    //如果选择的是女性
    if ([self.sexsring isEqualToString:@"0"]) {
        //设置性别
        [self updatasex];
    }else{
        if (self.model.status ==0) {
              //选择男性跳转到填写邀请码界面
          InvitationcodeVC *vc = [[InvitationcodeVC alloc]init];
          [self.navigationController pushViewController:vc animated:YES];
            
            }else{
                
                [[RCIM sharedRCIM] connectWithToken:[LoginManger sharedManager].currentLoginModel.rongCloudTOken
                                           dbOpened:^(RCDBErrorCode code) {
                    //消息数据库打开，可以进入到主页面
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
                                                                 [HandleTool switchLgoinVC];
                                                             });
                                       
                }];
                          
            }
        }
    }


//如果选择女性
-(void)updatasex{
          //设置性别接口
          BADataEntity *entity = [BADataEntity new];
          entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_updateSex];
          entity.needCache = NO;
          entity.parameters = @{@"sex":self.sexsring};
          [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
          [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
              NSDictionary *result = response;
              if ([result[@"code"] intValue] == 0) {
              if (self.model.status ==0) {
              PerfectVC *vc = [[PerfectVC alloc]init];
              [self.navigationController pushViewController:vc animated:YES];
              }
      
          }
              
          } failureBlock:^(NSError *error) {
              
              
          } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
              
          }];
    
}
@end
