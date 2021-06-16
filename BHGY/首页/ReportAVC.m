//
//  ReportAVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/23.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "ReportAVC.h"

@interface ReportAVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSArray *titles;
@property(nonatomic,strong) NSArray *dataList;
@property(nonatomic,strong) SeletImageCell *imageCell;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,strong) NSMutableArray *assets;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ReportAVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.tableHeaderView = self.headerView;
    self.images = [NSMutableArray array];
    self.assets = [NSMutableArray array];
    self.customNavBar.title = @"匿名举报";
    
    self.titles = @[@"请选择举报原因",@"请提供相关截图，以便我们跟进核实",@"补充描述"];
    CGFloat height = [self.headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.headerView.height = height;
    self.tableView.tableHeaderView = self.headerView;
    //   [self loadData];
    [self creatCollection];
    
    [self layoutFooterView];
    
    
    
}

- (void)layoutFooterView{
    
    if (self.images.count == 6) {
        self.footerView.height =  (2  * ((kScreenWidth - 60) / 3 + 10) + 10) + 96;
    }else{
        self.footerView.height = (((self.images.count + 1) + 2) / 3  * ((kScreenWidth - 60) / 3 + 10) + 10) + 96 ;
    }
    [self.tableView beginUpdates];
    
    self.tableView.tableFooterView = self.footerView;
    [self.tableView endUpdates];
    
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
        [weakSelf layoutFooterView];
        
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
            [weakSelf layoutFooterView];
            
        };
        [self presentViewController:helper animated:YES completion:nil];
    }
    
}

- (void)loadData{
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_complaintReason_findAll];
    entity.needCache = YES;
    entity.parameters = nil;
    
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            self.dataList = [ServerModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            [self.tableView reloadData];
            
        }
        
    } failureBlock:^(NSError *error) {
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    if (section == 1){
        return 0;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifire = @"cellID";
        ReportCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReportCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }else if (indexPath.section == 1){
        SeletImageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SeletImageCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        __weak typeof(self) weakSelf = self;
        
        cell.reloadSectionBlock = ^{
            [weakSelf.tableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
        };
        
        return self.imageCell;
    }else{
        static NSString *identifire = @"cellIDthree";
        TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TextViewCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.textView.placeholder = @"选填";
        
        return cell;
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    }else if(indexPath.section == 1){
        
        //        SeletImageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        return [self.imageCell cellheight];
    }else{
        return 60;
    }
}

- (SeletImageCell *)imageCell{
    if (_imageCell == nil) {
        _imageCell = [[[NSBundle mainBundle] loadNibNamed:@"SeletImageCell" owner:nil options:nil] lastObject];
        _imageCell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self) weakSelf = self;
        
        _imageCell.reloadSectionBlock = ^{
            //            [weakSelf.tableView reloadData];
            [weakSelf.tableView reloadSection:1 withRowAnimation:UITableViewRowAnimationAutomatic];
        };
    }
    return _imageCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 30;
    
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return YES;
    }
    return NO;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(20, 0, kScreenWidth - 20, 30);
    label.font = [UIFont systemFontOfSize:13];
    label.text = self.titles[section];
    label.textColor = Color_3;
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    //    if (section == 1) {
    //        if (self.images.count == 6) {
    //            return  2  * ((kScreenWidth - 60) / 3 + 10) + 10;
    //        }else{
    //            return  ((self.images.count + 1) + 2) / 3  * ((kScreenWidth - 60) / 3 + 10) + 10;
    //        }
    //    }
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


- (IBAction)doneAC:(id)sender {
    if (![self.tableView indexPathForSelectedRow]) {
        [MBProgressHUD showError:@"请选择举报原因" toView:lxWindow];
        return;
    }
    if (self.images.count == 0) {
        [MBProgressHUD showError:@"请选择相关照片" toView:lxWindow];
        return;
    }
    if(self.textView.text.length == 0){
        [MBProgressHUD showError:@"请补充描述" toView:lxWindow];
        return;
    }
    
    [self uploadImags:self.images];
    
    
}
- (void)uploadImags:(NSArray *)images{
    
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
            [self report:array];
        });
        
        dispatch_semaphore_signal(sema);
        
    });
    
    
}

- (void)report:(NSArray *)imageIDs{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userComplaint_complaint];
    entity.needCache = NO;
    NSString *images;
    if (imageIDs.count == 0) {
        images = @"";
    }else{
        images = [imageIDs componentsJoinedByString:@","];
    }
    
    entity.parameters = @{@"userId":self.model.uid,@"images":images,@"content":self.textView.text,@"reason":@"shih"};
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            
            [MBProgressHUD showError:@"举报成功" toView:lxWindow];
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        
    } failureBlock:^(NSError *error) {
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}





@end
