//
//  RLikeAlert.m
//  BHGY
//
//  Created by liuxiang on 2020/7/20.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "RLikeAlert.h"

@implementation RLikeAlert
- (instancetype)initWithContents:(NSArray *)contents withDoneList:(NSArray *)doneList{
 
    self = [super init];
    if (self) {
        
        self.width = kScreenWidth;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.doneList = [NSMutableArray array];
        self.contents = contents;
        self.type = LxCustomAlertTypeSheet;
        self.tableView.allowsMultipleSelection = YES;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self creatCollection];
        [self setupAutoHeightWithBottomView:self.collectionView bottomMargin:0];
        self.doneList = [[NSMutableArray alloc] initWithArray:doneList];
        [self.tableView reloadData];
        [self.collectionView reloadData];
        for (int i = 0; i < self.contents.count; i++) {
                   for (NSString *mm in self.doneList) {
                       if ([self.contents[i] isEqualToString:mm]) {
                            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
                           break;
                       }
                   }
               }
        
        
        
        
        
    }
    return self;
    
    
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
    cell.titleLab.text = self.doneList[indexPath.row];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake([self.doneList[indexPath.row] getWidthWithfont:[UIFont systemFontOfSize:13]] + 20, 22);
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
   
    
    return self.contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        static NSString *identifire = @"cellID1";
        RLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RLikeCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
       
       cell.titleLab.text = self.contents[indexPath.row];

        
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
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.doneList.count > 3) {
        [MBProgressHUD showError:@"最多选择只能选择四个热门城市" toView:lxWindow];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    [self.doneList addObject:self.contents[indexPath.row]];
    [self.collectionView reloadData];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.doneList removeObject:self.contents[indexPath.row]];
    [self.collectionView reloadData];
}



- (IBAction)doneAC:(id)sender {
    if (self.rlikeBlock) {
        self.rlikeBlock(self.doneList);
    }
    [self disMiss];
}

- (IBAction)canleAC:(id)sender {
    [self disMiss];

}
@end
