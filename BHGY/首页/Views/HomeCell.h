//
//  HomeCell.h
//  BHGY
//
//  Created by liuxiang on 2020/7/6.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeCell : UICollectionViewCell<MenuViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *labB1;
@property (weak, nonatomic) IBOutlet UIView *labV;
@property (weak, nonatomic) IBOutlet UIView *stateL;
@property (weak, nonatomic) IBOutlet UIButton *labB2;
@property (weak, nonatomic) IBOutlet UIButton *labB3;
@property (weak, nonatomic) IBOutlet UIButton *labB4;
@property (weak, nonatomic) IBOutlet UIButton *menuB;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *apL;
@property (weak, nonatomic) IBOutlet UIImageView *stateI;
@property (weak, nonatomic) IBOutlet UILabel *onlinestateL;
@property (weak, nonatomic) IBOutlet UIView *onlineView;

@property(nonatomic,strong) HomeModel *model;

@property(nonatomic,copy) void(^blackNameBlock)(void);
@property(nonatomic,copy) void(^cancleBlock)(void);


@end

NS_ASSUME_NONNULL_END
