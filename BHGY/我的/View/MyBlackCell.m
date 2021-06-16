//
//  MyBlackCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/21.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "MyBlackCell.h"

@implementation MyBlackCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.img.layer.cornerRadius = 7.5;
    self.img.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(UserModel *)model{
    _model = model;
    [_img sd_setImageWithURL:[NSURL URLWithString:[HandleTool getImageUrlStr:model.avatar]] placeholderImage:[UIImage imageNamed:@"编组 2-1"]];
    self.nameL.text = model.nickName;
    
}

@end
