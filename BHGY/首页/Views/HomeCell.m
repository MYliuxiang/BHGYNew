//
//  HomeCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/6.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "HomeCell.h"
@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 7.5;
    self.layer.masksToBounds = YES;
    
    self.onlineView.layer.cornerRadius = 3;
    self.onlineView.layer.masksToBounds = YES;
    
    self.labV.layer.cornerRadius = 7.5;
    self.labV.layer.masksToBounds = YES;
    
    self.labB2.layer.cornerRadius = 7.5;
    self.labB2.layer.masksToBounds = YES;
    
    self.labB3.layer.cornerRadius = 7.5;
    self.labB3.layer.masksToBounds = YES;
    
    self.labB4.layer.cornerRadius = 7.5;
    self.labB4.layer.masksToBounds = YES;
    
    self.stateL.layer.cornerRadius = 3;
    self.stateL.layer.masksToBounds = YES;
    
    [self.labB1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:3];
    [self.labB2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:3];
    [self.labB3 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:3];
    [self.labB4 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:3];

    
    
}

- (void)setModel:(HomeModel *)model
{
    _model = model;
    self.nameL.text = model.nickName;
    if (model.online == 1) {
        self.onlinestateL.text = @"在线";
    }else{
        self.onlinestateL.text = @"离线";

    }
    [self.img sd_setImageWithURL:[NSURL URLWithString:[HandleTool getImageUrlStr:model.avatar]] placeholderImage:[UIImage imageNamed:@"编组 2备份"]];
    [self.labB1 setTitle:[NSString stringWithFormat:@"%ld",model.photoList.count] forState:UIControlStateNormal];
    NSArray *array =@[model.city,model.profession,model.constellation];
    
    
    self.apL.text = [array componentsJoinedByString:@" | "];
    [self.labB3 setTitle:[HandleTool getDistance:model.distance] forState:UIControlStateNormal];
    if(model.photoFlag == 0){
        _labB4.hidden = YES;
    }else{
        //需要权限
        _labB4.hidden = NO;

    }
    
    if(model.sex == 0){
        [_labB2 setImage:[UIImage imageNamed:@"xingbienv"] forState:UIControlStateNormal];
    }else{
        [_labB2 setImage:[UIImage imageNamed:@"B"] forState:UIControlStateNormal];
    }
    [_labB2 setTitle:[NSString stringWithFormat:@"%d",model.age] forState:UIControlStateNormal];
    
    if (model.goddess == 1) {
        self.stateI.image = [UIImage imageNamed:@"编组 8"];
    }else{
        if (model.realHuman == 1) {
            self.stateI.image = [UIImage imageNamed:@"编组 7"];

        }else{
            if (model.vip == 1) {
                self.stateI.image = [UIImage imageNamed:@"编组 15(1)"];
            }
        }
    }

}

- (IBAction)menuAC:(id)sender {
    
    NSArray *array;
    if (self.model.iscollection == 0){
        array = @[@"收藏",@"拉黑"];
    }else{
        array = @[@"取消收藏",@"拉黑"];
        
    }
    ArrowheadMenu *VC = [[ArrowheadMenu alloc] initCustomArrowheadMenuWithTitle:array icon:nil menuUnitSize:CGSizeMake(58, 22) menuFont:[UIFont systemFontOfSize:10] menuFontColor:[UIColor colorWithHexString:@"#666666"] menuBackColor:[UIColor whiteColor] menuSegmentingLineColor:[UIColor colorWithHexString:@"#D8D8D8"] distanceFromTriggerSwitch:-5 menuArrowStyle:MenuArrowStyleTriangle menuPlacements:ShowAtBottom showAnimationEffects:ShowAnimationZoom];
    
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
    
    entity.parameters = @{@"userId":self.model.uid};
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
       
       entity.parameters = @{@"userId":self.model.uid};
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
          
          entity.parameters = @{@"userId":self.model.uid};
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




@end
