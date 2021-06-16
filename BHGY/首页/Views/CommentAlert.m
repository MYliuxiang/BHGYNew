//
//  CommentAlert.m
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "CommentAlert.h"

@implementation CommentAlert
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
        self.missTapGesture.enabled = NO;
        
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
    
    self.layout.itemSize = CGSizeMake(45, 50);
    self.layout.minimumLineSpacing = 30;
    self.layout.minimumInteritemSpacing = 10;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellWithReuseIdentifier:@"CommentCellID"];
    
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
    
    CommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommentCellID" forIndexPath:indexPath];
    MyCommentModel *model = self.contents[indexPath.row];
    cell.titleL.text = model.label;
    cell.countL.text = [HandleTool getCount:model.num];
    if (model.num == 0) {
        cell.countL.backgroundColor = [UIColor colorWithHexString:@"#ECF0F1"];
    }else{
        cell.countL.backgroundColor = Color_Theme;

    }
    
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
