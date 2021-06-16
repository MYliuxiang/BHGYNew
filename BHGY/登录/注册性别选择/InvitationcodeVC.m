//
//  InvitationcodeVC.m
//  BHGY
//
//  Created by 李立 on 2020/7/25.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "InvitationcodeVC.h"
#import "ApplicationcodeVC.h"
#import "BuyingmembersVC.h"
@interface InvitationcodeVC ()<UITextFieldDelegate>

@end

@implementation InvitationcodeVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self setui];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hdhideen) name:Application object:nil];

}
//初始化ui
-(void)setui{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFF2F4"];
  
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
     loginlabel.text = @"填写邀请码";
     loginlabel.font = [UIFont boldSystemFontOfSize:27];
     [self.view addSubview:loginlabel];
    
    UILabel *tianxielabel = [[UILabel alloc]initWithFrame:CGRectMake(loginlabel.left,loginlabel.bottom+3 , kScreenWidth-30, 15)];
    tianxielabel.font = [UIFont systemFontOfSize:11];
    tianxielabel.textColor = [UIColor whiteColor];
    tianxielabel.text = @"百花公园仅向拥有邀请码的男士提供服务";
    [self.view addSubview:tianxielabel];
     
     //白色视图
     UIView *baiseview = [[UIView alloc] init];
     baiseview.frame = CGRectMake(15,loginlabel.bottom+26,kScreenWidth-30,165.5);
     baiseview.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
     baiseview.layer.cornerRadius = 7.5;
     [self.view addSubview:baiseview];
     
     //电话号码输入框
     _iphoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, 39, baiseview.width-50, 20)];
     _iphoneTextField.font = [UIFont systemFontOfSize:14];
     _iphoneTextField.placeholder = @"请填写你的邀请码";
     _iphoneTextField.delegate = self;
//     _iphoneTextField.keyboardType = UIKeyboardTypeNumberPad;
     //    _iphoneTextField.clearButtonMode = UITextFieldViewModeAlways;
     [baiseview addSubview:_iphoneTextField];
     
     //线条
     UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(21, _iphoneTextField.bottom+5, _iphoneTextField.width, 0.5)];
     xtview.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
     [baiseview addSubview:xtview];
    
      //立即重置按钮
       UIButton *lijibutton = [UIButton buttonWithType:UIButtonTypeCustom];
       lijibutton.frame = CGRectMake(6.5, xtview.bottom+24, baiseview.width-13, 45);
       KViewBorderRadius(lijibutton, 22.5, 0.5, [UIColor clearColor]);
       [lijibutton setTitle:@"确定" forState:UIControlStateNormal];
       [lijibutton addTarget:self action:@selector(lijibuttonbuttonaciton) forControlEvents:UIControlEventTouchUpInside];
       [lijibutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       lijibutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
       [baiseview addSubview:lijibutton];
    
    
    //没有邀请码
    UILabel *noaciledlabel = [[UILabel alloc]initWithFrame:CGRectMake(0,kScreenHeight-290, kScreenWidth, 15)];
   noaciledlabel.font = [UIFont systemFontOfSize:11];
   noaciledlabel.textColor = [UIColor colorWithHexString:@"#999999"];
   noaciledlabel.text = @"百花公园仅向拥有邀请码的男士提供服务";
    noaciledlabel.textAlignment = NSTextAlignmentCenter;
   [self.view addSubview:noaciledlabel];
    
    //第一个白色视图
    UIView *baiseview1 = [[UIView alloc]initWithFrame:CGRectMake(15, noaciledlabel.bottom+15, kScreenWidth-30, 99.5)];
    baiseview1.backgroundColor = [UIColor whiteColor];
    KViewBorderRadius(baiseview1, 7.5, 0.5, [UIColor clearColor]);
    [self.view addSubview:baiseview1];
    
    //第一步小图片
    UIImageView *oneimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 14.5, 18, 16)];
    oneimageview.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:111/255.0 blue:158/255.0 alpha:1.0].CGColor;
//    KViewBorderRadius(oneimageview, 50, 0.5, [UIColor clearColor]);
    oneimageview.layer.cornerRadius = 50;
    [baiseview1 addSubview:oneimageview];
    
    //填写申请
    UILabel *txsqlabel = [[UILabel alloc]initWithFrame:CGRectMake(oneimageview.right+3, 13.5, 80, 18.5)];
    txsqlabel.font = [UIFont systemFontOfSize:13];
    txsqlabel.textColor = [UIColor blackColor];
    txsqlabel.text = @"免费申请";
    [baiseview1 addSubview:txsqlabel];
    
    //立即申请按钮
    UIButton *ljsqbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    ljsqbutton.frame = CGRectMake(baiseview1.width-90, 10, 75, 25);
    ljsqbutton.backgroundColor = [UIColor colorWithHexString:@"#FF93B6"];
    [ljsqbutton setTitle:@"立即申请" forState:UIControlStateNormal];
    [ljsqbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ljsqbutton addTarget:self action:@selector(ljsqbutton) forControlEvents:UIControlEventTouchUpInside];
    ljsqbutton.titleLabel.font = [UIFont systemFontOfSize:12];
    KViewBorderRadius(ljsqbutton, 13, 0.5, [UIColor clearColor]);
    [baiseview1 addSubview:ljsqbutton];
    
    //提示语句
    UILabel *tslabel = [[UILabel alloc]initWithFrame:CGRectMake(23.5, txsqlabel.bottom+15.5, 230, 36)];
    tslabel.font = [UIFont systemFontOfSize:12];
    tslabel.textColor = [UIColor colorWithHexString:@"#999999"];
    tslabel.text = @"你需要填写相关个人资料，审核通过后会给你发送邀请码。";
    tslabel.numberOfLines = 0;
    [baiseview1 addSubview:tslabel];
    
    //查收邀请码
    UIButton *chashoubutton = [UIButton buttonWithType:UIButtonTypeCustom];
    chashoubutton.frame = CGRectMake(ljsqbutton.left, ljsqbutton.bottom+12.5, 75, 16.5);
    [chashoubutton setTitle:@"查收邀请码 >" forState:UIControlStateNormal];
    [chashoubutton setTitleColor:[UIColor colorWithHexString:@"#359EFF"] forState:UIControlStateNormal];
    [chashoubutton addTarget:self action:@selector(chakanaciton) forControlEvents:UIControlEventTouchUpInside];
    chashoubutton.titleLabel.font = [UIFont systemFontOfSize:12];
    [baiseview1 addSubview:chashoubutton];
    
    //红色小点
    self.hongdianview = [[UIView alloc] init];
    self.hongdianview.frame = CGRectMake(chashoubutton.right-13,chashoubutton.top+2,4,4);
    KViewBorderRadius(self.hongdianview, 2, 0.5, [UIColor clearColor]);
    self.hongdianview.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:63/255.0 blue:63/255.0 alpha:1.0].CGColor;
    self.hongdianview.hidden = YES;
    [baiseview1 addSubview:self.hongdianview];
    
    
    //第二个视图
       UIView *baiseview2 = [[UIView alloc]initWithFrame:CGRectMake(15, baiseview1.bottom+10, kScreenWidth-30, 99.5)];
       baiseview2.backgroundColor = [UIColor whiteColor];
       KViewBorderRadius(baiseview2, 7.5, 0.5, [UIColor clearColor]);
       [self.view addSubview:baiseview2];
       
       //第一步小图片
       UIImageView *twoimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 14.5, 18, 16)];
       twoimageview.backgroundColor = [UIColor colorWithHexString:@"#FF6F9E"];
       [baiseview2 addSubview:twoimageview];
       
       //填写申请
       UILabel *txsqlabel1 = [[UILabel alloc]initWithFrame:CGRectMake(twoimageview.right+3, 13.5, 120, 18.5)];
       txsqlabel1.font = [UIFont systemFontOfSize:13];
       txsqlabel1.textColor = [UIColor blackColor];
       txsqlabel1.text = @"付费购买会员";
       [baiseview2 addSubview:txsqlabel1];
       
       //立即申请按钮
       UIButton *ljsqbutton1 = [UIButton buttonWithType:UIButtonTypeCustom];
       ljsqbutton1.frame = CGRectMake(baiseview2.width-90, 10, 75, 25);
       ljsqbutton1.backgroundColor = [UIColor colorWithHexString:@"#FF6F9E"];
       [ljsqbutton1 setTitle:@"马上购买" forState:UIControlStateNormal];
       [ljsqbutton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ljsqbutton1 addTarget:self action:@selector(goumaibuttonacion) forControlEvents:UIControlEventTouchUpInside];
       ljsqbutton1.titleLabel.font = [UIFont systemFontOfSize:12];
       KViewBorderRadius(ljsqbutton1, 13, 0.5, [UIColor clearColor]);
       [baiseview2 addSubview:ljsqbutton1];
       
       //提示语句
       UILabel *tslabel1 = [[UILabel alloc]initWithFrame:CGRectMake(23.5, ljsqbutton1.bottom+15.5, 230, 18)];
       tslabel1.font = [UIFont systemFontOfSize:12];
       tslabel1.textColor = [UIColor colorWithHexString:@"#999999"];
       tslabel1.text = @"购买会员后，您将可以使用介绍相关权益。";
       tslabel1.numberOfLines = 0;
       [baiseview2 addSubview:tslabel1];
    
    UIView *bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, baiseview2.bottom, kScreenWidth, 100)];
    bottomview.backgroundColor = [UIColor colorWithHexString:@"#EFF2F4"];
    [self.view addSubview:bottomview];
}


//确定
-(void)lijibuttonbuttonaciton{
    
       BADataEntity *entity = [BADataEntity new];
       entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userInfo_updateSex];
       entity.needCache = NO;
       entity.parameters = @{@"invite":_iphoneTextField.text,@"sex":@"0"};
       [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
       [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
           NSDictionary *result = response;
           if ([result[@"code"] intValue] == 0) {
              //没完善信息
               PerfectVC *vc = [[PerfectVC alloc]init];
               [self.navigationController pushViewController:vc animated:YES];
           }
           
       } failureBlock:^(NSError *error) {
           
           
       } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
           
       }];
    
}


//接收通知显示红点
-(void)hdhideen{
    self.hongdianview.hidden = NO;
    
}

//返回按钮
-(void)fanhuibuttonaciton{
    [self.navigationController popViewControllerAnimated:YES];
    
}

//查看邀请码
-(void)chakanaciton{
      //查看邀请码
         BADataEntity *entity = [BADataEntity new];
         entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_activationCode];
         entity.needCache = NO;
    //     entity.parameters = @{@"sex":self.sexsring};
         [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
         [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
             NSDictionary *result = response;
             if ([result[@"code"] intValue] == 0) {
                 //申请成功后自动填入到输入框并调用确定按钮事件
                 
             }
             
         } failureBlock:^(NSError *error) {
             
             
         } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
             
         }];
    
}

//立即申请按钮
-(void)ljsqbutton{
    ApplicationcodeVC *vc = [[ApplicationcodeVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

    
}

//立即购买按钮
-(void)goumaibuttonacion{
    BuyingmembersVC *vc = [[BuyingmembersVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
