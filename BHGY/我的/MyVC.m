//
//  MyVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/2.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "MyVC.h"
#import "StepViewController.h"
#import "PersonaldataViewController.h"
#import "authenticationcenterViewController.h"
#import "MyLikeVC.h"
@interface MyVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) LoginModel *model;

@end

@implementation MyVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.model = [LoginManger sharedManager].currentLoginModel;
    [self setModelui];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EFF2F4"];
    // Do any additional setup after loading the view from its nib.
    self.model = [LoginManger sharedManager].currentLoginModel;
    self.customNavBar.title = self.model.nickName;
    [self setui];
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"设置"]];
    
    //设置按钮点击
    [self.customNavBar setOnClickRightButton:^{
        StepViewController *vc = [[StepViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
   
    [self loadPhotos];
}


- (void)loadDatas{
    
    BADataEntity *entity = [BADataEntity new];
       entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userInfo_getInfo];
       entity.needCache = NO;
       [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
           NSDictionary *result = response;
           if ([result[@"code"] intValue] == 0) {
               LoginModel *model = [LoginModel mj_objectWithKeyValues:result[@"data"]];
             [LoginManger sharedManager].currentLoginModel = model;
               [self.tableView reloadData];

               
           }
           
       } failureBlock:^(NSError *error) {
           
           
       } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
           
       }];
}



- (void)loadPhotos{
    
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userPhoto_listMine];
    entity.needCache = NO;
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            NSArray *models = [UserPhoto mj_objectArrayWithKeyValuesArray:result[@"data"]];
            self.model.photoList = models;
            [LoginManger sharedManager].currentLoginModel = self.model;
            [self.tableView reloadData];
        }
        
    } failureBlock:^(NSError *error) {
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
       
}


//初始化视图
-(void)setui{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar - Height_TabBar) style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#EFF2F4"];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    
    //头视图
    UIView *hedaview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 227)];
    hedaview.backgroundColor = [UIColor colorWithHexString:@"#EFF2F4"];
    self.tableView.tableHeaderView = hedaview;
    
    //背景视图，根据性别更换
    self.topbjview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 177)];
    [hedaview addSubview:_topbjview];
    //头像
   _headbutton = [UIButton buttonWithType:UIButtonTypeCustom];
   _headbutton.frame = CGRectMake((kScreenWidth-80)/2, 27.5, 80, 80);
   KViewBorderRadius(_headbutton, 10, 0.5, [UIColor clearColor]);
    [_headbutton sd_setImageWithURL:[NSURL URLWithString:[HandleTool getImageUrlStr:self.model.avatar]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@""]];
//   _headbutton.backgroundColor = [UIColor grayColor];
   [self.topbjview addSubview:_headbutton];
    
    //性别视图
    UIView *sexview = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-150)/2, _headbutton.bottom+11, 34, 16)];
    sexview.backgroundColor = [UIColor whiteColor];
    KViewBorderRadius(sexview, 8, 0.5, [UIColor clearColor]);
    [self.topbjview addSubview:sexview];
    
    //性别图标
       self.seximageview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 4, 8, 8)];
       [sexview addSubview:self.seximageview];
    
    
    //性别label
    _sexlabel = [[UILabel alloc]initWithFrame:CGRectMake(self.seximageview.right+1, 1, 16, 12)];
    _sexlabel.font = [UIFont systemFontOfSize:10];
    _sexlabel.textColor = [UIColor colorWithHexString:@"#78A3FB"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
      [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
      NSDate *birthDay = [dateFormatter dateFromString:self.model.birthday];
     _sexlabel.text = [self dateToOld:birthDay];
    _sexlabel.textAlignment = NSTextAlignmentCenter;
    [sexview addSubview:_sexlabel];
  
//    NSLog(@"您的年龄:%@岁",);
    
    //星座
     _xingzuolabel = [[UILabel alloc]initWithFrame:CGRectMake(sexview.right+10, sexview.top, 48, 16)];
    _xingzuolabel.font = [UIFont systemFontOfSize:10];
    _xingzuolabel.textColor = [UIColor colorWithHexString:@"#78A3FB"];
    _xingzuolabel.text = @"摩羯座";
    _xingzuolabel.backgroundColor = [UIColor whiteColor];
    KViewBorderRadius(_xingzuolabel, 8, 0.5, [UIColor clearColor]);
    _xingzuolabel.textAlignment = NSTextAlignmentCenter;
    [self.topbjview addSubview:_xingzuolabel];
    
    //职业
  _joblabel = [[UILabel alloc]initWithFrame:CGRectMake(_xingzuolabel.right+10, sexview.top, 48, 16)];
 _joblabel.font = [UIFont systemFontOfSize:10];
 _joblabel.textColor = [UIColor colorWithHexString:@"#78A3FB"];
 _joblabel.text = @"护士";
 _joblabel.backgroundColor = [UIColor whiteColor];
 KViewBorderRadius(_joblabel, 8, 0.5, [UIColor clearColor]);
 _joblabel.textAlignment = NSTextAlignmentCenter;
  _joblabel.text = self.model.profession;
 [self.topbjview addSubview:_joblabel];
    
    //白色背景视图
    UIView *baiseview = [[UIView alloc] init];
    baiseview.frame = CGRectMake(15,self.topbjview.bottom-30,kScreenWidth-30,80);
    baiseview.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    baiseview.layer.cornerRadius = 7.5;
    [hedaview addSubview:baiseview];
    
    if (self.model.sex ==0) {
         //女
     self.topbjview.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
      self.seximageview.image = [UIImage imageNamed:@"我的女性标记"];
        _joblabel.textColor = [UIColor colorWithHexString:@"#FB78A3"];
        _xingzuolabel.textColor = [UIColor colorWithHexString:@"#FB78A3"];
        _sexlabel.textColor = [UIColor colorWithHexString:@"#FB78A3"];
     }else{
         //男
    self.seximageview.image = [UIImage imageNamed:@"编组 4备份 6-1"];
     self.topbjview.backgroundColor = [UIColor colorWithHexString:@"#78A3FB"];
     }
    
    //创建白色视图上按钮
    NSArray *imagearrys = @[@"个人资料",@"我的钱包",@"我喜欢的",@"我的评价",@"我的广播"];
    NSArray *titlearrys = @[@"个人资料",@"我的钱包",@"我喜欢的",@"我的评价",@"我的广播"];
    
    CGFloat width = (kScreenWidth-30) / 5.0;
    
    for (int i=0; i<titlearrys.count; i++) {
//        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(i*(baiseview.width/5)+31, 16.5, 25, 25)];
//        imageview.image = [UIImage imageNamed:imagearrys[i]];
//        imageview.userInteractionEnabled = YES;
//        [baiseview addSubview:imageview];
//        //文字
//        UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(imageview.left-10, imageview.bottom+8.5, 50, 15)];
//        label.font = [UIFont systemFontOfSize:11];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.textColor = [UIColor colorWithHexString:@"#666666"];
//        label.text = titlearrys[i];
//        [baiseview addSubview:label];
        
        //按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * width, 0, width, baiseview.bounds.size.height);
        [button setImage:[UIImage imageNamed:imagearrys[i]] forState:UIControlStateNormal];
        [button setTitle:titlearrys[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonaciton:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:Color_6 forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        button.tag = 50+i;
        [baiseview addSubview:button];
        
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];

    }
}

-(NSString *)dateToOld:(NSDate *)bornDate{
//获得当前系统时间
NSDate *currentDate = [NSDate date];
//获得当前系统时间与出生日期之间的时间间隔
NSTimeInterval time = [currentDate timeIntervalSinceDate:bornDate];
//时间间隔以秒作为单位,求年的话除以60*60*24*356
int age = ((int)time)/(3600*24*365);
return [NSString stringWithFormat:@"%d",age];
}


//我的评价
- (void)mycomment{
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userMark_view];
    entity.needCache = NO;
    entity.parameters = @{@"userId":self.model.userId};
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            NSArray *models = [MyCommentModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            CommentAlert *alert = [[CommentAlert alloc] initWithContents:models];
               alert.titleL.text = @"我的真实评价";
               alert.titleL.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
               alert.jubB.hidden = YES;
               alert.commentB.hidden = YES;
               [alert setupAutoHeightWithBottomView:alert.commentB bottomMargin:-44];
               [alert.commentB setTitle:@"匿名评价" forState:UIControlStateNormal];
                   [alert show];
               
        }
    } failureBlock:^(NSError *error) {
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    }];
    
   
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
       return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      
    if (section == 0) {
        return 1;
    }else if (section ==1){
        return 2;
    }else if (section ==2){
        return 1;
    }else if (section ==3){
        return 1;
    }else {
        return 2;
    }

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        static NSString *identifire = @"cellID";
           MyPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
           if (cell == nil) {
               cell = [[[NSBundle mainBundle] loadNibNamed:@"MyPhotoCell" owner:nil options:nil] lastObject];
               cell.selectionStyle = UITableViewCellSelectionStyleNone;
               
           }
        cell.photos = self.model.photoList;
        __weak typeof(self) weakSelf = self;
        
        cell.reloadPhotos = ^(NSArray * _Nonnull photos) {
            weakSelf.model.photoList = photos;
            [LoginManger sharedManager].currentLoginModel = weakSelf.model;
            [weakSelf.tableView reloadData];
        };
        cell.reloadDatas = ^() {
            [weakSelf loadPhotos];
        };
                
        return cell;
    }
         UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] init];
        [cell setRestorationIdentifier:@"UITableViewCell"];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.textLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    
    //线条
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(0, cell.height-0.5, kScreenWidth, 0.5)];
    xtview.backgroundColor = [UIColor colorWithHexString:@"#D8D8D8"];
    xtview.hidden = YES;
    [cell addSubview:xtview];
    //箭头
    UIImageView *jtimageview = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-23, 15.6, 6.5, 12)];
    jtimageview.image = [UIImage imageNamed:@"个人中心表视图箭头"];
    [cell addSubview:jtimageview];
    
    if (indexPath.section ==0) {
        cell.textLabel.text = @"认证中心";
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-58, 16, 26, 12)];
        imageview.image = [UIImage imageNamed:@"个人中心真人"];
        [cell addSubview:imageview];
    }else if (indexPath.section ==1){
        if (indexPath.row ==0) {
             xtview.hidden = NO;
            jtimageview.hidden = YES;
        }else{
        cell.textLabel.text = @"相册隐私";
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-84, 14, 50, 16.5)];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor colorWithHexString:@"#999999"];
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"公开";
        [cell addSubview:label];
        }
    }else if (indexPath.section ==2){
         cell.textLabel.text = @"黑名单";
    }else if (indexPath.section ==3){
        cell.textLabel.text = @"分享百花公园给朋友";
         jtimageview.hidden = YES;
    }else if (indexPath.section ==4){
        if (indexPath.row ==0) {
         xtview.hidden = NO;
         jtimageview.hidden = YES;
         cell.textLabel.text = @"联系客服";
        }else{
            cell.textLabel.text = @"投诉客服";
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        if (self.model.photoList.count == 0) {
            return 40 + 30;
        }else if(self.model.photoList.count <= 3){
            return 40 + 30 + (kScreenWidth - 30 - 20) / 3 + 10;

        }else{
            return 40 + 30 + 2 * (kScreenWidth - 30 - 20) / 3 + 10;
        }
    }
       
    return 44;
   
}
//组视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section ==0) {
        authenticationcenterViewController *vc = [[authenticationcenterViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 4 && indexPath.row == 1) {
        ComplaintVC *vc = [[ComplaintVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
   
    if (indexPath.section ==1 && indexPath.row ==1) {
        //相册隐私
//        [self creatActionSheet];
        
        PhotoSetAlert *alert = [[PhotoSetAlert alloc] initWithContents:@[@"公开(推荐)",@"相册解锁查看",@"查看前需要通过我的验证"]  withIndex:0];
        __weak typeof(self) weakSelf = self;

        alert.clickBlcok = ^(NSInteger index) {
            if (index == 0) {
                [weakSelf settingPhotoType:0];
            }else if(index == 1){
                [weakSelf settingPhotoType:1];

            }else{
                [weakSelf quedingbuttonaciton];
            }
        };
        alert.titleL.text = @"相册隐私";
        [alert show];
        
        
    }
    
    if (indexPath.section == 2 && indexPath.row == 0){
        //黑名单
        MyBlackVC *vc = [MyBlackVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)settingPhotoType:(int)type{
    
    BADataEntity *entity = [BADataEntity new];
       entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userPhoto_listMine];
       entity.needCache = NO;
    entity.parameters = @{@"type":@(type)};
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
       [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
           NSDictionary *result = response;
           if ([result[@"code"] intValue] == 0) {
               [MBProgressHUD showError:@"设置成功" toView:lxWindow];
           }
           
       } failureBlock:^(NSError *error) {
           
           
       } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
           
       }];
}


//个人资料，我的钱包点击事件
-(void)buttonaciton:(UIButton *)button{
    
    if (button.tag ==50) {
        //个人资料
        PersonaldataViewController *vc = [[PersonaldataViewController alloc]init];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 51){
        //我的钱包
    }else if (button.tag == 52){
        //我喜欢的
        MyLikeVC *vc = [[MyLikeVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
          
    }else if (button.tag ==53){
        //我的评价
       [self mycomment];
    }else if (button.tag ==54){
        //我的广播
        MyRadioVC *vc = [[MyRadioVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}



-(void)creatActionSheet {
    /*
     先创建UIAlertController，preferredStyle：选择UIAlertControllerStyleActionSheet，这个就是相当于创建8.0版本之前的UIActionSheet；
     
     typedef NS_ENUM(NSInteger, UIAlertControllerStyle) {
     UIAlertControllerStyleActionSheet = 0,
     UIAlertControllerStyleAlert
     } NS_ENUM_AVAILABLE_IOS(8_0);
     */
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"相册隐私" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
   
    /*
     typedef NS_ENUM(NSInteger, UIAlertActionStyle) {
     UIAlertActionStyleDefault = 0,
     UIAlertActionStyleCancel,         取消按钮
     UIAlertActionStyleDestructive     破坏性按钮，比如：“删除”，字体颜色是红色的
     } NS_ENUM_AVAILABLE_IOS(8_0);
     
     */
    // 创建action，这里action1只是方便编写，以后再编程的过程中还是以命名规范为主
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"公开（推荐）" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册解锁查看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"查看前需通过我验证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      
        [self quedingbuttonaciton];
    }];
   
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    UIColor *color=[UIColor colorWithHexString:@"#999999"];
    UIColor *blackcolor = [UIColor colorWithHexString:@"#666666"];
    [action1 setValue:color forKey:@"titleTextColor"];
    [action2 setValue:color forKey:@"titleTextColor"];
    [action3 setValue:color forKey:@"titleTextColor"];
    [action4 setValue:blackcolor forKey:@"titleTextColor"];

    //把action添加到actionSheet里
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    [actionSheet addAction:action4];
    //相当于之前的[actionSheet show];
    [self presentViewController:actionSheet animated:YES completion:nil];

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
     _baiseview .frame = CGRectMake(45.5,363,kScreenWidth-91,174);
     _baiseview .layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
     _baiseview .layer.cornerRadius = 7.5;
    [self.view addSubview:_baiseview];
    
    //提示文字
    UILabel *tishilabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 33, _baiseview.width, 42)];
    tishilabel.font = [UIFont systemFontOfSize:15];
    tishilabel.textColor = [UIColor colorWithHexString:@"#333333"];
    tishilabel.textAlignment = NSTextAlignmentCenter;
    tishilabel.numberOfLines = 0;
    tishilabel.text = @"所有女士都需要必须发照片让你验证身份\n才能浏览你的主页，确定么";
    [_baiseview addSubview:tishilabel];
    
    //关闭按钮
    UIButton *guanbibutton = [UIButton buttonWithType:UIButtonTypeCustom];
     guanbibutton.frame = CGRectMake(_baiseview.width-20, 5, 16, 16);
     [guanbibutton addTarget:self action:@selector(baisebuttonaciton) forControlEvents:UIControlEventTouchUpInside];
    [guanbibutton setImage:[UIImage imageNamed:@"提示框关闭按钮"] forState:UIControlStateNormal];
     [_baiseview addSubview:guanbibutton];
    
    //确定按钮
  UIButton *quedingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
  quedingbutton.frame = CGRectMake(28, tishilabel.bottom+34.5, _baiseview.width-56, 39);
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
    
    [self settingPhotoType:3];
}


////回来的时候赋值
-(void)setModelui{
    [_headbutton sd_setImageWithURL:[NSURL URLWithString:[HandleTool getImageUrlStr:self.model.avatar]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@""]];
    //年龄
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
     NSDate *birthDay = [dateFormatter dateFromString:self.model.birthday];
    _sexlabel.text = [self dateToOld:birthDay];

    //职业
    _joblabel.text = self.model.profession;
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:10]};
    CGSize size=[_joblabel.text sizeWithAttributes:attrs];
    [self.joblabel setFrame:CGRectMake(_xingzuolabel.right+10, _xingzuolabel.top, size.width+15, 16)];
    KViewBorderRadius(_joblabel, 8, 0.5, [UIColor clearColor]);
    self.customNavBar.title = self.model.nickName;
}


@end
