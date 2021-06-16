//
//  SeletedCityVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/13.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "SeletedCityVC.h"

@interface SeletedCityVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (strong,nonatomic) NSMutableArray *dataList;
@property (strong,nonatomic) NSMutableArray *doneList;
@property (nonatomic,assign) NSInteger index;

@end

@implementation SeletedCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"选择城市";
    self.dataList = [NSMutableArray array];
    self.doneList = [NSMutableArray array];
    [self creatCollection];
    [self loadData];
    self.tableView2.allowsMultipleSelection = YES;
    
    
}

- (void)loadData{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_province_findAll];
    entity.needCache = NO;
    entity.parameters = nil;
    
          [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
          [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
              NSDictionary *result = response;
              if ([result[@"code"] intValue] == 0) {
                  self.dataList = [CityModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
                  [self.tableView1 reloadData];
                  [self.tableView2 reloadData];
                  [self.tableView1 selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];

              }
              
          } failureBlock:^(NSError *error) {
              
              
          } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
              
          }];
    
}


- (void)creatCollection
{
    
    self.layout.itemSize = CGSizeMake(50, 22);
    self.layout.minimumLineSpacing = 10;
    self.layout.minimumInteritemSpacing = 10;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
    [self.collectionView registerNib:[UINib nibWithNibName:@"CityDoneCell" bundle:nil] forCellWithReuseIdentifier:@"CityDoneCellID"];
    
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.doneList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CityDoneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CityDoneCellID" forIndexPath:indexPath];
    CityModel *model = self.doneList[indexPath.row];
    cell.titleLab.text = model.name;
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CityModel *model = self.doneList[indexPath.row];
    return CGSizeMake([model.name getWidthWithfont:[UIFont systemFontOfSize:13]] + 20, 22);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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
    
    CityModel *model = self.dataList[self.index];
    return model.children.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableView1) {
        static NSString *identifire = @"cellID";
        MenumCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MenumCell" owner:nil options:nil] lastObject];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];

        cell.selectedBackgroundView.backgroundColor = Color_Theme;
        CityModel *model = self.dataList[indexPath.row];
        cell.titleLab.text = model.name;
       
        return cell;
        
    }else{
        static NSString *identifire = @"cellID1";
        SubMenumCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SubMenumCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        CityModel *model = self.dataList[self.index];
        CityModel *smodel = model.children[indexPath.row];
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

        CityModel *model = self.dataList[self.index];
        for (int i = 0; i < model.children.count; i++) {
            CityModel *smodel = model.children[i];
            for (CityModel *mm in self.doneList) {
                if ([smodel.name isEqualToString:mm.name]) {
                     [self.tableView2 selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
                    break;
                }
            }
        }        
        
        return;
    }
    
    if (self.doneList.count > 3) {
        [MBProgressHUD showError:@"最多选择只能选择四个热门城市" toView:lxWindow];
        [self.tableView2 deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    CityModel *model = self.dataList[self.index];
    [self.doneList addObject:model.children[indexPath.row]];
    [self.collectionView reloadData];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView2 == tableView) {
         CityModel *model = self.dataList[self.index];
         [self.doneList removeObject:model.children[indexPath.row]];
        [self.collectionView reloadData];
    }
}

- (IBAction)doneAC:(id)sender {
    
    NSMutableArray *cityA = [NSMutableArray array];
    for (CityModel *model in self.doneList) {
        [cityA addObject:model.name];
    }
    if (self.cityBlock) {
        self.cityBlock(cityA);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
