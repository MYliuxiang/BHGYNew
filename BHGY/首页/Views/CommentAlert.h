//
//  CommentAlert.h
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "LxCustomAlert.h"
#import "CommentCell.h"
#import "MyCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentAlert : LxCustomAlert<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIButton *commentB;
@property (weak, nonatomic) IBOutlet UIButton *jubB;
@property(nonatomic,strong) NSArray *contents;
@property(nonatomic,copy) void(^juBblock)(void);

- (instancetype)initWithContents:(NSArray *)contents;

@end

NS_ASSUME_NONNULL_END
