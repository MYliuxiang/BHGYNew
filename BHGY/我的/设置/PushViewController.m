//
//  PushViewController.m
//  BHGY
//
//  Created by 李立 on 2020/7/11.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"推送设置";
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
       return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      
    if (section == 0) {
        return 6;
    }else{
        return 2;
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
    UISwitch *lianmaiswitch = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth-70,7, 40, 24)];
    lianmaiswitch.on = NO;
   lianmaiswitch.tintColor = [UIColor colorWithHexString:@"#12C92E"]; //设置按钮处于关闭状态时边框的颜色
   lianmaiswitch.thumbTintColor = [UIColor colorWithHexString:@"#FFFFFF"];//设置开关的状态钮颜色
   lianmaiswitch.onTintColor = [UIColor colorWithHexString:@"#12C92E"]; //设置开关处于开启时的状态
   [cell addSubview:lianmaiswitch];
    [lianmaiswitch addTarget:self action:@selector(valueChangedMethod:) forControlEvents:(UIControlEventValueChanged)];
    //线条
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(0, cell.height-0.5, kScreenWidth, 0.5)];
    xtview.backgroundColor = [UIColor colorWithHexString:@"#D8D8D8"];
//    xtview.hidden = YES;
    [cell addSubview:xtview];
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            cell.textLabel.text =@"私聊消息通知";
            lianmaiswitch.tag = 50;
        }else if (indexPath.row ==1){
            cell.textLabel.text =@"广播报名通知";
             lianmaiswitch.tag = 51;
        }else if (indexPath.row ==2){
            cell.textLabel.text =@"新点赞提醒";
             lianmaiswitch.tag = 52;
        }else if (indexPath.row ==3){
            cell.textLabel.text =@"新广播提醒";
             lianmaiswitch.tag = 53;
        }else if (indexPath.row ==4){
            cell.textLabel.text =@"用户通过了我的查看请求";
             lianmaiswitch.tag = 54;
        }else if (indexPath.row ==5){
            cell.textLabel.text =@"邀请码申请成功";
             lianmaiswitch.tag = 55;
        }
    }else if (indexPath.section ==1){
        if (indexPath.row ==0) {
            cell.textLabel.text =@"声音";
             lianmaiswitch.tag = 56;
        }else if (indexPath.row ==1){
            cell.textLabel.text =@"震动";
             lianmaiswitch.tag = 57;
        }
    }
   
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 44;
}
//组视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 37;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headview = [[UIView alloc]init];
    
    //组视图label
    UILabel *healabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 11, kScreenWidth-40, 18.5)];
    healabel.font = [UIFont systemFontOfSize:13];
    healabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [headview addSubview:healabel];
    
    if (section ==0) {
        healabel.text = @"面具公园未打开时";
    }else{
       healabel.text = @"通知方式";
    }
    
    return headview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}



-(void)valueChangedMethod:(UISwitch *)on{
    if (on.tag ==50) {
        //私聊消息通知
    }else if (on.tag ==51){
      //广播报名通知
    }else if (on.tag ==52){
      //新点赞提醒
    }else if (on.tag ==53){
      //新广播提醒
    }else if (on.tag ==54){
      //用户通过了我的查看请求
    }else if (on.tag ==55){
      //邀请码申请成功
    }else if (on.tag ==56){
      //声音
    }else if (on.tag ==57){
      //震动
    }
}
@end
