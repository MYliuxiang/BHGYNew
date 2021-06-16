//
//  ReleaseDynamicVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/12.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "ReleaseDynamicVC.h"

@interface ReleaseDynamicVC ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UIButton *releaseB;

@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,strong) NSMutableArray *assets;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoC;
@property (weak, nonatomic) IBOutlet UITextView *contentT;
@property (weak, nonatomic) IBOutlet UISwitch *swith1;
@property (weak, nonatomic) IBOutlet UISwitch *swith2;

@end

@implementation ReleaseDynamicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"发动态";
    self.images = [NSMutableArray array];
    self.assets = [NSMutableArray array];
    [self upPhotoC];
    
    [self creatCollection];
    self.releaseB.layer.cornerRadius = 22.5;
    self.releaseB.layer.masksToBounds = YES;
}

- (void)upPhotoC{
    
    if (self.images.count == 6) {
        self.photoC.constant = 2  * ((kScreenWidth - 60) / 3 + 10) + 10;
    }else{
        self.photoC.constant = ((self.images.count + 1) + 2) / 3  * ((kScreenWidth - 60) / 3 + 10) + 10;
        
    }
    
}

- (IBAction)releaseAC:(id)sender {
    
    if(self.contentT.text.length == 0 && self.images.count == 0){
        [MBProgressHUD showError:@"请输入文字或选择图片" toView:lxWindow];
        return;
    }
    
//    if ([LoginManger sharedManager].currentLoginModel.vip == 0) {
//        //不是vip
//        PrivateChatAlert *alert = [[PrivateChatAlert alloc] init];
//        [alert.btn1 setTitle:@"发布动态（花费多少币）" forState:UIControlStateNormal];
//        [alert.btn2 setTitle:@"成为会员，免费发布" forState:UIControlStateNormal];
//
//                   alert.btnclickBlock = ^(NSInteger index) {
//                       if (index == 0) {
//                           PayAlert *palert = [[PayAlert alloc] init];
//                           palert.clickBlock = ^(NSInteger index) {
//                               if (index == 1){
//                                   RechargeAlert *rAlert = [[RechargeAlert alloc] init];
//                                   [rAlert show];
//                               }
//                           };
//                           [palert show];
//                       }
//
//                   };
//                   [alert show];
//        return;
//    }
    
    
    if (self.images.count == 0) {
        [self relaseDynamic:nil];
        return;
    }
    
    [self uploadImags:self.images];

        
}

- (void)uploadImags:(NSArray *)images{
    
    
//        dispatch_semaphore_t sema = dispatch_semaphore_create(1);
//        for (NSInteger i = 0;i<10;i++) {
//             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//                // doing
//                 NSLog(@"%d",i);
//                dispatch_semaphore_signal(sema);
//            });
//        }
    
    NSMutableArray *array = [NSMutableArray array];
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t sema = dispatch_semaphore_create(1);

    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];

    for (UIImage *image in images) {
        
        dispatch_async(quene, ^{
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

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
            [self relaseDynamic:array];
        });
        
        dispatch_semaphore_signal(sema);
        
    });

    
}

- (void)relaseDynamic:(NSArray *)imageIDs{
    BADataEntity *entity = [BADataEntity new];
       entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_dynamic_publishDynamic];
       entity.needCache = NO;
    NSString *images;
    if (imageIDs.count == 0) {
        images = @"";
    }else{
        images = [imageIDs componentsJoinedByString:@","];
    }
    
    NSString *hidden;
    if (self.swith2.isOn) {
        hidden = @"1";
    }else{
        hidden = @"0";
    }
    
    NSString *commentEnable;
       if (self.swith1.isOn) {
           commentEnable = @"1";
       }else{
           commentEnable = @"0";
       }
    
    entity.parameters = @{@"content":self.contentT.text,@"currencyOrderId":@"",@"images":images,@"hidden":hidden,@"commentEnable":commentEnable};
       
       [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
       [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
           NSDictionary *result = response;
           if ([result[@"code"] intValue] == 0) {
               [MBProgressHUD showError:@"成功发布动态" toView:lxWindow];
               [self.navigationController popViewControllerAnimated:YES];
               
           }
           
       } failureBlock:^(NSError *error) {
           
           
       } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
           
    }];
    
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
        [self upPhotoC];

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
//            [self loadImages];
            [self.collectionView reloadData];
        };
        [self presentViewController:helper animated:YES completion:nil];
        
    }
    
    
}


- (void)loadImages{
    
    BAImageDataEntity *entity = [BAImageDataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainFileUrl,Url_UploadFile];
    entity.needCache = NO;
    entity.imageArray = self.images;
    entity.imageType = @"png";
    entity.imageScale = 0.7;
    [BANetManager ba_uploadImageWithEntity:entity successBlock:^(id response) {
        
    } failurBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

@end
