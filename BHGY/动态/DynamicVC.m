//
//  DynamicVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/2.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "DynamicVC.h"
#import "ReleaseDynamicVC.h"


@interface DynamicVC ()<SDCycleScrollViewDelegate,JXCategoryViewDelegate,JXPagerViewDelegate,WMZDropMenuDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) SDCycleScrollView *cycleView;
@property (strong, nonatomic) IBOutlet UIView *sectionHeaderV;
@property (nonatomic, strong) JXPagerView *pagerView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic,strong) UIButton *doneBtn;
@property (nonatomic,strong) UIButton *sxB;
@property (nonatomic,strong) WMZDropDownMenu *menu;

@property (nonatomic,strong) UIButton *releaseB;
@property (nonatomic,strong) UIButton *releaseDynamicB;
@property (nonatomic,strong) UIButton *releasepProgramB;

@property (nonatomic,assign) BOOL releaseOpen;

@property(nonatomic,strong)SubDynamicVC *subVC;

@property(nonatomic,strong)NSMutableArray *themList;
@property(nonatomic,strong)NSMutableArray *cityList;

@property(nonatomic,copy)NSString *cities;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *them;




@end

@implementation DynamicVC

- (UIButton *)releaseB{
    
    if (_releaseB == nil) {
        _releaseB = [UIButton buttonWithType:UIButtonTypeCustom];
        _releaseB.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        [_releaseB setTitle:@"发布" forState:UIControlStateNormal];
        [_releaseB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _releaseB.backgroundColor = Color_Theme;
        _releaseB.layer.cornerRadius = 55 / 2.0;
        _releaseB.layer.masksToBounds = YES;
        [_releaseB addTarget:self action:@selector(releaseAC:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _releaseB;
    
}

- (UIButton *)releaseDynamicB{
    
    if (_releaseDynamicB == nil) {
        _releaseDynamicB = [UIButton buttonWithType:UIButtonTypeCustom];
        _releaseDynamicB.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        [_releaseDynamicB setImage:[UIImage imageNamed:@"编组16"] forState:UIControlStateNormal];
        [_releaseDynamicB addTarget:self action:@selector(releaseDynamicAC:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _releaseDynamicB;
    
}


- (UIButton *)releasepProgramB{
    
    if (_releasepProgramB == nil) {
        _releasepProgramB = [UIButton buttonWithType:UIButtonTypeCustom];
        _releasepProgramB.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        [_releasepProgramB setImage:[UIImage imageNamed:@"编组 14"] forState:UIControlStateNormal];
        [_releasepProgramB addTarget:self action:@selector(releaseProgramAC:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _releasepProgramB;
    
}

- (void)releaseAC:(UIButton *)sender{
    if (self.releaseOpen) {
     
        [UIView animateWithDuration:.35 animations:^{
                   
                   [self.releaseDynamicB mas_remakeConstraints:^(MASConstraintMaker *make) {
                       make.size.mas_equalTo(CGSizeMake(45, 45));
                       make.center.mas_equalTo(self.releaseB);
                   }];
                   
                   [self.releasepProgramB mas_remakeConstraints:^(MASConstraintMaker *make) {
                       make.size.mas_equalTo(CGSizeMake(45, 45));
                       make.center.mas_equalTo(self.releaseB);

                   }];
                   
                   [self.view layoutIfNeeded];

                   
               } completion:^(BOOL finished) {
                   self.releaseOpen = NO;
                   
               }];
        
    }else{
        //收缩
             [UIView animateWithDuration:.35 animations:^{
                 
                 [self.releaseDynamicB mas_remakeConstraints:^(MASConstraintMaker *make) {
                          make.size.mas_equalTo(CGSizeMake(45, 45));
                     make.right.mas_equalTo(self.releaseB.mas_left).offset(-10);
                     make.bottom.mas_equalTo(self.releaseB.mas_bottom).offset(-10);
                      }];
                   
                 [self.releasepProgramB mas_remakeConstraints:^(MASConstraintMaker *make) {
                          make.size.mas_equalTo(CGSizeMake(45, 45));
                     make.right.mas_equalTo(self.releaseB.mas_right).offset(-10);
                     make.bottom.mas_equalTo(self.releaseB.mas_top).offset(-10);
                 }];
                 [self.view layoutIfNeeded];
             } completion:^(BOOL finished) {
                 self.releaseOpen = YES;
             }];
       
    }
    
}


- (void)releaseDynamicAC:(UIButton *)sender{
    
    ReleaseDynamicVC *vc = [[ReleaseDynamicVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [UIView animateWithDuration:.35 animations:^{
        
        [self.releaseDynamicB mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(45, 45));
            make.center.mas_equalTo(self.releaseB);
        }];
        
        [self.releasepProgramB mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(45, 45));
            make.center.mas_equalTo(self.releaseB);
            
        }];
        
        [self.view layoutIfNeeded];
        
        
    } completion:^(BOOL finished) {
        self.releaseOpen = NO;
        
    }];
    
}


- (void)releaseProgramAC:(UIButton *)sender{
    
    [UIView animateWithDuration:.35 animations:^{
        
        [self.releaseDynamicB mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(45, 45));
            make.center.mas_equalTo(self.releaseB);
        }];
        
        [self.releasepProgramB mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(45, 45));
            make.center.mas_equalTo(self.releaseB);
            
        }];
        
        [self.view layoutIfNeeded];
        
        
    } completion:^(BOOL finished) {
        self.releaseOpen = NO;
        
    }];
    
    
    BADataEntity *entity = [BADataEntity new];
          entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_meetingSubject_findAll];
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
                 
                 MoreAlert *alert = [[MoreAlert alloc] initWithContents:marray];
                 alert.clickBlcok = ^(NSInteger index) {
                     ReleaseProgramVC *vc = [[ReleaseProgramVC alloc] init];
                     vc.themStr = marray[index];
                     [self.navigationController pushViewController:vc animated:YES];
                 };
                 alert.btnColor = Color_6;
                 alert.titleL.text = @"选择节目主题";
                 [alert show];
               
           }
           
       } failureBlock:^(NSError *error) {
           
           
       } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
           
       }];
    
    
    
   
    
}

- (SDCycleScrollView *)cycleView
{
    if (_cycleView == nil) {
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 10, kScreenWidth - 20,kScreenWidth / 375 * 135) delegate:self placeholderImage:nil];
        _cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//        _cycleView.pageDotImage = [UIImage imageNamed:@"switch opacity"];
//        _cycleView.currentPageDotImage = [UIImage imageNamed:@"switch"];
        _cycleView.backgroundColor = [UIColor clearColor];

    }
    return _cycleView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"动态";
    self.themList = [NSMutableArray array];
    self.cityList = [NSMutableArray array];
    self.sex = @"不限性别";
    self.them = @"主题分类";
    self.cities = @"不限地区";
    
    CityModel *model = [[CityModel alloc] init];
    model.name = @"不限地区";
    [self.cityList insertObject:model atIndex:0];
    
    ServerModel *smodel = [[ServerModel alloc] init];
    smodel.name = @"主题分类";
    [self.themList insertObject:smodel atIndex:0];
    
    [self loadCityList];
    [self loadThemList];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth / 375 * 135 + 20)];
    [self.headerView addSubview:self.cycleView];
    self.cycleView.localizationImageNamesGroup = @[[UIImage imageNamed:@"位图备份 4"],[UIImage imageNamed:@"位图备份 4"]];
    
    
    _pagerView = [[JXPagerView alloc] initWithDelegate:self];
    [self.view addSubview:self.pagerView];
    
    if (@available(iOS 11.0, *)) {
        self.pagerView.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
       }else{
           self.automaticallyAdjustsScrollViewInsets = NO;
       }
    
    [self.view addSubview:self.releaseDynamicB];
    [self.view addSubview:self.releasepProgramB];
    [self.view addSubview:self.releaseB];

    
    [self.releaseB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(55, 55));
        make.centerY.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view).offset(-10);
    }];
    
    [self.releaseDynamicB mas_makeConstraints:^(MASConstraintMaker *make) {
           make.size.mas_equalTo(CGSizeMake(45, 45));
           make.center.mas_equalTo(self.releaseB);
       }];
    
    [self.releasepProgramB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.center.mas_equalTo(self.releaseB);

       }];
    
    self.pagerView.mainTableView.mj_header = [LxResfreshHeader headerWithRefreshingBlock:^{
        self.pageNum = 1;
        [self loadData];
    }];
    
    self.pagerView.mainTableView.mj_footer = [LxRefreshFooter footerWithRefreshingBlock:^{
        [self loadData];
        
    }];
    
    [self.pagerView.mainTableView.mj_header beginRefreshing];
    
    

    
}

- (void)loadCityList{
    
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_province_findAll];
    entity.needCache = YES;
    entity.parameters = nil;
    
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            self.cityList = [CityModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            CityModel *model = [[CityModel alloc] init];
            model.name = @"不限地区";
            [self.cityList insertObject:model atIndex:0];
            
            NSMutableArray *array = [NSMutableArray array];
            for (CityModel *model in self.cityList) {
                [array addObject:model.name];
            }
            [self.menu updateData:array AtDropIndexPathSection:2 AtDropIndexPathRow:0];
            
        }
        
    } failureBlock:^(NSError *error) {
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

- (void)loadThemList{
    BADataEntity *entity = [BADataEntity new];
       entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_meetingSubject_findAll];
       entity.needCache = YES;
       entity.parameters = nil;
       
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            self.themList = [ServerModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            ServerModel *model = [[ServerModel alloc] init];
            model.name = @"主题分类";
            [self.themList insertObject:model atIndex:0];
            
            NSMutableArray *array = [NSMutableArray array];
            for (CityModel *model in self.themList) {
                [array addObject:model.name];
            }
            [self.menu updateData:array AtDropIndexPathSection:0 AtDropIndexPathRow:0];
            
        }
        
    } failureBlock:^(NSError *error) {
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (void)loadData{
    
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_dynamic_find];
    entity.needCache = NO;
    
    NSString *sex;
    if ([self.sex isEqualToString:@"男"]) {
        sex = @"1";
    }else if ([self.sex isEqualToString:@"女"]){
        sex = @"0";
    }else{
        sex = @"-1";
    }
    NSString *subject;
    if ([self.them isEqualToString:@"主题分类"]) {
        subject = @"";
    }else{
        subject = self.them;
    }
    NSString *city;
    if ([self.cities isEqualToString:@"不限地区"]) {
        city = @"";
    }else{
        city = self.cities;
    }
    
    entity.parameters = @{@"pageNum":@(self.pageNum),@"pageSize":@(PageSize),@"sex":sex,@"subject":subject,@"city":city};
    self.subVC.tableView.ly_emptyView = self.nodataView;
    [self.subVC.tableView ly_startLoading];
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            
            NSArray *models = [DynamicModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"content"]];
            if (self.pageNum == 1) {
                [self.subVC.dataList removeAllObjects];
            }
            
            [self.subVC.dataList addObjectsFromArray:models];
            [self.subVC.tableView reloadData];
            
            self.pageNum++;
            
            if ([result[@"data"][@"last"] boolValue]) {
                [self.pagerView.mainTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.pagerView.mainTableView.mj_footer endRefreshing];
            }
            [self.pagerView.mainTableView.mj_header endRefreshing];
            [self.subVC.tableView ly_endLoading];
            
        }else{
            [self.pagerView.mainTableView.mj_footer endRefreshing];
            [self.pagerView.mainTableView.mj_header endRefreshing];
            [self.subVC.tableView ly_endLoading];
            
        }
        

        
    } failureBlock:^(NSError *error) {
        [self.pagerView.mainTableView.mj_footer endRefreshing];
        [self.pagerView.mainTableView.mj_header endRefreshing];
        [self.subVC.tableView ly_endLoading];
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
   
    
}


#pragma mark WMZDropMenuDelegate
- (NSArray*)titleArrInMenu:(WMZDropDownMenu *)menu{
    
    return @[
            @{@"name":@"主题分类",@"normalImage":@"路径备份",@"selectImage":@"路径备份"},
            @{@"name":@"不限性别",@"normalImage":@"路径备份",@"selectImage":@"路径备份"},
            @{@"name":@"不限地区",@"normalImage":@"路径备份",@"selectImage":@"路径备份"},
           
       ];
    
}


- (NSInteger)menu:(WMZDropDownMenu *)menu numberOfRowsInSection:(NSInteger)section{
   if (section == 0){
        return 1;
    }else if (section == 1){
        return 1;
    }else{
        return 2;
    }

}


- (NSArray *)menu:(WMZDropDownMenu *)menu dataForRowAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath{
    
    
    
      if (dropIndexPath.section == 0){
          NSMutableArray *array = [NSMutableArray array];
          for (ServerModel *model in self.themList) {
              [array addObject:model.name];
          }
          return array;
          
          
         
      }else if (dropIndexPath.section == 1){
          return @[@"男",@"女",@"不限性别"];
      }else if (dropIndexPath.section == 2){
             NSMutableArray *array = [NSMutableArray array];
                    for (CityModel *model in self.cityList) {
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
    if (dropIndexPath.section == 2) {
        return 2;
    }
    return 1;
}

- (void)menu:(WMZDropDownMenu *)menu didSelectTitleInSection:(NSInteger)section btn:(WMZDropMenuBtn*)selectBtn networkBlock:(MenuAfterTime)block{
    

    int height = kScreenWidth / 375 * 135 + 20;
    if (self.pagerView.mainTableView.contentOffset.y < height ) {
        [self.pagerView.mainTableView setContentOffset:CGPointMake(0,kScreenWidth / 375 * 135 + 20 + 37) animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            block();


        });
    }else{
        block();


    }
   
   
}
/*
*是否关联 其他标题 即选中其他标题 此标题会不会取消选中状态 default YES
*/
- (BOOL)menu:(WMZDropDownMenu *)menu dropIndexPathConnectInSection:(NSInteger)section{
    return NO;
}

//- (NSDictionary*)menu:(WMZDropDownMenu *)menu  customTitleInSection:(NSInteger)section withTitleBtn:(WMZDropMenuBtn*)menuBtn{
//    if (section == 1) {
//        //选中中间清除其他所有选中
//        menuBtn.clear = YES;
//    }
//    return @{};
//}


/*
*互斥的标题数组 即互斥不能同时选中 返回标题对应的section (配合关联代理使用更加)
*/
//- (NSArray*)mutuallyExclusiveSectionsWithMenu:(WMZDropDownMenu *)menu{
//    return @[@(0),@(1)];
//}



- (CGFloat)menu:(WMZDropDownMenu *)menu heightAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath AtIndexPath:(NSIndexPath *)indexpath{
        return 42;
   
}

- (MenuUIStyle)menu:(WMZDropDownMenu *)menu uiStyleForRowIndexPath:(WMZDropIndexPath *)dropIndexPath{
    
    return MenuUITableView;
}

- (MenuHideAnimalStyle)menu:(WMZDropDownMenu *)menu hideAnimalStyleForRowInSection:(NSInteger)section{
    
    return MenuHideAnimalNone;
}

- (MenuShowAnimalStyle)menu:(WMZDropDownMenu *)menu showAnimalStyleForRowInSection:(NSInteger)section{
    
      return MenuShowAnimalBottom;
}


- (UITableViewCell*)menu:(WMZDropDownMenu *)menu cellForUITableView:(WMZDropTableView *)tableView AtIndexPath:(NSIndexPath *)indexpath dataForIndexPath:(WMZDropTree *)model{
    if (tableView.dropIndex.section == 1 || tableView.dropIndex.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GanJiTableViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GanJiTableViewCell"];
            
            UIView *view = [UIView new];
            view.backgroundColor = Color_line;
            [cell.contentView addSubview:view];
            view.frame = CGRectMake(0, 41.5, kScreenWidth, 0.5);
            
        }
        cell.textLabel.text = model.name;
        cell.textLabel.textColor = model.isSelected?Color_Theme:Color_3;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        return cell;
    }else{
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
  
    
    return nil;
}
- (BOOL)menu:(WMZDropDownMenu *)menu closeWithTapAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath{
   
    if (dropIndexPath.section == 0)  return YES;
    else if (dropIndexPath.section == 1) return YES;
    else if (dropIndexPath.section == 2 && dropIndexPath.row == 1) return YES;
    return NO;
}

-  (void)menu:(WMZDropDownMenu *)menu didSelectRowAtDropIndexPath:(WMZDropIndexPath *)dropIndexPath dataIndexPath:(NSIndexPath *)indexpath data:(WMZDropTree *)data{
    
    if (dropIndexPath.section == 2 && dropIndexPath.row == 1) {
           [self.sxB setTitle:data.name forState:UIControlStateNormal];
//        if (![self.cities isEqualToString:data.name]) {
//            self.cities = data.name;
//            [self.pagerView.mainTableView.mj_header beginRefreshing];
//        }
        
    }
       
    if (dropIndexPath.section == 2 && dropIndexPath.row == 0) {
        
        CityModel *model = self.cityList[indexpath.row];
        NSMutableArray *array = [NSMutableArray array];
        if (model.children.count == 0) {
            [self.sxB setTitle:data.name forState:UIControlStateNormal];
//            if (![self.cities isEqualToString:data.name]) {
//                self.cities = data.name;
//                [self.pagerView.mainTableView.mj_header beginRefreshing];
//            }

            [menu closeWith:dropIndexPath row:indexpath.row data:data];
        }
    for (CityModel *smodel in model.children) {
        [array addObject:smodel.name];
    }
    [self.menu updateData:array ForRowAtDropIndexPath:dropIndexPath];
    
    }
   
 
    if (dropIndexPath.section == 0) {
//        if (![self.them isEqualToString:data.name]) {
//            self.them = data.name;
//            [self.pagerView.mainTableView.mj_header beginRefreshing];
//        }

    }
    
    if (dropIndexPath.section == 1) {
        
//        if (![self.sex isEqualToString:data.name]) {
//            self.sex = data.name;
//            [self.pagerView.mainTableView.mj_header beginRefreshing];
//        }

//        if ([self.sex isEqualToString:@"不限性别"]) {
//
//            [self.menu changeTitleConfig: @{@"name":@"333",@"normalImage":@"路径备份",@"selectImage":@"路径备份"} withBtn:self.menu.selectTitleBtn];
//            self.menu.selectTitleBtn.selected = NO;
//            [self.menu changeNormalConfig:@{} withBtn:self.menu.selectTitleBtn];
//        }

    }
}

- (void)menu:(WMZDropDownMenu *)menu closeWithBtn:(WMZDropMenuBtn*)selectBtn   index:(NSInteger )index
{
    WMZDropTree *data = menu.selectArr.lastObject;
    if (data == nil){
        return;
    }

    if (index == 0) {
        if (![self.them isEqualToString:data.name]) {
            self.them = data.name;
            [self.pagerView.mainTableView.mj_header beginRefreshing];
           
        }
    }
    
    if (index == 1) {
        
        if (![self.sex isEqualToString:data.name]) {
            self.sex = data.name;
            [self.pagerView.mainTableView.mj_header beginRefreshing];
        }
        
//        if ([self.sex isEqualToString:@"不限性别"] ) {
//            [self.menu changeNormalConfig:@{} withBtn:self.menu.selectTitleBtn];
//        }
    }
    if (index == 2) {
        if (![self.cities isEqualToString:data.name]) {
            self.cities = data.name;
            [menu hideAnimal:MenuHideAnimalTop view:menu.dataView durtion:.35 block:^{
                [self.pagerView.mainTableView.mj_header beginRefreshing];
                
            }];
        }
    }
}


- (UIView*)menu:(WMZDropDownMenu *)menu userInteractionFootViewInSection:(NSInteger)section{
    if (section == 2){
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
        
//        menu.selectArr.firstObject
      
        if (self.sxB.titleLabel.text.length == 0){
            self.sxB.hidden = YES;
        }else{
            self.sxB.hidden = NO;
        }

          
           return userInteractionFootView;
    }
    return nil;
   
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


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.pagerView.frame = CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight - Height_NavBar - Height_TabBar);
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    

}



#pragma mark - JXPagerViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    
    
    return self.headerView;

}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
   
    int height = kScreenWidth / 375 * 135 + 20;
    return height;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    
        return 37;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView
{
    WMZDropMenuParam *param =
             MenuParam()
           .wMainRadiusSet(0)
             .wMenuTitleEqualCountSet(3)
             .wCollectionViewCellSelectTitleColorSet(Color_Theme)
             .wCollectionViewCellTitleColorSet(UIColor.blackColor)
             .wCollectionViewSectionRecycleCountSet(3)
             .wMaxHeightScaleSet(0.6)
             .wBorderShowSet(NO)
             .wPopOraignYSet(Height_NavBar + 37)
           .wCellSelectShowCheckSet(NO);
             
    self.menu = [[WMZDropDownMenu alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 37) withParam:param];
    _menu.tableViewHeadSection = 0;
    _menu.delegate = self;
    [self.sectionHeaderV addSubview:_menu];
    
   
    
    return self.sectionHeaderV;
    
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    
    return 1;
    
}



- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    
//
//    SubDynamicVC *hVC = [[SubDynamicVC alloc] init];
//    [self addChildViewController:hVC];
    return self.subVC;
    
}

- (SubDynamicVC *)subVC{
    if (_subVC == nil) {
        _subVC = [SubDynamicVC new];
        
    }
    return _subVC;
}

- (void)mainTableViewDidScroll:(UIScrollView *)scrollView{
    
}





@end
