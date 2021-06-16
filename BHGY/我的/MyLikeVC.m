//
//  MyLikeVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/12.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "MyLikeVC.h"
#import "HomeCell.h"

@interface MyLikeVC ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) NSMutableArray *dataList;

@end

@implementation MyLikeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"我喜欢的";
    self.dataList = [NSMutableArray array];
    [self creatCollection];
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
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userFavorite_list];
    entity.needCache = NO;
    entity.parameters = @{@"pageNum":@(self.pageNum),@"pageSize":@(PageSize)};
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
            self.pageNum++;
            
            if ([result[@"data"][@"last"] boolValue]) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.collectionView.mj_footer endRefreshing];
            }
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView reloadData];
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
        [weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        [weakSelf.dataList removeObjectAtIndex:indexPath.row];
        
    };
    
    cell.cancleBlock = ^{
        [weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        [weakSelf.dataList removeObjectAtIndex:indexPath.row];
        
    };
    return cell;
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15, 0, kScreenWidth - 30, 35);
        label.font = [UIFont systemFontOfSize:10];
        label.text = @"为保护用户隐私，已隐身的用户会被隐藏";
        label.textColor = Color_6;
        label.backgroundColor = [UIColor clearColor];
        UICollectionReusableView *view =   [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerID" forIndexPath:indexPath];

        [view addSubview:label];
        reusableview = view;
    }
    return reusableview;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDetailVC *vc = [[HomeDetailVC alloc] init];
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
