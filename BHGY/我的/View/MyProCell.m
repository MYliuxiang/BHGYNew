//
//  MyProCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/13.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "MyProCell.h"

@implementation MyProCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cView = [[ContentView alloc] init];
    [self.contentView addSubview:self.cView];
    [self.btn1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
    [self.btn2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
    [self.btn3 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
    [self.btn4 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
    [self creatCollection];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DynamicModel *)model
{
     _model = model;
       [self.iconI sd_setImageWithURL:[NSURL URLWithString:[HandleTool getImageUrlStr:model.userInfo.avatar]] placeholderImage:[UIImage imageNamed:@"编组 2-1"]];
       if (model.userInfo.sex == 0) {
           //女
           self.sexI.image = [UIImage imageNamed:@"编组 4备份 6-1"];
       }else{
           self.sexI.image = [UIImage imageNamed:@"编组 4备份 6-1"];
       }
       self.nameL.text = model.userInfo.nickName;
       if (model.userInfo.goddess == 1) {
              self.stateI.image = [UIImage imageNamed:@"编组 8"];
          }else{
              if (model.userInfo.realHuman == 1) {
                  self.stateI.image = [UIImage imageNamed:@"编组 7"];
              }else{
                  if (model.userInfo.vip == 1) {
                      self.stateI.image = [UIImage imageNamed:@"编组 15(1)"];
                  }
              }
          }
       self.timeL.text = model.createTime;
       self.cView.model = model;
       self.cView.sd_layout.topSpaceToView(self.iconI, 10).leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15);
       [self.btn1 setTitle:[NSString stringWithFormat:@"%d",model.commentNum] forState:UIControlStateNormal];
       [self.btn2 setTitle:[NSString stringWithFormat:@"%d",model.praiseNum] forState:UIControlStateNormal];
       [self.btn3 setTitle:[NSString stringWithFormat:@"报名（%d）",model.entryNum] forState:UIControlStateNormal];
       self.btn4.hidden = YES;
       if(model.type == 3){
           //3，动态
           self.btn3.hidden = YES;
           CGFloat width = kScreenWidth / 2 ;
           self.btn1.sd_layout.topSpaceToView(self.cView, 10).heightIs(60).widthIs(width).leftSpaceToView(self.contentView,  0);
           self.btn2.sd_layout.topSpaceToView(self.cView, 10).heightIs(60).widthIs(width).leftSpaceToView(self.btn1, 0);
       }else{
       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
             [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
             [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
           NSDate *date = [formatter dateFromString:model.meetingTime];
           if ([date isLaterThanDate:[NSDate date]]) {
               //已经结束
               CGFloat width = kScreenWidth / 4 ;
                      //1，节目；2，连麦；
               self.btn1.sd_layout.topSpaceToView(self.cView, 10).heightIs(60).widthIs(width).leftSpaceToView(self.contentView,  0);
               self.btn2.sd_layout.topSpaceToView(self.cView, 10).heightIs(60).widthIs(width).leftSpaceToView(self.btn1, 0);
               self.btn3.sd_layout.topSpaceToView(self.cView, 10).heightIs(60).widthIs(width).leftSpaceToView(self.btn2, 0);
               self.btn4.sd_layout.topSpaceToView(self.cView, 10).heightIs(60).widthIs(width).leftSpaceToView(self.btn3, 0);
               self.btn3.hidden = NO;
               self.btn4.hidden = NO;
           }else{
               CGFloat width = kScreenWidth / 3 ;
                      //1，节目；2，连麦；
               self.btn1.sd_layout.topSpaceToView(self.cView, 10).heightIs(60).widthIs(width).leftSpaceToView(self.contentView,  0);
               self.btn2.sd_layout.topSpaceToView(self.cView, 10).heightIs(60).widthIs(width).leftSpaceToView(self.btn1, 0);
               self.btn3.sd_layout.topSpaceToView(self.cView, 10).heightIs(60).widthIs(width).leftSpaceToView(self.btn2, 0);
               self.btn3.hidden = NO;
               self.btn4.hidden = YES;
           }
       }
       [self setupAutoHeightWithBottomView:self.cView bottomMargin:80];
 
       [self layoutBtns];
    
}

- (void)layoutBtns{
    [self.btn1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
      [self.btn2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
      [self.btn3 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
      [self.btn4 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
    
}

- (void)creatCollection
{
    
    self.layout.itemSize = CGSizeMake(27, 27);
    self.layout.minimumLineSpacing = 6;
    self.layout.minimumInteritemSpacing = 6;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SPhotoCell" bundle:nil] forCellWithReuseIdentifier:@"SPhotoCellID"];
    
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.praiseInfoList;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SPhotoCellID" forIndexPath:indexPath];
    PraiseInfo *info = self.model.praiseInfoList[indexPath.row];
    cell.deletedB.hidden = YES;
    [cell.img sd_setImageWithURL:[NSURL URLWithString:info.userInfo.avatar] placeholderImage:[UIImage imageNamed:@"编组 2备份"]];
    return cell;
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}




@end
