//
//  HomeVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/2.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "HomeVC.h"
#import "LogingViewController.h"
#import "HomeCell.h"
#import "HomeSubVC.h"
#import "MenumCell.h"
#import "HomeMenum.h"
#import "SearchVC.h"
#import "DXCountryCodeController.h"
#import <AuthenticationServices/AuthenticationServices.h>
@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource,WMZDropMenuDelegate>

@property(nonatomic,strong) UIButton *sexBtn;

@property(nonatomic,strong) UIButton *conditionBtn;

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *listVCArray;
@property (nonatomic, strong) JXCategoryListContainerView *listVCContainerView;
@property (nonatomic, strong) NSArray *titles;

@property (strong, nonatomic) IBOutlet UIButton *titleBtn;

@property (nonatomic,strong) UIButton *doneBtn;
@property (nonatomic,strong) UIButton *sxB;
@property (nonatomic,strong) WMZDropDownMenu *menu;

@property(nonatomic,strong)UIView *maskView;

@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *online;
@property(nonatomic,copy)NSString *cities;
@property (strong,nonatomic) NSMutableArray *dataList;






@end

@implementation HomeVC

- (UIView *)maskView{
    if (_maskView == nil) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight)];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.33];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAC:)];
        [_maskView addGestureRecognizer:tap];
        _maskView.hidden = YES;
        
    }
    return _maskView;
}

//- (void)tapAC:(UITapGestureRecognizer *)gesture{
//    [UIView animateWithDuration:.35 animations:^{
//        self.maskView.hidden = YES;
//        self.menum.height = 0;
//    } completion:^(BOOL finished) {
//        self.menumHidden = YES;
//    }];
//
//}

//- (HomeMenum *)menum{
//    if (_menum == nil) {
//        _menum = [[HomeMenum alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, 0)];
//    }
//    return _menum;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
    self.dataList = [NSMutableArray array];
    CityModel *model = [[CityModel alloc] init];
                    model.name = @"不限地区";
    [self.dataList insertObject:model atIndex:0];
    self.cities = @"不限地区";

    [self.customNavBar wr_setLeftButtonWithImage: [UIImage imageNamed:@"search"]];
    __weak typeof(self) weakSelf = self;

    self.customNavBar.onClickLeftButton = ^{
        //搜索
        SearchVC *vc = [[SearchVC alloc] init];
        vc.online = weakSelf.online;
        vc.sex = weakSelf.sex;
        vc.cities = weakSelf.cities;
        vc.index = weakSelf.categoryView.selectedIndex;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    

    
//    self.menumHidden = YES;
    
    
//     DXCountryCodeController *countryCodeVC = [[DXCountryCodeController alloc] initWithCountryCode:@""];
//    //    countryCodeVC.deleagete = self;
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:countryCodeVC];
//        countryCodeVC.returnCountryCodeBlock = ^(NSString *countryName, NSString *code) {
//            
//        };
//    nav.modalPresentationStyle = UIModalPresentationFullScreen;
//        [self.navigationController presentViewController:nav animated:YES completion:nil];
    
    
    //11111
    [self creatNav];
        
    self.titles = @[@"附近",@"新注册",@"已认证"];
    self.categoryView = [[JXCategoryTitleView alloc] init];
    self.categoryView.frame = CGRectMake(0, Height_NavBar, kScreenWidth,36);
    self.categoryView.delegate = self;
    self.categoryView.titles = self.titles;
    self.categoryView.titleColor = [MyColor colorWithHexString:@"#333333"];
    self.categoryView.titleSelectedColor = [MyColor colorWithHexString:@"#FB78A3"];
    self.categoryView.titleFont = [UIFont systemFontOfSize:14];
    self.categoryView.backgroundColor = [MyColor colorWithHexString:@"#FFFFFF"];
    self.categoryView.defaultSelectedIndex = 0;
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.lineStyle = JXCategoryIndicatorLineStyle_Normal;
    lineView.lineScrollOffsetX = 5;
    lineView.indicatorColor = [UIColor colorWithHexString:@"#FB78A3"];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
    self.listVCContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listVCContainerView.frame = CGRectMake(0, Height_NavBar + 36, kScreenWidth, kScreenHeight - Height_NavBar - 36);
    self.listVCContainerView.defaultSelectedIndex = 0;
    [self.view addSubview:self.listVCContainerView];
    
    self.categoryView.contentScrollView = self.listVCContainerView.scrollView;
    [self.view addSubview:self.maskView];
    
    if ([LoginManger sharedManager].currentLoginModel.sex == 0) {
        self.sexBtn.selected = NO;
        self.sex = @"1";
    }else{
        self.sexBtn.selected = YES;
        self.sex = @"0";

    }
    [self loadData];
    [self startLocation];

}

//开始定位
-(void) startLocation
{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationmanager = [[CLLocationManager alloc]init];
        locationmanager.delegate = self;
        [locationmanager requestAlwaysAuthorization];
        [locationmanager requestWhenInUseAuthorization];
        //设置寻址精度
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        locationmanager.distanceFilter = 5.0;
        [locationmanager startUpdatingLocation];
    }
}

#pragma mark CoreLocation delegate (定位失败)
//定位失败后调用此代理方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //设置提示提醒用户打开定位服务
    [locationmanager stopUpdatingLocation];
}

#pragma mark 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [locationmanager stopUpdatingHeading];
    //旧址
    CLLocation *currentLocation = [locations lastObject];
    //打印当前的经度与纬度
    //调用注册接口
       BADataEntity *entity = [BADataEntity new];
       entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userInfo_updateLocation];
       entity.needCache = NO;
       entity.parameters = @{@"lat":@(currentLocation.coordinate.latitude),@"lng":@(currentLocation.coordinate.longitude)};
       [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
           NSDictionary *result = response;
           if ([result[@"code"] intValue] == 0) {
              
               
           }
           
       } failureBlock:^(NSError *error) {
           
           
       } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
           
       }];
   
    
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
                  CityModel *model = [[CityModel alloc] init];
                                   model.name = @"不限地区";
                   [self.dataList insertObject:model atIndex:0];
 
                  NSMutableArray *array = [NSMutableArray array];
                  for (CityModel *model in self.dataList) {
                         [array addObject:model.name];
                     }
                  [self.menu updateData:array AtDropIndexPathSection:0 AtDropIndexPathRow:0];
                
              }
              
          } failureBlock:^(NSError *error) {
              
              
          } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
              
          }];
    
}





- (void)creatNav{
    
    self.sexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sexBtn setImage:[UIImage imageNamed:@"编组 12"] forState:UIControlStateNormal];
    [_sexBtn setImage:[UIImage imageNamed:@"编组 1233"] forState:UIControlStateSelected];
    self.sexBtn.frame = CGRectMake(30, Height_StatusBar, 44, 44);
    [self.sexBtn addTarget:self action:@selector(sexAC:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBar addSubview:_sexBtn];
    
    self.conditionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_conditionBtn setTitle:@"在线优先" forState:UIControlStateNormal];
    [_conditionBtn setTitleColor:[UIColor colorWithHexString:@"#FB78A3"] forState:UIControlStateSelected];
    [_conditionBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    _conditionBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    _conditionBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _conditionBtn.layer.borderWidth = 1;
    _conditionBtn.layer.cornerRadius = 5;
    _conditionBtn.layer.masksToBounds = YES;
    [self.conditionBtn addTarget:self action:@selector(conditionAC:) forControlEvents:UIControlEventTouchUpInside];
    self.online = @"0";
    
    self.conditionBtn.frame = CGRectMake(kScreenWidth - 55 - 10, Height_StatusBar + 13, 55, 18);
    [self.customNavBar addSubview:_conditionBtn];
    
//    [self.titleBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
//
////    [self.customNavBar addSubview:self.titleBtn];
//    [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.customNavBar);
//        make.top.mas_equalTo(Height_StatusBar);
//        make.height.mas_equalTo(44);
//    }];
    
    WMZDropMenuParam *param =
                MenuParam()
                .wMainRadiusSet(0)
                .wMenuTitleEqualCountSet(1)
                .wCollectionViewCellSelectTitleColorSet(UIColor.whiteColor)
                .wCollectionViewCellTitleColorSet(UIColor.whiteColor)
                .wCollectionViewSectionRecycleCountSet(3)
                .wMaxHeightScaleSet(0.6)
                .wBorderShowSet(NO)
//    .wCollectionViewCellBorderWith
    .wCollectionViewCellBgColorSet(UIColor.clearColor)
              .wCellSelectShowCheckSet(NO);
                
    self.menu = [[WMZDropDownMenu alloc] initWithFrame:CGRectMake((kScreenWidth - 100) / 2.0, Height_StatusBar, 100, 44) withParam:param];
       _menu.delegate = self;
    _menu.titleView.backgroundColor = [UIColor clearColor];
    _menu.backgroundColor = [UIColor clearColor];
       [self.customNavBar insertSubview:_menu atIndex:0];
    
        
}

#pragma mark WMZDropMenuDelegate
- (NSArray*)titleArrInMenu:(WMZDropDownMenu *)menu{
    
    return @[@"不限地区"];
    
}


- (NSInteger)menu:(WMZDropDownMenu *)menu numberOfRowsInSection:(NSInteger)section{

    return 2;
}


- (NSArray *)menu:(WMZDropDownMenu *)menu dataForRowAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath{
      
     if (dropIndexPath.section == 0){
         
         NSMutableArray *array = [NSMutableArray array];
         for (CityModel *model in self.dataList) {
             [array addObject:model.name];
         }
         
         if (dropIndexPath.row == 0) return array;
           if (dropIndexPath.row == 1) return @[];
      }
      return @[];
}



- (CGFloat)menu:(WMZDropDownMenu *)menu heightForHeadViewAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath
{
    
    return 0;
}

- (NSInteger)menu:(WMZDropDownMenu *)menu countForRowAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath{
   
    return 2;
}


/*
*是否关联 其他标题 即选中其他标题 此标题会不会取消选中状态 default YES
*/
- (BOOL)menu:(WMZDropDownMenu *)menu dropIndexPathConnectInSection:(NSInteger)section{
    return NO;
}


- (CGFloat)menu:(WMZDropDownMenu *)menu heightAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath AtIndexPath:(NSIndexPath *)indexpath{
        return 42;
}

- (MenuUIStyle)menu:(WMZDropDownMenu *)menu uiStyleForRowIndexPath:(WMZDropIndexPath *)dropIndexPath{
    
    return MenuUITableView;
}

- (MenuHideAnimalStyle)menu:(WMZDropDownMenu *)menu hideAnimalStyleForRowInSection:(NSInteger)section{
    
    return MenuHideAnimalTop;
}

- (MenuShowAnimalStyle)menu:(WMZDropDownMenu *)menu showAnimalStyleForRowInSection:(NSInteger)section{
    
      return MenuShowAnimalBottom;
}


- (UITableViewCell*)menu:(WMZDropDownMenu *)menu cellForUITableView:(WMZDropTableView *)tableView AtIndexPath:(NSIndexPath *)indexpath dataForIndexPath:(WMZDropTree *)model{
   
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoCell"];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GanJiTableViewCell"];
            
            UIView *view = [UIView new];
            view.backgroundColor = Color_line;
            [cell.contentView addSubview:view];
            view.frame = CGRectMake(0, 41.5, cell.width, 0.5);
            
        }
        cell.textLabel.text = model.name;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        if (tableView.dropIndex.row == 0){
            cell.textLabel.textColor = model.isSelected?[UIColor whiteColor]:Color_3;
            cell.backgroundColor = model.isSelected?Color_Theme:[UIColor whiteColor];

        }else{
            if ([model.name isEqualToString:self.cities]) {
                model.isSelected = YES;
            }else{
                model.isSelected = NO;
            }
            cell.textLabel.textColor = model.isSelected?Color_Theme:Color_3;
           

        }
       
        
        return cell;
  
    
}
- (BOOL)menu:(WMZDropDownMenu *)menu closeWithTapAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath{
   
    if (dropIndexPath.section == 0 && dropIndexPath.row == 1){
                
        return YES;
    }
    return NO;
}

-  (void)menu:(WMZDropDownMenu *)menu didSelectRowAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath dataIndexPath:(NSIndexPath *)indexpath data:(WMZDropTree *)data{
    
    
    if (dropIndexPath.section == 0 && dropIndexPath.row == 1) {
        [self.sxB setTitle:data.name forState:UIControlStateNormal];
        
        if(![data.name isEqualToString:self.cities]){
            if (![self.cities isEqualToString:data.name]){
                self.cities = data.name;
                  [self xw_postNotificationWithName:HomeLoadNotice userInfo:@{@"sex":self.sex,@"online":self.online,@"cities":self.cities}];
            }
          

        }
        
        
    }
    
    if (dropIndexPath.section == 0 && dropIndexPath.row == 0) {
        
        
        CityModel *model = self.dataList[indexpath.row];
        NSMutableArray *array = [NSMutableArray array];
        if (model.children.count == 0) {
            [self.sxB setTitle:data.name forState:UIControlStateNormal];
            [menu closeWith:dropIndexPath row:indexpath.row data:data];
            if (![self.cities isEqualToString:data.name]){
                self.cities = data.name;
                  [self xw_postNotificationWithName:HomeLoadNotice userInfo:@{@"sex":self.sex,@"online":self.online,@"cities":self.cities}];
            }

        }
        for (CityModel *smodel in model.children) {
                  
            [array addObject:smodel.name];
                
        }
        
        [self.menu updateData:array ForRowAtDropIndexPath:dropIndexPath];

    }
    
}

- (UIView*)menu:(WMZDropDownMenu *)menu userInteractionFootViewInSection:(NSInteger)section{
        UIView *userInteractionFootView = [UIView new];
           userInteractionFootView.backgroundColor = [UIColor whiteColor];
           userInteractionFootView.frame = CGRectMake(0, 0, menu.dataView.frame.size.width, 44);
        
        [userInteractionFootView addSubview:self.doneBtn];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        lineView.backgroundColor = Color_line;
        [userInteractionFootView addSubview:lineView];
        
        [userInteractionFootView addSubview:self.sxB];
        [self.sxB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(userInteractionFootView).offset(15);
            make.centerY.equalTo(userInteractionFootView);
            make.height.mas_equalTo(24);
        }];
              
        if (self.sxB.titleLabel.text.length == 0){
            self.sxB.hidden = YES;
        }else{
            self.sxB.hidden = NO;
        }
        return userInteractionFootView;
  
   
}

- (MenuEditStyle)menu:(WMZDropDownMenu *)menu editStyleForRowAtDropIndexPath:(WMZDropIndexPath*)dropIndexPath{
    
    return MenuEditOneCheck;
}


- (UIButton *)doneBtn{
    if (_doneBtn == nil) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneBtn.frame = CGRectMake(kScreenWidth - 44, 0, 44, 44);
        _doneBtn.backgroundColor = [UIColor clearColor];
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_doneBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_doneBtn setTitleColor:Color_Theme forState:UIControlStateNormal];
        [_doneBtn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}

- (void)buttonClicked{
    //帅选确认按钮
    [self.menu closeView];
    
//    WMZDropTree *tree = self.menu.selectArr.lastObject;
//    [self.sxB setTitle:tree.name forState:UIControlStateNormal];
    
}

- (UIButton *)sxB{
    if (_sxB == nil) {
        _sxB = [UIButton buttonWithType:UIButtonTypeCustom];
        _sxB.backgroundColor = [UIColor clearColor];
        _sxB.titleLabel.font = [UIFont systemFontOfSize:13];
        
        _sxB.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        _sxB.layer.cornerRadius = 4;
        _sxB.layer.masksToBounds = YES;
        _sxB.layer.borderColor = Color_Theme.CGColor;
        _sxB.layer.borderWidth = 1;
        [_sxB setTitleColor:Color_Theme forState:UIControlStateNormal];
    }
    return _sxB;
}


- (void)sexAC:(UIButton *)sender{
    sender.selected = !sender.selected;
    NSString *sex;
    if (sender.selected){
        self.sex = @"0";
    }else{
        self.sex = @"1";
    }
     [self xw_postNotificationWithName:HomeLoadNotice userInfo:@{@"sex":self.sex,@"online":self.online,@"cities":self.cities}];
    
}


- (void)conditionAC:(UIButton *)sender{
    sender.selected = !sender.selected;
    if(sender.selected){
        sender.backgroundColor = [UIColor whiteColor];
        self.online = @"1";
    }else{
        sender.backgroundColor = [UIColor clearColor];
        self.online = @"0";

    }
    [self xw_postNotificationWithName:HomeLoadNotice userInfo:@{@"sex":self.sex,@"online":self.online,@"cities":self.cities}];
    
}

- (IBAction)titleBAC:(id)sender {
    
//    if (self.menumHidden) {
//        //显示
//        
//        self.menum.height = 0;
//        [UIView animateWithDuration:.35 animations:^{
//            self.maskView.hidden = NO;
//            self.menum.height = 300;
//            [self.view layoutIfNeeded];
//
//        } completion:^(BOOL finished) {
//            self.menumHidden = NO;
//        }];
//        
//    }else{
//        
//        [UIView animateWithDuration:.35 animations:^{
//            self.maskView.hidden = YES;
//            self.menum.height = 0;
//        } completion:^(BOOL finished) {
//            self.menumHidden = YES;
//        }];
//        
//    }
    
    
}


#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    
    [self.listVCContainerView didClickSelectedItemAtIndex:index];
    
    
    
}

//- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
//    [self.listVCContainerView didClickSelectedItemAtIndex:index];
//}
//
//- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
//
//
//    [self.listVCContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
//}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    
    HomeSubVC *vc = [[HomeSubVC alloc] init];
    vc.sex = self.sex;
    vc.online = self.online;
    vc.cities = self.cities;
    vc.index = index;
    return vc;
    
    //    listVC.naviController = self.navigationController;
    
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}


#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    MenumCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MenumCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


- (IBAction)loginAC:(id)sender {
    LogingViewController *vc = [[LogingViewController alloc]init];
    vc.modalPresentationStyle = 0;
    //    vc.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:vc animated:YES completion:nil];
}



@end
