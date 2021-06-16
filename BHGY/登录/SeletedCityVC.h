//
//  SeletedCityVC.h
//  BHGY
//
//  Created by liuxiang on 2020/7/13.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BaseViewController.h"
#import "MenumCell.h"
#import "SubMenumCell.h"
#import "CityDoneCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SeletedCityVC : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy) void(^cityBlock)(NSArray *citys);

@end

NS_ASSUME_NONNULL_END
