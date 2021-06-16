//
//  MyPhotoCell.h
//  BHGY
//
//  Created by liuxiang on 2020/7/13.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyImagesCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyPhotoCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) NSMutableArray *images;

@property (nonatomic,strong) NSMutableArray *photos;

@property(nonatomic,copy) void(^reloadPhotos)(NSArray *photos);

@property(nonatomic,copy) void(^reloadDatas)(void);


@end

NS_ASSUME_NONNULL_END
