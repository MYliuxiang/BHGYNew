//
//  ReleaseProgramVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/13.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "ReleaseProgramVC.h"

@interface ReleaseProgramVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UIButton *releaseB;
@property (weak, nonatomic) IBOutlet UITextField *textF1;
@property (weak, nonatomic) IBOutlet UITextField *textF2;
@property (weak, nonatomic) IBOutlet UITextField *textF3;
@property (weak, nonatomic) IBOutlet UITextField *textF4;
@property (weak, nonatomic) IBOutlet UITextField *textF5;

@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,strong) NSMutableArray *assets;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adressC;

@end

@implementation ReleaseProgramVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"发节目";
    self.images = [NSMutableArray array];
    self.assets = [NSMutableArray array];
    if (self.themStr) {
        
    }
    self.textF1.text = self.themStr;
   
    [self upPhotoC];
    
    [self creatCollection];
    self.releaseB.layer.cornerRadius = 22.5;
    self.releaseB.layer.masksToBounds = YES;
}

- (void)upPhotoC{
    
    if (self.images.count == 6) {
        self.photoC.constant = 2  * ((kScreenWidth - 100 - 40) / 3 + 10) + 10;
    }else{
        self.photoC.constant = ((self.images.count + 1) + 2) / 3  * ((kScreenWidth - 100 - 40) / 3 + 10) + 10;
        
    }
    
}

- (void)creatCollection
{
    
    self.layout.itemSize = CGSizeMake((kScreenWidth - 100 - 40) / 3, (kScreenWidth - 100 - 40) / 3);
    self.layout.minimumLineSpacing = 10;
    self.layout.minimumInteritemSpacing = 10;
    self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 20);
    
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
        [weakSelf upPhotoC];
        
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.textF1) {
        //主题
        
    }
    if (textField == self.textF2) {
        //地点
        AddAdressVC *vc = [[AddAdressVC alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
        
    }
    if (textField == self.textF3) {
        //对象
        
        BADataEntity *entity = [BADataEntity new];
        entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_expectationsObject_findAll];
        entity.needCache = YES;
        entity.parameters = nil;
        
        [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
        [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
            NSDictionary *result = response;
          if ([result[@"code"] intValue] == 0) {
                NSArray *array = [ServerModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
                     
              NSMutableArray *marray = [NSMutableArray array];
              for (ServerModel *model in array) {
                  [marray addObject:model.name];
              }
              
//              if (self.textF3.text.c) {
//                  <#statements#>
//              }
              
              NSArray *sletes = [self.textF3.text componentsSeparatedByString:@","];
              
              ExpectationAlert *alert = [[ExpectationAlert alloc] initWithContents:marray seletes:sletes];
              alert.clickBlcok = ^(NSString * _Nonnull expectation) {
                  self.textF3.text = expectation;
              };
              alert.titleLab.text = @"选择期望对象";
              [alert show];
               
                
            }
            
        } failureBlock:^(NSError *error) {
            
            
        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            
        }];
        

    }
    if (textField == self.textF4) {
        //日期
        NSDate *now = [NSDate date];
           NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
           fmt.dateFormat = @"yyyy-MM-dd";
           NSString *nowStr = [fmt stringFromDate:now];
           
           CGXPickerViewManager *manager = [[CGXPickerViewManager alloc] init];
           manager.pickerTitleSelectColor = Color_Theme;
           manager.rightBtnBorderWidth = 0;
           manager.rightBtnCornerRadius = 0;
           manager.leftBtnBorderWidth = 0;
           manager.leftBtnCornerRadius = 0;
           manager.rightBtnTitleColor = Color_Theme;
           manager.rightBtnBGColor = [UIColor clearColor];
           manager.leftBtnTitleColor = Color_Theme;
           manager.leftBtnBGColor = [UIColor clearColor];
           manager.leftBtnTitleSize = 14;
           manager.rightBtnTitleSize = 14;
           
           [CGXPickerView showDatePickerWithTitle:@"选择日期" DateType:UIDatePickerModeDate DefaultSelValue:nowStr MinDateStr:nowStr MaxDateStr:@"" IsAutoSelect:YES Manager:manager ResultBlock:^(NSString *selectValue) {
               self.textF4.text = selectValue;
           }];
        
    }
    if (textField == self.textF5) {
        //时间
        NSDate *now = [NSDate date];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"HH:mm:ss";
        NSString *nowStr = [fmt stringFromDate:now];
        
        CGXPickerViewManager *manager = [[CGXPickerViewManager alloc] init];
        manager.pickerTitleSelectColor = Color_Theme;
        manager.rightBtnBorderWidth = 0;
        manager.rightBtnCornerRadius = 0;
        manager.leftBtnBorderWidth = 0;
        manager.leftBtnCornerRadius = 0;
        manager.rightBtnTitleColor = Color_Theme;
        manager.rightBtnBGColor = [UIColor clearColor];
        manager.leftBtnTitleColor = Color_Theme;
        manager.leftBtnBGColor = [UIColor clearColor];
        manager.leftBtnTitleSize = 14;
        manager.rightBtnTitleSize = 14;
        
        [CGXPickerView showDatePickerWithTitle:@"选择时间" DateType:UIDatePickerModeTime DefaultSelValue:@"" MinDateStr:@"" MaxDateStr:@"" IsAutoSelect:YES Manager:manager ResultBlock:^(NSString *selectValue) {
            self.textF5.text = selectValue;
        }];
    }
       
    return NO;
}



@end
