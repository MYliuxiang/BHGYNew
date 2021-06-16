//
//  SearchVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "SearchVC.h"
#import "HomeCell.h"

@interface SearchVC ()<UISearchBarDelegate>
@property(nonatomic,strong)UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,copy) NSString *keyword;

@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataList = [NSMutableArray array];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(40, Height_StatusBar + 6, kScreenWidth - 80, 30)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"请输入昵称/职业进行搜索";
    self.searchBar.showsCancelButton = NO;
    self.searchBar.layer.cornerRadius = 15;
    self.searchBar.layer.masksToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIOffset offset = {0,0};
    self.searchBar.searchTextPositionAdjustment = offset;
    UITextField *searchTextField;
    if(@available(iOS 13.0, *)){
        
        searchTextField  = self.searchBar.searchTextField;
        
    }else{
        searchTextField = [_searchBar valueForKey:@"_searchField"];
    }
    
    
    searchTextField.font = [UIFont systemFontOfSize:14];
    searchTextField.backgroundColor = [MyColor colorWithHexString:@"#F4F6FB"];
    searchTextField.textColor = Color_6;
    
    
    [self.searchBar setImage:[UIImage new] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [self.searchBar setImage:[UIImage new] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    [self.searchBar setPositionAdjustment:UIOffsetMake(-5, 0) forSearchBarIcon:UISearchBarIconSearch];
    self.searchBar.backgroundImage = [UIImage new];
    self.searchBar.backgroundColor = [MyColor colorWithHexString:@"#F4F6FB"];
    [self.searchBar resignFirstResponder];
    
    [self.customNavBar addSubview:self.searchBar];
    [self creatCollection];
    
    self.collectionView.mj_header = [LxResfreshHeader headerWithRefreshingBlock:^{
          self.pageNum = 1;
          [self loadData];
      }];
      
      self.collectionView.mj_footer = [LxRefreshFooter footerWithRefreshingBlock:^{
          [self loadData];
          
      }];
      
      
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
    entity.parameters = @{@"online":self.online,@"pageNum":@(self.pageNum),@"pageSize":@(PageSize),@"sex":self.sex,@"type":typeStr,@"cities":self.cities,@"keyword":self.keyword};
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
        [weakSelf.collectionView reloadData];
        
    };
    return cell;
    
}





- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDetailVC *vc = [[HomeDetailVC alloc] init];
       vc.model = self.dataList[indexPath.row];
       [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        return NO;
    }
//    /***  每搜索一次   就会存放一次到历史记录，但不存重复的*/
//    if ([self.searchArray containsObject:[NSDictionary dictionaryWithObject:textField.text forKey:@"content_name"]]) {
//        return YES;
//    }
//    [self reloadData:textField.text];
    return YES;
}
#pragma mark - UISearchBarDelegate -
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
   
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
   
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
   
//    if (searchBar.text == nil || [searchBar.text length] <= 0) {
//        _collectionView.hidden = NO;
//        _tableView.hidden = YES;
//        [self.view bringSubviewToFront:_collectionView];
//    } else {
//
//
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

        NSString *handleStr =  [searchText stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (handleStr.length == 0) {
            searchBar.text = handleStr;
            return;
        }
//        _collectionView.hidden = YES;
//        [self.view bringSubviewToFront:_tableView];
    self.keyword = handleStr;
    [self performSelector:@selector(searchAC) withObject:nil afterDelay:1.f];

    
    
//        [self searchWith:handleStr];
//
//
//
//    }
    
    
}

- (void)searchAC{
    [self.collectionView.mj_header beginRefreshing];

}





@end
