//
//  BuyingmembersVC.h
//  BHGY
//
//  Created by 小呗出行 on 2020/7/27.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BuyingmembersVC : BaseViewController
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *mutbalearray;
@property (nonatomic,strong) NSString *isfirst; //第一次进来加载
@property (nonatomic,strong) UILabel *moneylabel; //金钱label
@property (nonatomic,strong) NSString *moneysring; //接口调用时传输的金额

@end

NS_ASSUME_NONNULL_END
