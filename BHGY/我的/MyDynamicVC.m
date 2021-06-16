//
//  MyDynamicVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/13.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "MyDynamicVC.h"

@interface MyDynamicVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataList;

@end

@implementation MyDynamicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.hidden = YES;
    self.dataList = [NSMutableArray array];
   
    self.tableView.mj_header = [LxResfreshHeader headerWithRefreshingBlock:^{
           self.pageNum = 1;
           [self loadData];
       }];
       
       self.tableView.mj_footer = [LxRefreshFooter footerWithRefreshingBlock:^{
           [self loadData];
           
       }];
       
       [self.tableView.mj_header beginRefreshing];
       

}

- (void)loadData{
    
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_dynamic_findMine];
    entity.needCache = NO;
        
    entity.parameters = @{@"pageNum":@(self.pageNum),@"pageSize":@(PageSize),@"type":@"0"};
    self.tableView.ly_emptyView = self.nodataView;
    [self.tableView ly_startLoading];
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            
            NSArray *models = [DynamicModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"content"]];
            if (self.pageNum == 1) {
                [self.dataList removeAllObjects];
            }
            
            [self.dataList addObjectsFromArray:models];
            [self.tableView reloadData];
            
            self.pageNum++;
            
            if ([result[@"data"][@"last"] boolValue]) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            [self.tableView.mj_header endRefreshing];
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
    DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DynamicCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.model = self.dataList[indexPath.section];
    cell.menuB.hidden = YES;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.tableView cellHeightForIndexPath:indexPath model:self.dataList[indexPath.section] keyPath:@"model" cellClass:[DynamicCell class] contentViewWidth:kScreenWidth];

//    return [self.tableView cellHeightForIndexPath:indexPath cellClass:[DynamicCell class] cellContentViewWidth:kScreenWidth cellDataSetting:^(UITableViewCell * _Nonnull cell) {
//
//        DynamicCell *myCell = (DynamicCell *)cell;
//        myCell.model = self.dataList[indexPath.section];
//
//    }];
    
//    return [DynamicCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
    
    return [self.tableView cellHeightForIndexPath:indexPath cellContentViewWidth:kScreenWidth tableView:self.tableView];
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
