//
//  SubDynamicVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/8.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "SubDynamicVC.h"

@interface SubDynamicVC ()
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);


@end

@implementation SubDynamicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.hidden = YES;
    self.dataList = [NSMutableArray array];
   
    
}


#pragma mark - JXPagingViewListViewDelegate
- (UIView *)listView {
    return self.view;
}



- (UIScrollView *)listScrollView {
    return self.tableView;
}


- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
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
    __weak typeof(self) weakSelf = self;
    cell.blackNameBlock = ^{
      
        [weakSelf.dataList removeObjectAtIndex:indexPath.section];
        [weakSelf.tableView deleteSection:indexPath.section withRowAnimation:UITableViewRowAnimationLeft];


    };
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback ?: self.scrollCallback(scrollView);
}



@end
