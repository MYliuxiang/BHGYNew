//
//  SPhotoCell.h
//  BHGY
//
//  Created by liuxiang on 2020/7/8.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPhotoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIButton *deletedB;
@property (nonatomic, strong) void ((^btnClick)());

- (IBAction)deletedAC:(id)sender;

@end

NS_ASSUME_NONNULL_END
