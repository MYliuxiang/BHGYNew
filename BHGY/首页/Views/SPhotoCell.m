//
//  SPhotoCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/8.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "SPhotoCell.h"

@implementation SPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 7.5;
    self.layer.masksToBounds = YES;
}

- (IBAction)deletedAC:(id)sender {
    if (self.btnClick) {
        self.btnClick();
    }
    
}
@end
