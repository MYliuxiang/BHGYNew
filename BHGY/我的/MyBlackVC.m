//
//  MyBlackVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/21.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "MyBlackVC.h"

@interface MyBlackVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataList;

@end

@implementation MyBlackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"黑名单";
    self.dataList = [NSMutableArray array];
    
    self.tableView.mj_header = [LxResfreshHeader headerWithRefreshingBlock:^{
           self.pageNum = 1;
           [self loadData];
       }];
       
    self.tableView.mj_footer = [LxRefreshFooter footerWithRefreshingBlock:^{
           [self loadData];
           
    }];
       
    [self.tableView.mj_header beginRefreshing];
    
//    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;

}




- (void)loadData{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_blacklist_list];
    entity.needCache = NO;
   
    entity.parameters = @{@"pageNum":@(self.pageNum),@"pageSize":@(PageSize)};
    self.tableView.ly_emptyView = self.nodataView;
    [self.tableView ly_startLoading];

    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            
            NSArray *models = [UserModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"content"]];
            if (self.pageNum == 1) {
                [self.dataList removeAllObjects];
            }
               
            [self.dataList addObjectsFromArray:models];
            self.pageNum++;
            
            if ([result[@"data"][@"last"] boolValue]) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            [self.tableView ly_endLoading];
                                    
          
        }else{
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
            [self.tableView ly_endLoading];

        }
        
    } failureBlock:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [self.tableView ly_endLoading];

        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
//    self.navigationController.fd_fullscreenPopGestureRecognizer.delegate = self;
//    [self xw_addObserverBlockForKeyPath:@"tableView.editing" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
//
//    }];
    
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 打印touch到的视图
    NSLog(@"%@", NSStringFromClass([touch.view class]));
   
    // 如果视图为UITableViewCellContentView（即点击tableViewCell），则不截获Touch事件
    if (self.editing) {
        return NO;
    }
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//        return NO;
//    }
    return  YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press{
    return YES;
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    MyBlackCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyBlackCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.model = self.dataList[indexPath.row];
    
    return cell;
    
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
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
 
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf = self;

    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"移除黑名单" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        
        BADataEntity *entity = [BADataEntity new];
                 entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_blacklist_remove];
                 entity.needCache = NO;
        UserModel *model = weakSelf.dataList[indexPath.row];
                 entity.parameters = @{@"userId":model.uid};
                 [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
                 [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
                     NSDictionary *result = response;
                     if ([result[@"code"] intValue] == 0) {
                         
                        [weakSelf.dataList removeObjectAtIndex:indexPath.row];
                         [weakSelf.tableView deleteRow:indexPath.row inSection:indexPath.section withRowAnimation:UITableViewRowAnimationLeft];
                         
                       
                     }
                     
                 } failureBlock:^(NSError *error) {
                    
                     
                 } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                     
                 }];
        
        
    }];
   
    deleteAction.backgroundColor = Color_Theme;
    return @[deleteAction];
}
 
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}

//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    NSLog(@"开始编辑");
//    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
//
//}
//
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath
//{
//   self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
//   NSLog(@"结束编辑");
//
//}









@end
