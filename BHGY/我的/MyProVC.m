//
//  MyProVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/13.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "MyProVC.h"

@interface MyProVC ()
@property (weak, nonatomic) IBOutlet UITableView *tablView;
@property(nonatomic,strong) NSMutableArray *dataList;

@end

@implementation MyProVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.hidden = YES;

    
    self.tablView.mj_header = [LxResfreshHeader headerWithRefreshingBlock:^{
              self.pageNum = 1;
              [self loadData];
          }];
          
          self.tablView.mj_footer = [LxRefreshFooter footerWithRefreshingBlock:^{
              [self loadData];
              
          }];
          
          [self.tablView.mj_header beginRefreshing];

}

- (void)loadData{
    
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_dynamic_findMine];
    entity.needCache = NO;
        
    entity.parameters = @{@"pageNum":@(self.pageNum),@"pageSize":@(PageSize),@"type":@"0"};
    self.tablView.ly_emptyView = self.nodataView;
    [self.tablView ly_startLoading];
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            
            NSArray *models = [DynamicModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"content"]];
            if (self.pageNum == 1) {
                [self.dataList removeAllObjects];
            }
            
            [self.dataList addObjectsFromArray:models];
            [self.tablView reloadData];
            
            self.pageNum++;
            
            if ([result[@"data"][@"last"] boolValue]) {
                [self.tablView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tablView.mj_footer endRefreshing];
            }
            [self.tablView.mj_header endRefreshing];
            [self.tablView ly_endLoading];
            
        }else{
            [self.tablView.mj_footer endRefreshing];
            [self.tablView.mj_header endRefreshing];
            [self.tablView ly_endLoading];
            
        }
        
    } failureBlock:^(NSError *error) {
        [self.tablView.mj_footer endRefreshing];
        [self.tablView.mj_header endRefreshing];
        [self.tablView ly_endLoading];
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
   
    
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

- (void)listDidAppear {
    
}

- (void)listDidDisappear {
    
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    MyProCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyProCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.model = self.dataList[indexPath.section];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.tablView cellHeightForIndexPath:indexPath model:self.dataList[indexPath.section] keyPath:@"model" cellClass:[MyProCell class] contentViewWidth:kScreenWidth];

//    return [self.tableView cellHeightForIndexPath:indexPath cellClass:[DynamicCell class] cellContentViewWidth:kScreenWidth cellDataSetting:^(UITableViewCell * _Nonnull cell) {
//
//        DynamicCell *myCell = (DynamicCell *)cell;
//        myCell.model = self.dataList[indexPath.section];
//
//    }];
    
//    return [DynamicCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
    
//    return [self.tablView cellHeightForIndexPath:indexPath cellContentViewWidth:kScreenWidth tableView:self.tablView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailDynamicVC *vc = [[DetailDynamicVC alloc] init];
    vc.model = self.dataList[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
//
}




@end
