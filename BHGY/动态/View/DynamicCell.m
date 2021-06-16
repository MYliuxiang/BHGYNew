//
//  DynamicCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/8.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "DynamicCell.h"

@implementation DynamicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cView = [[ContentView alloc] init];
    [self.contentView addSubview:self.cView];
  
    self.iconI.layer.cornerRadius = 7.5;
    self.iconI.layer.masksToBounds = YES;

    
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

- (IBAction)moreAC:(id)sender {
    
      NSArray *array;
      if (self.model.iscollection == 0){
           array = @[@"收藏",@"拉黑"];
       }else{
           array = @[@"取消收藏",@"拉黑"];
           
       }
       ArrowheadMenu *VC = [[ArrowheadMenu alloc] initCustomArrowheadMenuWithTitle:array icon:nil menuUnitSize:CGSizeMake(62, 22) menuFont:[UIFont systemFontOfSize:10] menuFontColor:[UIColor colorWithHexString:@"#666666"] menuBackColor:[UIColor whiteColor] menuSegmentingLineColor:[UIColor colorWithHexString:@"#D8D8D8"] distanceFromTriggerSwitch:-5 menuArrowStyle:MenuArrowStyleTriangle menuPlacements:ShowAtBottom showAnimationEffects:ShowAnimationZoom];
       
       VC.delegate = self;
       [VC presentMenuView:self.menuB];
}

- (void)menu:(BaseMenuViewController *)menu didClickedItemUnitWithTag:(NSInteger)tag andItemUnitTitle:(NSString *)title{
    if([title isEqualToString:@"收藏"]){
        
        [self collectionAC];
    }
    
    if ([title isEqualToString:@"取消收藏"]) {
        [self cancleCollectionAC];
    }
    if ([title isEqualToString:@"拉黑"]) {
        [self addBlackNameAC];
    }
    
}

- (void)collectionAC{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userFavorite_add];
    entity.needCache = NO;
    
    entity.parameters = @{@"userId":self.model.userInfo.uid};
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            
            [MBProgressHUD showError:@"收藏成功" toView:lxWindow];
            self.model.iscollection = 1;
          
        }
        
    } failureBlock:^(NSError *error) {
       
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

- (void)cancleCollectionAC{
    BADataEntity *entity = [BADataEntity new];
       entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userFavorite_remove];
       entity.needCache = NO;
       
    entity.parameters = @{@"userId":self.model.userInfo.uid};
       [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
       [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
           NSDictionary *result = response;
           if ([result[@"code"] intValue] == 0) {
               
               [MBProgressHUD showError:@"取消收藏成功" toView:lxWindow];
               self.model.iscollection = 0;
               if (self.cancleBlock) {
                   self.cancleBlock();
               }
           }
           
       } failureBlock:^(NSError *error) {
          
           
       } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
           
       }];
    
}

- (void)addBlackNameAC{
    
    BADataEntity *entity = [BADataEntity new];
          entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_blacklist_add];
          entity.needCache = NO;
          
    entity.parameters = @{@"userId":self.model.userInfo.uid};
          [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
          [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
              NSDictionary *result = response;
              if ([result[@"code"] intValue] == 0) {
                  
                  [MBProgressHUD showError:@"拉黑成功" toView:lxWindow];
                  if (self.blackNameBlock) {
                      self.blackNameBlock();
                  }
                
              }
              
          } failureBlock:^(NSError *error) {
             
              
          } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
              
          }];
}
- (IBAction)likeAC:(id)sender {
    if ([self.model.userInfo.uid isEqualToString:[LoginManger sharedManager].currentLoginModel.uid]) {
        //自己的动态
    }else{
        
        
        BADataEntity *entity = [BADataEntity new];
        entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_dynamic_praise];
        entity.needCache = NO;
        entity.parameters = @{@"id":self.model.uid};
        [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
        [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
            NSDictionary *result = response;
            if ([result[@"code"] intValue] == 0) {
                
                [MBProgressHUD showError:@"点赞成功" toView:lxWindow];
                self.btn1.selected = YES;
                self.model.commentNum = self.model.commentNum + 1;
                
                [self.btn1 setTitle:[NSString stringWithFormat:@"%d",self.model.commentNum] forState:UIControlStateNormal];

            }
            
        } failureBlock:^(NSError *error) {
            
            
        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            
        }];
        
    }
}

@end
