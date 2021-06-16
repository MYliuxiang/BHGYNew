//
//  BuyingmeCell.h
//  BHGY
//
//  Created by 小呗出行 on 2020/7/27.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyingneModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BuyingmeCell : UICollectionViewCell
@property (nonatomic,strong) UILabel *timelabel;
@property (nonatomic,strong) UILabel *moneylabel;
@property (nonatomic,strong) UILabel *yuemoneylabel;
@property (nonatomic,strong) UIImageView *bjimageview;
@property (nonatomic,strong) UIImageView *icoimageview;


-(void) setmodel:(BuyingneModel *)model;
@end

NS_ASSUME_NONNULL_END
