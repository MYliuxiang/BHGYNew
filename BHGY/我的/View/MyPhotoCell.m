//
//  MyPhotoCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/13.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "MyPhotoCell.h"
#import "DetailCell.h"

@implementation MyPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self creatCollection];
    
    self.images = [NSMutableArray array];

    
}

- (void)creatCollection
{
    
    self.layout.itemSize = CGSizeMake((kScreenWidth - 30 - 20) / 3, (kScreenWidth - 30 - 20) / 3);
    self.layout.minimumLineSpacing = 10;
    self.layout.minimumInteritemSpacing = 10;
    self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyImagesCell" bundle:nil] forCellWithReuseIdentifier:@"MyImagesCellID"];
    
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyImagesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyImagesCellID" forIndexPath:indexPath];
    UserPhoto *model = self.photos[indexPath.row];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:[HandleTool getImageUrlStr:model.imageId]] placeholderImage:[UIImage imageNamed:@"编组 2备份"]];
    if(model.type == 0){
        cell.stateI.hidden = YES;
        cell.stateL.hidden = YES;
    }else{
        cell.stateI.hidden = NO;
        cell.stateL.hidden = NO;
    }
  
    if (indexPath.row == 5 && self.photos.count > 6) {
        cell.moreLab.text = [NSString stringWithFormat:@"+%ld",self.photos.count - 6];
               cell.moreLab.hidden = NO;
    }else{
        cell.moreLab.hidden = YES;
    }
   

    return cell;
    
}





- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyBrowserVC *vc = [MyBrowserVC new];
    vc.dataList = self.photos;
    vc.selectIndex = indexPath.row;
    vc.type = BrowserTypeMe;
    __weak typeof(self) weakSelf = self;
    vc.photoBlock = ^(NSArray * _Nonnull photos) {
        weakSelf.photos = photos;
        [weakSelf.collectionView reloadData];
        if (weakSelf.reloadPhotos) {
            weakSelf.reloadPhotos(weakSelf.photos);
        }
    };
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.viewController presentViewController:nav animated:YES completion:nil];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)uploadImages:(id)sender {
    
    TZImgePickHelper *helper = [[TZImgePickHelper alloc] initMaxCount:6];
//           helper.selectedAssets = self.assets;
           __weak typeof(self) weakSelf = self;
           
           helper.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
               weakSelf.images = photos;
//               weakSelf.assets = assets;
//               [weakSelf.collectionView reloadData];
               [weakSelf uploadImags:weakSelf.images];
               
           };
    [self.viewController presentViewController:helper animated:YES completion:nil];
    
}

- (void)uploadImags:(NSArray *)images{
    
    NSMutableArray *array = [NSMutableArray array];
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t sema = dispatch_semaphore_create(1);
    
    for (UIImage *image in images) {
        
        dispatch_async(quene, ^{
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
                
            });
            BAImageDataEntity *entity = [BAImageDataEntity new];
            entity.urlString = [NSString stringWithFormat:@"%@%@",MainFileUrl,Url_UploadFile];
            entity.needCache = NO;
            entity.imageArray = @[image];
            entity.imageType = @"png";
            entity.imageScale = 0.7;
            [BANetManager ba_uploadImageWithEntity:entity successBlock:^(id response) {
                NSDictionary *result = response;
                if ([result[@"code"] intValue] == 0) {
                    //
                    [array addObject:result[@"data"]];
                }
                dispatch_semaphore_signal(sema);
                
            } failurBlock:^(NSError *error) {
                dispatch_semaphore_signal(sema);
                
            } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                
            }];
            
        });
        
        
    }
    dispatch_async(quene, ^{
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:lxWindow animated:YES];
            [self uploadMyimages:array];
        });
        
        dispatch_semaphore_signal(sema);
        
    });
    
    
}

- (void)uploadMyimages:(NSArray *)imageIDs{
    BADataEntity *entity = [BADataEntity new];
       entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userPhoto_add];
       entity.needCache = NO;
       NSString *images;
      
    images = [imageIDs componentsJoinedByString:@","];
       
       entity.parameters = @{@"imageIds":images};
       [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
       [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
           NSDictionary *result = response;
           if ([result[@"code"] intValue] == 0) {
               [MBProgressHUD showError:@"上传成功" toView:lxWindow];
               [self.collectionView reloadData];
               if (self.reloadDatas) {
                   self.reloadDatas();
               }
           }
       } failureBlock:^(NSError *error) {
       } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
       }];
    
}




@end
