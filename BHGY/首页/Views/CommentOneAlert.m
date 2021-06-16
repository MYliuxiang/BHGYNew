//
//  CommentOneAlert.m
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "CommentOneAlert.h"

@implementation CommentOneAlert

- (instancetype)initWithContents:(NSArray *)contents{
 
    self = [super init];
    if (self) {
        
        [self setupAutoHeightWithBottomView:self.jubB bottomMargin:15];
        self.width = 320;
        self.layer.cornerRadius = 7.5;
        self.layer.masksToBounds = YES;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.contents = contents;
        [self creatCollection];
        self.commentB.layer.cornerRadius = 20;
        self.commentB.layer.masksToBounds = YES;
    }
    return self;
    
    
}

- (IBAction)comentAC:(id)sender {
}
- (IBAction)jubAC:(id)sender {
    if (self.juBblock != nil) {
        self.juBblock();
    }
    [self disMiss];
}

- (IBAction)closeAC:(id)sender {
    [self disMiss];

}


- (void)creatCollection
{
    
    self.layout.itemSize = CGSizeMake(50, 28);
    self.layout.minimumLineSpacing = 30;
    self.layout.minimumInteritemSpacing = 20;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CommentOneCell" bundle:nil] forCellWithReuseIdentifier:@"CommentOneCellID"];
    
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.contents.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CommentOneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommentOneCellID" forIndexPath:indexPath];
    cell.titleL.text = self.contents[indexPath.row];
    return cell;
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        UIView *view = [UIView new];
        reusableview = view;
    }
    return reusableview;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}



@end
