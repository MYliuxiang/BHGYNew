//
//  RLikeAlert.h
//  BHGY
//
//  Created by liuxiang on 2020/7/20.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "LxCustomAlert.h"
#import "RLikeCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface RLikeAlert : LxCustomAlert<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
- (IBAction)canleAC:(id)sender;
- (IBAction)doneAC:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (strong,nonatomic) NSMutableArray *doneList;

@property(nonatomic,copy) void(^rlikeBlock)(NSArray *rlikes);

@property(nonatomic,strong) NSArray *contents;
- (instancetype)initWithContents:(NSArray *)contents withDoneList:(NSArray *)doneList;


@end

NS_ASSUME_NONNULL_END
