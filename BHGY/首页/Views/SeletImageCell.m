//
//  SeletImageCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/23.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "SeletImageCell.h"

@implementation SeletImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.images = [NSMutableArray array];
    self.assets = [NSMutableArray array];
    [self creatCollection];
    [self upPhotoC];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)creatCollection
{
    self.layout.itemSize = CGSizeMake((kScreenWidth - 60) / 3, (kScreenWidth - 60) / 3);
    self.layout.minimumLineSpacing = 9.5;
    self.layout.minimumInteritemSpacing = 10;
    self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SPhotoCell" bundle:nil] forCellWithReuseIdentifier:@"SPhotoCellID"];
    
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.images.count == 6) {
        return 6;
    }else{
        return self.images.count + 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SPhotoCellID" forIndexPath:indexPath];
    if (indexPath.row == self.images.count) {
        cell.img.image = [UIImage imageNamed:@"编组 4"];
        cell.deletedB.hidden = YES;

    }else{
        cell.img.image = self.images[indexPath.row];
        cell.deletedB.hidden = NO;

    }
    
    __weak typeof(self) weakSelf = self;
    cell.btnClick = ^{
        [weakSelf.images removeObjectAtIndex:indexPath.row];
        [weakSelf.assets removeObjectAtIndex:indexPath.row];
        [weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        [weakSelf.collectionView reloadData];
        if (weakSelf.reloadSectionBlock) {
                     
            weakSelf.reloadSectionBlock();
        }
    };
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.images.count) {
      
        TZImgePickHelper *helper = [[TZImgePickHelper alloc] initMaxCount:6];
        helper.selectedAssets = self.assets;
        __weak typeof(self) weakSelf = self;

        helper.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                   weakSelf.images = photos;
                   weakSelf.assets = assets;
                   [weakSelf.collectionView reloadData];
           
              
        };
        [self.viewController presentViewController:helper animated:YES completion:nil];
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath{
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(nonnull UICollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (self.reloadSectionBlock) {
                  
        self.reloadSectionBlock();
              
    }
}

- (CGFloat)cellheight{
    if (self.images.count == 6) {
           return  2  * ((kScreenWidth - 60) / 3 + 10) + 10;
       }else{
           return  ((self.images.count + 1) + 2) / 3  * ((kScreenWidth - 60) / 3 + 10) + 10;
       }
}


- (void)upPhotoC{
    
    CGFloat height;
    
    if (self.images.count == 6) {
        height =  2  * ((kScreenWidth - 60) / 3 + 10) + 10;
    }else{
        height = ((self.images.count + 1) + 2) / 3  * ((kScreenWidth - 60) / 3 + 10) + 10;
    }
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
}


@end
