//
//  PersonaldataViewController.m
//  BHGY
//
//  Created by 李立 on 2020/7/12.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "PersonaldataViewController.h"
@interface PersonaldataViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation PersonaldataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.customNavBar.title = @"编辑资料";
    [self setui];
    
      [self.customNavBar wr_setRightButtonWithTitle:@"保存" titleColor:[UIColor whiteColor]];
      
      //设置按钮点击
      [self.customNavBar setOnClickRightButton:^{
      
           if (self.nikenametextfield.text.length == 0) {
               [MBProgressHUD showError:@"请输入昵称" toView:lxWindow];
               return;
           }
           if (self.citetextfield.text.length == 0) {
               [MBProgressHUD showError:@"请选择常驻城市" toView:lxWindow];
               return;
           }
           if (self.biredtextfield.text.length == 0) {
               [MBProgressHUD showError:@"请选择生日" toView:lxWindow];
               return;
           }
           if (self.jobtextfield.text.length == 0) {
               [MBProgressHUD showError:@"请选择职业" toView:lxWindow];
               return;
           }
           if (self.hegittextfield.text.length == 0) {
               [MBProgressHUD showError:@"请选择身高" toView:lxWindow];
               return;
           }
           if (self.weighttextfield.text.length == 0) {
               [MBProgressHUD showError:@"请选择体重" toView:lxWindow];
               return;
           }
           if (self.infotextfield.text.length == 0) {
               [MBProgressHUD showError:@"请输入个人介绍" toView:lxWindow];
               return;
           }
           
          if (self.liketextfield.text.length ==0) {
               [MBProgressHUD showError:@"请输入个人爱好" toView:lxWindow];
               return;
          }
           
           BADataEntity *entity = [BADataEntity new];
           entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userInfo_updateInfo];
           entity.needCache = NO;
           entity.parameters = @{@"birthday":self.biredtextfield.text,@"cities":self.citetextfield.text,@"height":[self.hegittextfield.text substringToIndex:self.weighttextfield.text.length - 2],@"hobbies":self.liketextfield.text,@"memo":self.infotextfield.text,@"nickName":self.nikenametextfield.text,@"profession":self.jobtextfield.text,@"weight":[self.weighttextfield.text substringToIndex:self.weighttextfield.text.length - 2]};
               
           [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
           [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
               NSDictionary *result = response;
               if ([result[@"code"] intValue] == 0) {
                   //更新成功
                   LoginModel *model = [LoginModel mj_objectWithKeyValues:result[@"data"]];
                   self.model.birthday = model.birthday;
                   self.model.cityList = model.cityList;
                   self.model.height = model.height;
                   self.model.weight = model.weight;
                   self.model.hobbyList = model.hobbyList;
                   self.model.memo = model.memo;
                   self.model.nickName = model.nickName;
                   self.model.profession = model.profession;
                   [LoginManger sharedManager].currentLoginModel = self.model;
                   [MBProgressHUD showSuccess:@"保存成功" toView:self.view];
               }
               
           } failureBlock:^(NSError *error) {
               
           } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
               
           }];
      }];
   
}
//初始化ui
-(void)setui{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar+21) style:UITableViewStyleGrouped];
       self.tableView.showsVerticalScrollIndicator = NO;
       self.tableView.delegate = self;
       self.tableView.dataSource = self;
       self.tableView.estimatedSectionFooterHeight = 0;
       self.tableView.estimatedSectionHeaderHeight = 0;
       self.tableView.backgroundColor = [UIColor colorWithHexString:@"#EFF2F4"];
       [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
       [self.view addSubview:self.tableView];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
       return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      
    if (section == 0) {
        return 7;
    }else if(section == 1){
        return 2;
    }else {
        return 3;
    }


    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
         UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] init];
        [cell setRestorationIdentifier:@"UITableViewCell"];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:13];
   
    //值
    UITextField *datatextfield = [[UITextField alloc]initWithFrame:CGRectMake(90, 11, 200, 18.5)];
    datatextfield.font = [UIFont systemFontOfSize:13];
    datatextfield.textColor = [UIColor colorWithHexString:@"#333333"];
    datatextfield.textAlignment = NSTextAlignmentLeft;
    datatextfield.placeholder = @"北京市/深圳市";
    datatextfield.delegate = self;
    [cell addSubview:datatextfield];
    //线条
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(0, cell.height-0.5, kScreenWidth, 0.5)];
    xtview.backgroundColor = [UIColor colorWithHexString:@"#D8D8D8"];
//    xtview.hidden = YES;
    [cell addSubview:xtview];
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 11, 90, 18.5)];
    titlelabel.font = [UIFont boldSystemFontOfSize:13];
    titlelabel.textColor = [UIColor colorWithHexString:@"#333333"];
    titlelabel.text = @"头像";
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:titlelabel];
            
       //头像
        xtview.frame = CGRectMake(0, 70-0.5, kScreenWidth, 0.5);
        datatextfield.hidden = YES;
            
        self.touxiangimageView = [[UIImageView alloc] init];
        self.touxiangimageView.frame = CGRectMake(90,8,54,54);
        KViewBorderRadius(self.touxiangimageView, 10, 0.5, [UIColor clearColor]);
        self.touxiangimageView.backgroundColor = [UIColor grayColor];
        self.touxiangimageView.contentMode = UIViewContentModeScaleToFill;
        self.touxiangimageView.layer.masksToBounds = YES;
        [self.touxiangimageView sd_setImageWithURL:[NSURL URLWithString:[HandleTool getImageUrlStr:self.model.avatar]]];
        [cell addSubview:self.touxiangimageView];
            //箭头
       UIImageView *jtimageview = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-23, 29.5, 6.5, 12)];
       jtimageview.image = [UIImage imageNamed:@"个人中心表视图箭头"];
       [cell addSubview:jtimageview];
       
     //更换头像
    UILabel *changicomlabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-151.5, 27, 120, 16.5)];
        changicomlabel.font = [UIFont systemFontOfSize:12];
        changicomlabel.textColor = [UIColor colorWithHexString:@"#999999"];
        changicomlabel.text = @"更换头像";
            changicomlabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:changicomlabel];
        }else if (indexPath.row ==1){
          cell.textLabel.text =@"昵称";
        self.nikenametextfield = datatextfield;
        self.nikenametextfield.text = self.model.nickName;
        UILabel *changicomlabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-141.5, 13.5, 120, 16.5)];
      changicomlabel.font = [UIFont systemFontOfSize:12];
      changicomlabel.textColor = [UIColor colorWithHexString:@"#999999"];
      changicomlabel.text = @"本月可改3次";
          changicomlabel.textAlignment = NSTextAlignmentRight;
      [cell addSubview:changicomlabel];
        }else if (indexPath.row ==2){
             cell.textLabel.text =@"常驻城市";
            self.citetextfield = datatextfield;
            NSString *citysring = [NSString new];
            for (int i = 0; i<self.model.cityList.count; i++) {
                NSString *abexcity = self.model.cityList[i];
                if (i==0) {
                citysring = abexcity;
                }else{
            citysring = [NSString stringWithFormat:@"%@/%@",citysring,abexcity];
                }
            }
            self.citetextfield.text = citysring;
        }else if (indexPath.row ==3){
           cell.textLabel.text =@"生日";
            self.biredtextfield = datatextfield;
            self.biredtextfield.text = self.model.birthday;
        }else if (indexPath.row ==4){
           cell.textLabel.text =@"职业";
            self.jobtextfield = datatextfield;
            self.jobtextfield.text = self.model.profession;
        }else if (indexPath.row ==5){
           cell.textLabel.text =@"日常爱好";
            self.liketextfield = datatextfield;
            NSString *likesring = [NSString new];
            for (int i = 0; i<self.model.hobbyList.count; i++) {
               NSString *abexcity = self.model.hobbyList[i];
               if (i==0) {
               likesring = abexcity;
               }else{
           likesring = [NSString stringWithFormat:@"%@/%@",likesring,abexcity];
               }
           }
         self.liketextfield.text = likesring;
        }else if (indexPath.row ==6){
           cell.textLabel.text =@"期望对象";
            self.dxtextfield = datatextfield;
            self.dxtextfield.text = @"期望对象";
        }
    }else if (indexPath.section ==1){
        if (indexPath.row ==0) {
            cell.textLabel.text =@"微信";
            self.wxtextfield = datatextfield;
            self.wxtextfield.placeholder = @"请输入您的微信号";
            self.wxtextfield.text = self.model.wechat;
       UILabel *changicomlabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-141.5, 13.5, 120, 16.5)];
          changicomlabel.font = [UIFont systemFontOfSize:12];
          changicomlabel.textColor = [UIColor colorWithHexString:@"#999999"];
          changicomlabel.text = @"本月可改3次";
              changicomlabel.textAlignment = NSTextAlignmentRight;
          [cell addSubview:changicomlabel];
        }else if (indexPath.row ==1){
            cell.textLabel.text =@"我的用户资料隐藏微信";
            datatextfield.hidden = YES;
    UISwitch *lianmaiswitch = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth-70,7, 40, 24)];
       lianmaiswitch.on = NO;
      lianmaiswitch.tintColor = [UIColor colorWithHexString:@"#12C92E"]; //设置按钮处于关闭状态时边框的颜色
      lianmaiswitch.thumbTintColor = [UIColor colorWithHexString:@"#FFFFFF"];//设置开关的状态钮颜色
      lianmaiswitch.onTintColor = [UIColor colorWithHexString:@"#12C92E"]; //设置开关处于开启时的状态
      [cell addSubview:lianmaiswitch];
       [lianmaiswitch addTarget:self action:@selector(valueChangedMethod:) forControlEvents:(UIControlEventValueChanged)];
        }
    }else{
        if (indexPath.row ==0) {
          cell.textLabel.text =@"身高";
            self.hegittextfield = datatextfield;
            self.hegittextfield.text = [NSString stringWithFormat:@"%dcm",self.model.height];
        }else if (indexPath.row ==1){
          cell.textLabel.text =@"体重";
            self.weighttextfield = datatextfield;
            self.weighttextfield.text = [NSString stringWithFormat:@"%dkg",self.model.weight];
        }else if (indexPath.row ==2){
            xtview.hidden = YES;
//            datalalbel.hidden = YES;
            datatextfield.text = @"59kg";
            self.infotextfield = datatextfield;
            self.infotextfield.text = self.model.memo;
      UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 11, 90, 18.5)];
         titlelabel.font = [UIFont boldSystemFontOfSize:13];
         titlelabel.textColor = [UIColor colorWithHexString:@"#333333"];
         titlelabel.text = @"个人介绍";
         titlelabel.textAlignment = NSTextAlignmentCenter;
         [cell addSubview:titlelabel];
            
        UILabel *changicomlabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-141.5, 56.5, 120, 16.5)];
          changicomlabel.font = [UIFont systemFontOfSize:12];
          changicomlabel.textColor = [UIColor colorWithHexString:@"#999999"];
          changicomlabel.text = @"本月可改3次";
              changicomlabel.textAlignment = NSTextAlignmentRight;
          [cell addSubview:changicomlabel];
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            return 70;
        }
    }
    if (indexPath.section ==2) {
        if (indexPath.row ==2) {
            return 86;
        }
    }
        return 44;
}
//组视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section ==1) {
        return 52;
    }else{
    return 37;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headview = [[UIView alloc]init];
    
    //组视图label
    UILabel *healabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 11, kScreenWidth-40, 18.5)];
    healabel.font = [UIFont systemFontOfSize:13];
    healabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [headview addSubview:healabel];
    
    if (section ==0) {
        healabel.text = @"基本资料（必填)";
    }else if(section ==1){
        healabel.frame = CGRectMake(20, 8, kScreenWidth-40, 18.5);
       healabel.text = @"社交账号";
    UILabel *abxlabel = [[UILabel alloc]initWithFrame:CGRectMake(20, healabel.bottom+3, kScreenWidth-40, 14)];
       abxlabel.font = [UIFont systemFontOfSize:10];
       abxlabel.textColor = [UIColor colorWithHexString:@"#999999"];
        abxlabel.text = @"请填写真实账号，填写虚假账号/无效账号可";
       [headview addSubview:abxlabel];
    }else if(section ==2){
       healabel.text = @"社交账号";
    }
    
    return headview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section ==0 && indexPath.row ==0) {
        //点击头像
        [self icontapaciton];
    }
   
}
//上传头像
-(void)icontapaciton{
    TZImgePickHelper *helper = [[TZImgePickHelper alloc] initMaxCount:1];
    helper.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//        self.iconimageview.image = photos[0];
        [self uploadIcon:photos[0]];
        
        
        
    };
    [self presentViewController:helper animated:YES completion:nil];
}

- (void)uploadIcon:(UIImage *)image{
    
//    Url_userInfo_updateAvatar
    
    BAImageDataEntity *entity = [BAImageDataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainFileUrl,Url_UploadFile];
    entity.needCache = NO;
    entity.imageArray = @[image];
    entity.imageType = @"png";
    entity.imageScale = 0.7;
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_uploadImageWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            //
            [self updateAvator:result[@"data"] withImage:image];
            self.model.avatar = result[@"data"];
            [LoginManger sharedManager].currentLoginModel = self.model;

        }
    } failurBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (void)updateAvator:(NSString *)avatorId withImage:(UIImage *)image{
    
    BADataEntity *entity = [BADataEntity new];
       entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userInfo_updateAvatar];
       entity.needCache = NO;
       entity.parameters = @{@"avatar":avatorId};
           
       [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
       [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
           NSDictionary *result = response;
           if ([result[@"code"] intValue] == 0) {
               //更新成功
               self.iconImage = image;
               self.touxiangimageView.image = self.iconImage;
           }
           
       } failureBlock:^(NSError *error) {
           
       } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
           
       }];
}

//选择日常爱好
- (void)seletedHobby{
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_hobby_findAll];
    entity.needCache = YES;
    entity.parameters = nil;
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            NSArray *array = [ServerModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            NSMutableArray *marray = [NSMutableArray array];
            for (ServerModel *model in array) {
                [marray addObject:model.name];
            }
            //传已经选择的字符串
            NSString *str = @"";
            NSArray *sletes = [str componentsSeparatedByString:@","];
            ExpectationAlert *alert = [[ExpectationAlert alloc] initWithContents:marray seletes:sletes];
            alert.clickBlcok = ^(NSString * _Nonnull expectation) {
                //选择好的日常爱好
                self.liketextfield.text = expectation;
            };
            alert.titleLab.text = @"选择日常爱好";
            [alert show];
        }
        
    } failureBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}


//我的资料对用户隐藏
-(void)valueChangedMethod:(UISwitch *)on{
  
}

//开始编辑的时候判断是否可以编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    //生日选择
    if (textField ==_liketextfield) {
        [self seletedHobby];
      
        return NO;
    }
    
    //体重选择
    if (textField == _weighttextfield) {
          NSString *defaultSelValue = [[CGXPickerView showStringPickerDataSourceStyle:CGXStringPickerViewStylWeight] objectAtIndex:3];
              CGXPickerViewManager *manager = [[CGXPickerViewManager alloc] init];
              manager.pickerTitleSelectColor = Color_Theme;
              manager.rightBtnBorderWidth = 0;
              manager.rightBtnCornerRadius = 0;
              manager.leftBtnBorderWidth = 0;
              manager.leftBtnCornerRadius = 0;
              manager.rightBtnTitleColor = Color_Theme;
              manager.rightBtnBGColor = [UIColor clearColor];
              manager.leftBtnTitleColor = Color_Theme;
              manager.leftBtnBGColor = [UIColor clearColor];
              manager.leftBtnTitleSize = 14;
              manager.rightBtnTitleSize = 14;
              [CGXPickerView showStringPickerWithTitle:@"体重" DefaultSelValue:defaultSelValue IsAutoSelect:YES Manager:manager ResultBlock:^(id selectValue, id selectRow) {
                  NSLog(@"%@",selectValue); ;
                  self.weighttextfield.text = [NSString stringWithFormat:@"%@", selectValue];
              } Style:CGXStringPickerViewStylWeight];
        return NO;
    }
    
    //身高选择
    if (textField == self.hegittextfield) {
        [self selectheigt];
        return NO;
    }
    
    //生日选择
    if (textField == self.biredtextfield) {
        [self boriedaction];
        return NO;
    }
    
    if (textField == _jobtextfield){
           //职业
           [self.navigationController pushViewController:self.jobVC animated:YES];
        return NO;
       }
    if (textField == _citetextfield){
      //常驻城市
      [self.navigationController pushViewController:self.sVC animated:YES];
          }
    return YES;
}


//身高选择
-(void)selectheigt{
    
    NSString *defaultSelValue = [[CGXPickerView showStringPickerDataSourceStyle:CGXStringPickerViewStylHeight] objectAtIndex:3];
    CGXPickerViewManager *manager = [[CGXPickerViewManager alloc] init];
    manager.pickerTitleSelectColor = Color_Theme;
    manager.rightBtnBorderWidth = 0;
    manager.rightBtnCornerRadius = 0;
    manager.leftBtnBorderWidth = 0;
    manager.leftBtnCornerRadius = 0;
    manager.rightBtnTitleColor = Color_Theme;
    manager.rightBtnBGColor = [UIColor clearColor];
    manager.leftBtnTitleColor = Color_Theme;
    manager.leftBtnBGColor = [UIColor clearColor];
    manager.leftBtnTitleSize = 14;
    manager.rightBtnTitleSize = 14;
    
    [CGXPickerView showStringPickerWithTitle:@"身高" DefaultSelValue:defaultSelValue IsAutoSelect:YES Manager:manager ResultBlock:^(id selectValue, id selectRow) {
        NSLog(@"%@",selectValue); ;
        self.hegittextfield.text = [NSString stringWithFormat:@"%@", selectValue];
    } Style:CGXStringPickerViewStylHeight];
}


//生日选择
-(void)boriedaction {
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:now];
    
    CGXPickerViewManager *manager = [[CGXPickerViewManager alloc] init];
    manager.pickerTitleSelectColor = Color_Theme;
    manager.rightBtnBorderWidth = 0;
    manager.rightBtnCornerRadius = 0;
    manager.leftBtnBorderWidth = 0;
    manager.leftBtnCornerRadius = 0;
    manager.rightBtnTitleColor = Color_Theme;
    manager.rightBtnBGColor = [UIColor clearColor];
    manager.leftBtnTitleColor = Color_Theme;
    manager.leftBtnBGColor = [UIColor clearColor];
    manager.leftBtnTitleSize = 14;
    manager.rightBtnTitleSize = 14;
    
    [CGXPickerView showDatePickerWithTitle:@"出生年月" DateType:UIDatePickerModeDate DefaultSelValue:@"2019-06-26" MinDateStr:@"" MaxDateStr:nowStr IsAutoSelect:YES Manager:manager ResultBlock:^(NSString *selectValue) {
        self.biredtextfield.text = selectValue;
    }];
}


- (JobVC *)jobVC{
    if (_jobVC == nil) {
        _jobVC = [JobVC new];
        __weak typeof(self) weakSelf = self;

        _jobVC.jobBlock = ^(NSString * _Nonnull job) {
            weakSelf.jobtextfield.text = job;
        };
    }
    return _jobVC;
}

- (SeletedCityVC *)sVC{
    if (_sVC == nil) {
        _sVC = [[SeletedCityVC alloc] init];
        __weak typeof(self) weakSelf = self;

        _sVC.cityBlock = ^(NSArray * _Nonnull citys) {
            NSMutableString *str = [[NSMutableString alloc] init];
            
            for (int i = 0; i < citys.count; i++) {
                [str appendString:citys[i]];
                if (i != citys.count - 1) {
                    [str appendString:@","];
                }
            }
           
            weakSelf.citetextfield.text = str;
        };
        
    }
    return _sVC;
}
@end
