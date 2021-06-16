//
//  SeletImageCell.h
//  BHGY
//
//  Created by liuxiang on 2020/7/23.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SeletImageCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,strong) NSMutableArray *assets;
@property(nonatomic,copy) void(^reloadSectionBlock)(void);

- (CGFloat)cellheight;
@end

NS_ASSUME_NONNULL_END
