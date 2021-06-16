//
//  StepViewController.m
//  BHGY
//
//  Created by 李立 on 2020/7/9.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "StepViewController.h"
#import "ChangpasswordViewController.h"
#import "AddphoneViewController.h"
#import "PushViewController.h"
#import "PrivacysettingsViewController.h"
#import "WUGesturesUnlockViewController.h"
@interface StepViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation StepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"设置";
    [self setui];
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
       return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      
    if (section == 0) {
        return 2;
    }else if (section ==1){
        return 1;
    }else if (section ==2){
        return 2;
    }else if (section ==3){
        return 2;
    }else if (section ==4){
        return 3;
    }else{
        return 1;
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
    //箭头
    UIImageView *jtimageview = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-23, 15.6, 6.5, 12)];
    jtimageview.image = [UIImage imageNamed:@"个人中心表视图箭头"];
    [cell addSubview:jtimageview];
    
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            cell.textLabel.text = @"隐私设置";
        }else{
          cell.textLabel.text = @"允许有私聊权限的人对我发起连麦";
            jtimageview.hidden = YES;
        UISwitch *lianmaiswitch = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth-70,7, 40, 24)];
             lianmaiswitch.on = NO;
            lianmaiswitch.tintColor = [UIColor colorWithHexString:@"#12C92E"]; //设置按钮处于关闭状态时边框的颜色
            lianmaiswitch.thumbTintColor = [UIColor colorWithHexString:@"#FFFFFF"];//设置开关的状态钮颜色
            lianmaiswitch.onTintColor = [UIColor colorWithHexString:@"#12C92E"]; //设置开关处于开启时的状态
            [lianmaiswitch addTarget:self action:@selector(valueChangedMethod:) forControlEvents:(UIControlEventValueChanged)];
            [cell addSubview:lianmaiswitch];
        }
    }else if (indexPath.section ==1){
        cell.textLabel.text = @"新消息通知";
    }else if (indexPath.section ==2){
        if (indexPath.row ==0) {
           cell.textLabel.text = @"手机号码";
           
       }else{
         cell.textLabel.text = @"修改密码";
       }
    }else if (indexPath.section ==3){
        if (indexPath.row ==0) {
           cell.textLabel.text = @"清楚图片缓存";
             _sizsirng = [self readCacheSize];
           UILabel *huancunlabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-130.5, 13, 100, 16.5)];
            huancunlabel.font = [UIFont systemFontOfSize:12];
            huancunlabel.textColor = [UIColor colorWithHexString:@"#999999"];
            huancunlabel.textAlignment = NSTextAlignmentRight;
            huancunlabel.text = [NSString stringWithFormat:@"%0.2fM",_sizsirng];
            [cell addSubview:huancunlabel];
            
       }else{
         cell.textLabel.text = @"设置APP开锁图案";
       }
    }else if (indexPath.section ==4){
        if (indexPath.row ==0) {
           cell.textLabel.text = @"平台使用规范";
       }else if (indexPath.row ==1){
         cell.textLabel.text = @"用户使用协议";
       }else if (indexPath.row ==2){
         cell.textLabel.text = @"用户隐私政策";
       }
    }else{
        cell.textLabel.text = @"退出登录";
    }
   
   
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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
        if (indexPath.row ==0) {
            //隐私设置
    PrivacysettingsViewController *vc = [[PrivacysettingsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
            
        }
    }else if (indexPath.section ==1){
        //新消息通知
        PushViewController *vc = [[PushViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section ==2){
        if (indexPath.row ==0) {
            //手机号码
            AddphoneViewController *vc = [[AddphoneViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //修改密码
            ChangpasswordViewController *vc = [[ChangpasswordViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section ==3){
        if (indexPath.row ==0) {
            //清除图片缓存
            [self cleanhc];
        }else{
            //设置app开锁图案
            WUGesturesUnlockViewController *vc = [[WUGesturesUnlockViewController alloc] initWithUnlockType:WUUnlockTypeCreatePwd];
            vc.modalPresentationStyle = 0;
             [self presentViewController:vc animated:YES completion:nil];
        }
    }else if (indexPath.section ==4){
        if (indexPath.row ==0) {
            //平台使用规范
        }else if (indexPath.row ==1){
            //平台使用协议
        }else if (indexPath.row ==2){
            //用户隐私政策
        }
    }else {
          //退出登录
        [self outloging];
    }
   
}

//清除缓存
-(void)cleanhc{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"是否清除缓存"
                                                                         message:@"清除缓存后所有图片文字信息要重新从网络获取"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
          
          UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
              
              //清除数据库表

              [self clearFile];
              [self.tableView reloadData];
              
          }];
          UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action) {
                                                                   //响应事件
                                NSLog(@"action = %@", action);
                                                                   
                        }];
          [alert addAction:defaultAction];
          [alert addAction:cancelAction];
          [self presentViewController:alert animated:YES completion:nil];
}


//1. 获取缓存文件的大小
-( float )readCacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [ self folderSizeAtPath :cachePath];
}


//由于缓存文件存在沙箱中，我们可以通过NSFileManager API来实现对缓存文件大小的计算。
// 遍历文件夹获得文件夹大小，返回多少 M
- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    
    return folderSize/( 1024.0 * 1024.0);
    
}



// 计算 单个文件的大小
- ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}



//2. 清除缓存
- (void)clearFile
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    //NSLog ( @"cachpath = %@" , cachePath);
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
    
    //读取缓存大小
    _sizsirng = [self readCacheSize] *1024;
    //    self.cacheSize.text = [NSString stringWithFormat:@"%.2fKB",cacheSize];
    
}

//允许有私聊权限的人对我发起连麦
-(void)valueChangedMethod:(UISwitch *)on{
    
}



//退出登录
-(void)outloging{
    
//    [LoginManger sharedManager].currentLoginModel = nil;
//    [HandleTool switchLgoinVC];
//    [[RCIM sharedRCIM] logout];
//
//    return;
     //调用退出接口
    BADataEntity *entity = [BADataEntity new];
       entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_logout];
       entity.needCache = NO;
//        entity.parameters = @{@"mobile":_iphoneTextField.text,@"password":_passwordTextField.text};
       [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
       [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
           NSDictionary *result = response;
           if ([result[@"code"] intValue] == 0) {
            //退出登录
            [[RCIM sharedRCIM] logout];
             [LoginManger sharedManager].currentLoginModel = nil;
             [HandleTool switchLgoinVC];
               
               
               
           }
       } failureBlock:^(NSError *error) {
       } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
           
       }];
    
}
@end
