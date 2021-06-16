//
//  MyImagesCell.h
//  BHGY
//
//  Created by liuxiang on 2020/7/25.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyImagesCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIImageView *stateI;
@property (weak, nonatomic) IBOutlet UILabel *stateL;
@property (weak, nonatomic) IBOutlet UILabel *moreLab;

@end

NS_ASSUME_NONNULL_END
