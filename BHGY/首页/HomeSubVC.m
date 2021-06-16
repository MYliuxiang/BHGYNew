//
//  HomeSubVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/6.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "HomeSubVC.h"
#import "HomeCell.h"
#import "HomeDetailVC.h"

@interface HomeSubVC ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) NSMutableArray *dataList;




@end

@implementation HomeSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataList = [NSMutableArray array];
    self.customNavBar.hidden = YES;
    [self creatCollection];
    
    __weak typeof(self) weakSelf = self;
    [self xw_addNotificationForName:HomeLoadNotice block:^(NSNotification * _Nonnull notification) {
        NSDictionary *userInfo = notification.userInfo;
        weakSelf.sex = userInfo[@"sex"];
        weakSelf.online = userInfo[@"online"];
        weakSelf.cities = userInfo[@"cities"];
        [weakSelf.collectionView.mj_header beginRefreshing];
        
    }];
    
    self.collectionView.mj_header = [LxResfreshHeader headerWithRefreshingBlock:^{
        self.pageNum = 1;
        [self loadData];
    }];
    
    self.collectionView.mj_footer = [LxRefreshFooter footerWithRefreshingBlock:^{
        [self loadData];
        
    }];
    
    [self.collectionView.mj_header beginRefreshing];
    

}

- (void)loadData{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userInfo_find];
    entity.needCache = NO;
    NSString *typeStr;
    if (self.index == 0) {
        typeStr = @"0";
    }else if (self.index == 1){
        typeStr = @"2";

    }else{
        typeStr = @"3";
    }
    if ([self.cities isEqualToString:@"不限地区"]) {
        self.cities = @"";
    }
    entity.parameters = @{@"online":self.online,@"pageNum":@(self.pageNum),@"pageSize":@(PageSize),@"sex":self.sex,@"type":typeStr,@"cities":self.cities};
    self.collectionView.ly_emptyView = self.nodataView;
    [self.collectionView ly_startLoading];

    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            
            NSArray *models = [HomeModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"content"]];
            if (self.pageNum == 1) {
                [self.dataList removeAllObjects];
            }
               
            [self.dataList addObjectsFromArray:models];
            [self.collectionView reloadData];

            self.pageNum++;
            
            if ([result[@"data"][@"last"] boolValue]) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.collectionView.mj_footer endRefreshing];
            }
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView ly_endLoading];
          
        }else{
            [self.collectionView.mj_footer endRefreshing];
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView ly_endLoading];

        }
        
    } failureBlock:^(NSError *error) {
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView ly_endLoading];

    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}

- (void)creatCollection
{
    
    self.layout.itemSize = CGSizeMake((kScreenWidth - 30 )/ 2.0, (kScreenWidth - 30 ) / 2.0 / 172 * 165 + 84 );
    self.layout.minimumLineSpacing = 10;
    self.layout.minimumInteritemSpacing = 10;
    self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellWithReuseIdentifier:@"HomeCellID"];
    
    
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCellID" forIndexPath:indexPath];
    
    cell.model = self.dataList[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    cell.blackNameBlock = ^{
        [weakSelf.dataList removeObjectAtIndex:indexPath.row];
        [weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        
    };
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

//   BaseViewController *vc = [[BaseViewController alloc] init];
//    vc.modalPresentationStyle = UIModalPresentationFullScreen;
//    vc.modalInPopover = YES;
//    if (@available(iOS 13.0, *)) {
//        vc.modalInPresentation = YES;
//    } else {
//        // Fallback on earlier versions
//    }
//    [self.navigationController presentViewController:vc animated:YES completion:nil];


    HomeDetailVC *vc = [[HomeDetailVC alloc] init];
    vc.model = self.dataList[indexPath.row];
    __weak typeof(self) weakSelf = self;

    vc.blackBlock = ^(HomeModel * _Nonnull model) {
        [weakSelf.dataList removeObject:model];
        [weakSelf.collectionView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

- (void)listDidAppear {
    
}

- (void)listDidDisappear {
    
}



@end
