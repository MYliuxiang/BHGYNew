//
//  ComplaintVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/13.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "ComplaintVC.h"

@interface ComplaintVC ()
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UIImageView *img5;

@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoC;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property(nonatomic,assign) int seletedIndex;
@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,strong) NSMutableArray *assets;

@end

@implementation ComplaintVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"投诉客服";
    self.images = [NSMutableArray array];
    self.assets = [NSMutableArray array];
    [self upPhotoC];
    [self creatCollection];
}

- (void)upPhotoC{
    
    if (self.images.count == 6) {
        self.photoC.constant = 2  * ((kScreenWidth - 60) / 3 + 10) + 10;
    }else{
        self.photoC.constant = ((self.images.count + 1) + 2) / 3  * ((kScreenWidth - 60) / 3 + 10) + 10;
        
    }
    
}
- (IBAction)tapAC:(id)sender {
    //选择时间
}
- (IBAction)tapAC1:(id)sender {
    self.seletedIndex = 1;
    self.img1.image = [UIImage imageNamed:@"gouxuan"];
    self.img2.image = [UIImage imageNamed:@"椭圆形33"];
    self.img3.image = [UIImage imageNamed:@"椭圆形33"];
    self.img4.image = [UIImage imageNamed:@"椭圆形33"];
    self.img5.image = [UIImage imageNamed:@"椭圆形33"];

}
- (IBAction)tapAC2:(id)sender {
    self.seletedIndex = 2;
      self.img2.image = [UIImage imageNamed:@"gouxuan"];
      self.img1.image = [UIImage imageNamed:@"椭圆形33"];
      self.img3.image = [UIImage imageNamed:@"椭圆形33"];
      self.img4.image = [UIImage imageNamed:@"椭圆形33"];
      self.img5.image = [UIImage imageNamed:@"椭圆形33"];
    
}
- (IBAction)tapAC3:(id)sender {
    self.seletedIndex = 3;
      self.img3.image = [UIImage imageNamed:@"gouxuan"];
      self.img1.image = [UIImage imageNamed:@"椭圆形33"];
      self.img2.image = [UIImage imageNamed:@"椭圆形33"];
      self.img4.image = [UIImage imageNamed:@"椭圆形33"];
      self.img5.image = [UIImage imageNamed:@"椭圆形33"];
}
- (IBAction)tapAC4:(id)sender {
    self.seletedIndex = 4;
      self.img4.image = [UIImage imageNamed:@"gouxuan"];
      self.img1.image = [UIImage imageNamed:@"椭圆形33"];
      self.img2.image = [UIImage imageNamed:@"椭圆形33"];
      self.img3.image = [UIImage imageNamed:@"椭圆形33"];
      self.img5.image = [UIImage imageNamed:@"椭圆形33"];
}
- (IBAction)tapAC5:(id)sender {
    self.seletedIndex = 5;
      self.img5.image = [UIImage imageNamed:@"gouxuan"];
      self.img1.image = [UIImage imageNamed:@"椭圆形33"];
      self.img2.image = [UIImage imageNamed:@"椭圆形33"];
      self.img3.image = [UIImage imageNamed:@"椭圆形33"];
      self.img4.image = [UIImage imageNamed:@"椭圆形33"];
}



- (void)creatCollection
{
    
    self.layout.itemSize = CGSizeMake((kScreenWidth - 60) / 3, (kScreenWidth - 60) / 3);
    self.layout.minimumLineSpacing = 10;
    self.layout.minimumInteritemSpacing = 10;
    self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
    
    
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
        
    };
    return cell;
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        UIView *view = [UIView new];
        reusableview = view;
    }
    return reusableview;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.images.count) {
           
           TZImgePickHelper *helper = [[TZImgePickHelper alloc] initMaxCount:6];
           helper.selectedAssets = self.assets;
           helper.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
               self.images = photos;
               self.assets = assets;
               [self upPhotoC];
               [self.collectionView reloadData];
           };
           [self presentViewController:helper animated:YES completion:nil];
           
       }
       
    
}



@end
