//
//  MyProCell.h
//  BHGY
//
//  Created by liuxiang on 2020/7/13.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentView.h"
#import "DynamicModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyProCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIImageView *iconI;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property(nonatomic,strong) DynamicModel *model;
@property(nonatomic,strong) ContentView *cView;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UIImageView *likeI;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIImageView *stateI;

@property (weak, nonatomic) IBOutlet UIImageView *sexI;
@property (weak, nonatomic) IBOutlet UILabel *nameL;

@end

NS_ASSUME_NONNULL_END
