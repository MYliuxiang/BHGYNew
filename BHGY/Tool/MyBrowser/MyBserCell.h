//
//  MyBserCell.h
//  BHGY
//
//  Created by liuxiang on 2020/7/24.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "YBIBImageCell.h"
#import "MyCustomData.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyBserCell : YBIBImageCell<YBIBCellProtocol>
//@property(nonatomic,strong)UIVisualEffectView *blurEffectView;
@property(nonatomic,strong)UIView *bootomView;
@property(nonatomic,strong) UIButton *readBtn;
@end

NS_ASSUME_NONNULL_END
