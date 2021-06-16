//
//  PerfectVC.m
//  BHGY
//
//  Created by 李立 on 2020/7/18.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "PerfectVC.h"

@interface PerfectVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong) UIImage *iconImage;
@end

@implementation PerfectVC

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
    UIView *topbjview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 194)];
    topbjview.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
    
    //头像
    self.iconimageview = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-60)/2,Height_StatusBar+53, 60, 60)];
    self.iconimageview.image = [UIImage imageNamed:@"默认头像"];
    self.iconimageview.userInteractionEnabled = YES;
    [topbjview addSubview:self.iconimageview];
    UITapGestureRecognizer *icontap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(icontapaciton)];
    [self.iconimageview addGestureRecognizer:icontap];
    //点击上传头像
    UILabel *sclabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.iconimageview.bottom+8, kScreenWidth, 16.5)];
    sclabel.textColor = [UIColor whiteColor];
    sclabel.font = [UIFont systemFontOfSize:12];
    sclabel.textAlignment = NSTextAlignmentCenter;
    sclabel.text = @"点击上传头像";
    [topbjview addSubview:sclabel];
    
    //创建表视图
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+kTopBarSafeHeight+kBottomSafeHeight+kNavBarHeight) style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.tableHeaderView = topbjview;
    [self.view addSubview:self.tableView];
    
    UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 500)];
    footview.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = footview;
    
    //返回按钮
    UIButton *fanhuibutton = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhuibutton.frame = CGRectMake(12.5, Height_StatusBar+3.5, 30, 30);
    [fanhuibutton setImage:[UIImage imageNamed:@"模态返回按钮"] forState:UIControlStateNormal];
    [fanhuibutton addTarget:self action:@selector(fanhuibuttonaciton) forControlEvents:UIControlEventTouchUpInside];
    [topbjview addSubview:fanhuibutton];
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0,Height_StatusBar+8 , kScreenWidth, 22.5)];
    titlelabel.font = [UIFont systemFontOfSize:16];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.text = @"完善资料";
    [topbjview addSubview:titlelabel];
    
    //提交按钮
    UIButton *updatabutton = [UIButton buttonWithType:UIButtonTypeCustom];
    updatabutton.frame = CGRectMake(0, kScreenHeight-50, kScreenWidth, 40);
    updatabutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
    [updatabutton setTitle:@"提交" forState:UIControlStateNormal];
    [updatabutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    updatabutton.titleLabel.font = [UIFont systemFontOfSize:15];
    [updatabutton addTarget:self action:@selector(uploadAC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updatabutton];
    
    
    
}

- (void)uploadAC:(UIButton *)btn{
    
    if (self.iconImage == nil) {
         [MBProgressHUD showError:@"请上传头像" toView:lxWindow];
         return;
    }
    if (self.niketextfield.text.length == 0) {
        [MBProgressHUD showError:@"请输入昵称" toView:lxWindow];
        return;
    }
    if (self.citytextfield.text.length == 0) {
        [MBProgressHUD showError:@"请选择常驻城市" toView:lxWindow];
        return;
    }
    if (self.birthdaytextfield.text.length == 0) {
        [MBProgressHUD showError:@"请选择生日" toView:lxWindow];
        return;
    }
    if (self.jobtextfield.text.length == 0) {
        [MBProgressHUD showError:@"请选择职业" toView:lxWindow];
        return;
    }
    if (self.heighttextfield.text.length == 0) {
        [MBProgressHUD showError:@"请选择身高" toView:lxWindow];
        return;
    }
    if (self.weighttextfield.text.length == 0) {
        [MBProgressHUD showError:@"请选择体重" toView:lxWindow];
        return;
    }
    if (self.introducetextfield.text.length == 0) {
        [MBProgressHUD showError:@"请输入个人介绍" toView:lxWindow];
        return;
    }
    
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userInfo_updateInfo];
    entity.needCache = NO;
    entity.parameters = @{@"birthday":self.birthdaytextfield.text,@"cities":self.citytextfield.text,@"height":[self.heighttextfield.text substringToIndex:self.weighttextfield.text.length - 2],@"hobbies":self.liketextfield.text,@"memo":self.introducetextfield.text,@"nickName":self.niketextfield.text,@"profession":self.jobtextfield.text,@"weight":[self.weighttextfield.text substringToIndex:self.weighttextfield.text.length - 2]};
        
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            //更新成功
            LoginModel *model = [LoginModel mj_objectWithKeyValues:result[@"data"]];
            //设置网络请求头
            NSString *user_token = [NSString stringWithFormat:@"%@",[LoginManger sharedManager].currentLoginModel.token];
            NSDictionary *headerdic = @{@"user_token":user_token};
            [BANetManager sharedBANetManager].httpHeaderFieldDictionary = headerdic;
            
            [[RCIM sharedRCIM] connectWithToken:model.rongCloudTOken
                                       dbOpened:^(RCDBErrorCode code) {
                //消息数据库打开，可以进入到主页面
                dispatch_async(dispatch_get_main_queue(), ^{
                    [LoginManger sharedManager].currentLoginModel = model;
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
        
    } failureBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 5;
    }else{
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
    cell.textLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    //线条
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(0, cell.height-0.5, kScreenWidth, 0.5)];
    xtview.backgroundColor = [UIColor colorWithHexString:@"#D8D8D8"];
    //    xtview.hidden = YES;
    [cell addSubview:xtview];
    
    //创建textfiled
    UITextField *abextextfield = [[UITextField alloc]initWithFrame:CGRectMake(91, 15, kScreenWidth-101, 18.5)];
    abextextfield.font = [UIFont systemFontOfSize:13];
    abextextfield.delegate = self;
    abextextfield.textColor = [UIColor colorWithHexString:@"#333333"];
    [cell addSubview:abextextfield];
    
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            cell.textLabel.text = @"昵称";
            abextextfield.placeholder = @"请填写";
            self.niketextfield = abextextfield;
        }else if (indexPath.row ==1){
            cell.textLabel.text = @"常驻城市";
            abextextfield.placeholder = @"可以写多个";
            self.citytextfield = abextextfield;
        }else if (indexPath.row ==2){
            cell.textLabel.text = @"生日";
            abextextfield.placeholder = @"请选择";
            abextextfield.userInteractionEnabled = YES;
            self.birthdaytextfield = abextextfield;
        }else if (indexPath.row ==3){
            cell.textLabel.text = @"职业";
            abextextfield.placeholder = @"请选择";
            self.jobtextfield = abextextfield;
        }else if (indexPath.row ==4){
            cell.textLabel.text = @"日常爱好";
            abextextfield.placeholder = @"可以多选";
            self.liketextfield = abextextfield;
            xtview.hidden = YES;
        }
    }else if (indexPath.section ==1){
        if (indexPath.row ==0) {
            cell.textLabel.text = @"身高";
            abextextfield.placeholder = @"请选择";
            self.heighttextfield = abextextfield;
        }else if (indexPath.row ==1){
            cell.textLabel.text = @"体重";
            abextextfield.placeholder = @"请选择";
            self.weighttextfield = abextextfield;
        }else if (indexPath.row ==2){
            cell.textLabel.text = @"个人介绍";
            abextextfield.placeholder = @"介绍一下我自己";
            self.introducetextfield = abextextfield;
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.5;
}
//组视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }else{
        return 37.5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headview = [[UIView alloc]init];
    headview.backgroundColor = [UIColor colorWithHexString:@"#EFF2F4"];
    //组视图label
    UILabel *healabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 11, kScreenWidth-40, 18.5)];
    healabel.font = [UIFont systemFontOfSize:13];
    healabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [headview addSubview:healabel];
    
    if(section ==1){
        healabel.text = @"更多信息（选填）";
    }
    return headview;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row ==1) {
            
            
            
            
        }else if (indexPath.row ==2){
            
        }else if (indexPath.row ==3){
            //职业
        }else if (indexPath.row ==4){
            //日常爱好
        }
    }else if (indexPath.section ==1){
        if (indexPath.row ==0) {
            //身高
            
        }else if (indexPath.row ==1){
            //体重
        }
    }
    
}

//返回按钮
-(void)fanhuibuttonaciton{
    [self.navigationController popViewControllerAnimated:YES];
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
               self.iconimageview.image = self.iconImage;
           }
           
       } failureBlock:^(NSError *error) {
           
       } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
           
       }];
}



//开始编辑的时候判断是否可以编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    //生日选择
    if (textField ==_birthdaytextfield) {
        [self boriedaction];
        return NO;
    }
    
    //身高选择
    if (textField ==_heighttextfield ) {
        [self selectheigt];
        return NO;
    }
    //体重
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
    
    if (textField == _citytextfield || textField ==_jobtextfield || textField == _liketextfield) {
        NSLog(@"这里返回为NO。则为禁止编辑");
        if (textField == _citytextfield){
            //常驻城市
            [self.navigationController pushViewController:self.sVC animated:YES];
        }
        if (textField == _liketextfield) {
            
            BADataEntity *entity = [BADataEntity new];
            entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_hobby_findAll];
            entity.needCache = YES;
            entity.parameters = nil;
            
            [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
            [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
                NSDictionary *result = response;
                if ([result[@"code"] intValue] == 0) {
                    NSArray *mya = result[@"data"];
                    NSMutableArray *lary = [NSMutableArray array];
                    for(int i =0;i < mya.count;i++){
                        NSDictionary *sdic = mya[i];
                        [lary addObject:sdic[@"name"]];
                    }
                    
                    NSArray *array;
                    if (self.liketextfield.text.length != 0) {
                        array = [self.liketextfield.text componentsSeparatedByString:@","];
                    }else{
                        array = nil;
                    }
                    
                    RLikeAlert *alert = [[RLikeAlert alloc] initWithContents:lary withDoneList:array];
                    __weak typeof(self) weakSelf = self;
                    
                    alert.rlikeBlock = ^(NSArray * _Nonnull rlikes) {
                        NSMutableString *str = [[NSMutableString alloc] init];
                        
                        for (int i = 0; i < rlikes.count; i++) {
                            [str appendString:rlikes[i]];
                            if (i != rlikes.count - 1) {
                                [str appendString:@","];
                            }
                        }
                        weakSelf.liketextfield.text = str;
                    };
                    [alert show];
                    
                }
                
            } failureBlock:^(NSError *error) {
                
            } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            }];
            
            
   
        }
        if (textField == _jobtextfield){
            //职业
            [self.navigationController pushViewController:self.jobVC animated:YES];
        }
        
        
        return NO;
    }
    
    return YES;
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
           
            weakSelf.citytextfield.text = str;
        };
        
    }
    return _sVC;
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
        self.birthdaytextfield.text = selectValue;
    }];
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
        self.heighttextfield.text = [NSString stringWithFormat:@"%@", selectValue];
    } Style:CGXStringPickerViewStylHeight];
}



@end
