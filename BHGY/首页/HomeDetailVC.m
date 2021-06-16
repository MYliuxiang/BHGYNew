//
//  HomeDetailVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "HomeDetailVC.h"
#import "DetailCell.h"
#import "HomeDetailCell.h"
#import "HomeDetailTwoCell.h"
#import "CommentAlert.h"
#import "CommentOneAlert.h"

@interface HomeDetailVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerViewOne;
@property (strong, nonatomic) IBOutlet UIView *headerViewTwo;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *avatorI;
@property (weak, nonatomic) IBOutlet UIButton *sexB;
@property (weak, nonatomic) IBOutlet UIButton *adressB;
@property (weak, nonatomic) IBOutlet UILabel *adressL;
@property (weak, nonatomic) IBOutlet UIButton *likeB;
@property (weak, nonatomic) IBOutlet UIButton *proB;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UIImageView *stateI;
@property (weak, nonatomic) IBOutlet UIImageView *stateI1;
@property(nonatomic,strong) NSArray *names;



@end

@implementation HomeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.backgroundColor = [UIColor clearColor];
    self.names = @[@"身高",@"体重",@"常驻城市",@"日常爱好",@"微信",@"个人介绍"];
    self.customNavBar.title = self.model.nickName;
    [self cofigData];
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"编组 5"]];
    
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickRightButton = ^{
        
        MoreAlert *alert = [[MoreAlert alloc] initWithContents:@[@"拉黑（屏蔽双方）",@"备注",@"匿名举报"]];
        alert.clickBlcok = ^(NSInteger index) {
            if (index == 0) {
                [self addBlack];
               
            }else if (index == 1){
                RemarkVC *vc = [[RemarkVC alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                ReportAVC *vc = [[ReportAVC alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            
        };
        [alert show];
        
    };
    [self creatCollection];
    
    self.headerViewOne.clipsToBounds = YES;
    self.headerViewTwo.clipsToBounds = YES;
    self.footerView.height = 40;
    self.tableView.tableFooterView = self.footerView;
    
    [self loadData];
}

- (void)loadData{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userInfo_queryUserDetail];
    entity.needCache = NO;
   
    entity.parameters = @{@"userId":self.model.uid};
 

    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            
            NSArray *models = [HomeModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"content"]];
        }
        
    } failureBlock:^(NSError *error) {
      

        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}

- (void)cofigData{
    [self.avatorI sd_setImageWithURL:[NSURL URLWithString:[HandleTool getImageUrlStr:self.model.avatar]] placeholderImage:[UIImage imageNamed:@"编组 2备份"]];
    
       NSArray *array =@[_model.city,_model.profession,_model.constellation];
       
       
       self.adressL.text = [array componentsJoinedByString:@" | "];
       [self.adressB setTitle:[HandleTool getDistance:_model.distance] forState:UIControlStateNormal];
//       if(model.photoFlag == 0){
//           _labB4.hidden = YES;
//       }else{
//           //需要权限
//           _labB4.hidden = NO;
//       }
       
       if(_model.sex == 0){
           [self.sexB setImage:[UIImage imageNamed:@"xingbienv"] forState:UIControlStateNormal];
       }else{
           [self.sexB setImage:[UIImage imageNamed:@"B"] forState:UIControlStateNormal];
       }
       [self.sexB setTitle:[NSString stringWithFormat:@"%d",_model.age] forState:UIControlStateNormal];
       
    if (self.model.goddess == 0) {
        self.stateI1.hidden = YES;
        self.lab2.hidden = YES;
    }
    if (self.model.realHuman == 0) {
        self.stateI.hidden = YES;
        self.lab1.hidden = YES;
    }
    self.sexB.layer.cornerRadius = 8;
    self.sexB.layer.masksToBounds = YES;
    
    self.adressB.layer.cornerRadius = 8;
    self.adressB.layer.masksToBounds = YES;
       
    [self.sexB layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:3];
    [self.adressB layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:3];
    
    [self.likeB layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
    

    
    
}

- (void)addBlack{
        
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_blacklist_add];
    entity.needCache = NO;
    
    entity.parameters = @{@"userId":self.model.uid};
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            
            [MBProgressHUD showError:@"拉黑成功" toView:lxWindow];
            if (self.blackBlock) {
                self.blackBlock(self.model);
            }
            
        }
        
    } failureBlock:^(NSError *error) {
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (IBAction)bottomBAC:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 100:
        {
        
            
            CommentOneAlert *alert = [[CommentOneAlert alloc] initWithContents:@[@"友好",@"有趣",@"爽快",@"耐心",@"高冷",@"暴脾气"]];
            [alert show];
            
        }
            break;
            
        case 101:
        {
            
            PrivateChatAlert *alert = [[PrivateChatAlert alloc] init];
            alert.btnclickBlock = ^(NSInteger index) {
                if (index == 0) {
                    PayAlert *palert = [[PayAlert alloc] init];
                    palert.clickBlock = ^(NSInteger index) {
                        if (index == 1){
                            RechargeAlert *rAlert = [[RechargeAlert alloc] init];
                            [rAlert show];
                        }
                    };
                    [palert show];
                }
               
            };
            [alert show];
            
        }
            break;
            
            
        case 102:
        {
            
        }
            break;
            
            
        case 103:
        {
            
        }
            break;
            
            
        default:
            break;
    }
}


- (void)creatCollection
{
    
    self.layout.itemSize = CGSizeMake((kScreenWidth - 30 - 20) / 3, (kScreenWidth - 30 - 20) / 3);
    self.layout.minimumLineSpacing = 10;
    self.layout.minimumInteritemSpacing = 10;
    self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellWithReuseIdentifier:@"DetailCellID"];
    
}


#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.names.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        static NSString *identifire = @"cellID";
        HomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeDetailCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        return cell;
    }else{
        
        
        
        static NSString *identifire = @"cellIDone";
        HomeDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeDetailTwoCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.nameL.text = self.names[indexPath.row];
        cell.acBtn.hidden = YES;
        switch (indexPath.row) {
            case 0:
                //身高
                break;
            case 1:
                //体重
                break;
            case 2:
                //常驻城市
                break;
            case 3:
                //日常爱好
                break;
            case 4:
                //微信
                cell.acBtn.hidden = NO;
                break;
            case 5:
                //个人介绍
                break;
                
                
            default:
                break;
        }
        
        
        
        return cell;
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return kScreenWidth / 375 * 300 + 110;
    }else{
        return (kScreenWidth - 30 - 20) / 3  + 36 + 10 ;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.headerViewOne;
    }else{
        
        return self.headerViewTwo;
        
    }
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
    if (indexPath.section == 0) {
        return 56;
    }else{
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailCellID" forIndexPath:indexPath];
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
    
    
}





@end
