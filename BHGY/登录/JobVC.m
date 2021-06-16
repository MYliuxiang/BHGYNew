//
//  JobVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/20.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "JobVC.h"

@interface JobVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView2;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (strong,nonatomic) NSMutableArray *dataList;
@property (nonatomic,assign) NSInteger index;

@end

@implementation JobVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"选择职业";
    self.dataList = [NSMutableArray array];
    [self loadData];
      
}

- (void)loadData{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_profession_findAll];
    entity.needCache = YES;
    entity.parameters = nil;
    
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            self.dataList = [JobModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            [self.tableView1 reloadData];
            [self.tableView2 reloadData];
            [self.tableView1 selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
        
    } failureBlock:^(NSError *error) {
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableView1 == tableView) {
        return self.dataList.count;
    }
    if (self.dataList.count == 0) {
        return 0;
    }
    JobModel *model = self.dataList[self.index];
    if (model == nil) {
        return 0;
    }
    return model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableView1) {
        static NSString *identifire = @"cellID";
        MenumCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MenumCell" owner:nil options:nil] lastObject];
            
        }
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];

        cell.selectedBackgroundView.backgroundColor = Color_Theme;
        JobModel *model = self.dataList[indexPath.row];
        cell.titleLab.text = model.name;
       
        return cell;
        
    }else{
        static NSString *identifire = @"cellID1";
        SubMenumCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SubMenumCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        JobModel *model = self.dataList[self.index];
        JobModel *smodel = model.items[indexPath.row];
        cell.titleLab.text = smodel.name;
        
        
        return cell;
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView1) {
        self.index = indexPath.row;
        [self.tableView2 reloadData];
      
        
        return;
    }
    
    if (self.jobBlock) {
        JobModel *model = self.dataList[self.index];
        JobModel *smodel = model.items[indexPath.row];
        self.jobBlock(smodel.name);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
   
    
}





@end
