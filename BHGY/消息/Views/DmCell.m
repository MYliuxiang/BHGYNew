//
//  DmCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/8.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "DmCell.h"

@implementation DmCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentI.layer.cornerRadius = 7.5;
    self.contentI.layer.masksToBounds = YES;
}

- (void)setModel:(DmModel *)model{
    _model = model;
        
    if (_model.type == 0) {
        //没有图片
        self.contentI.hidden = YES;
        self.titleL.sd_layout.leftSpaceToView(self.iconI,10).rightSpaceToView(self.contentView, 15).autoHeightRatio(0);
        self.timeL.sd_layout.leftEqualToView(self.titleL).topSpaceToView(self.titleL, 8).autoHeightRatio(0);
        [self setupAutoHeightWithBottomViewsArray:@[self.iconI,self.timeL] bottomMargin:12];


    }else{
        //有图片
        self.contentI.hidden = NO;
        self.titleL.sd_layout.leftSpaceToView(self.iconI,10).rightSpaceToView(self.contentView, 107).autoHeightRatio(0);
    self.timeL.sd_layout.leftEqualToView(self.titleL).topSpaceToView(self.titleL, 8).autoHeightRatio(0);
    
        self.contentI.sd_layout.heightIs(72).topSpaceToView(self.contentView, 12).rightSpaceToView(self.contentView, 15).leftSpaceToView(self.titleL, 15);

        [self setupAutoHeightWithBottomViewsArray:@[self.contentI,self.timeL] bottomMargin:12];

    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
