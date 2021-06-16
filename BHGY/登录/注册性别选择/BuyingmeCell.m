//
//  BuyingmeCell.m
//  BHGY
//
//  Created by 小呗出行 on 2020/7/27.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BuyingmeCell.h"

@implementation BuyingmeCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
        [self setui];
//        [self creatViews];
    }
    return self;
}

-(void)setui{
    self.bjimageview = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 90, 115)];
//    self.bjview.backgroundColor = [UIColor whiteColor];
    KViewBorderRadius(self.bjimageview, 7.5, 0.5, [UIColor colorWithHexString:@"#D8D8D8"]);
    [self addSubview:self.bjimageview];
    
    //是否推荐
    self.icoimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 6, 30, 15)];
    self.icoimageview.image = [UIImage imageNamed:@"推荐视图"];
    self.icoimageview.hidden = YES;
    [self.bjimageview addSubview:self.icoimageview];
    
   //时间
    self.timelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 21.5, 90, 24)];
    self.timelabel.textAlignment = NSTextAlignmentCenter;
    self.timelabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.timelabel.font = [UIFont systemFontOfSize:17];
    self.timelabel.text = @"半个月";
    [self.bjimageview addSubview:self.timelabel];
    
    //金币
    self.moneylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.timelabel.bottom+10, 90, 20)];
    self.moneylabel.textAlignment = NSTextAlignmentCenter;
    self.moneylabel.font = [UIFont systemFontOfSize:14];
    self.moneylabel.text = @"2360币/月";
    self.moneylabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.bjimageview addSubview:self.moneylabel];
    
    //约多少钱
    self.yuemoneylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.moneylabel.bottom+3, 90, 15)];
    self.yuemoneylabel.font = [UIFont systemFontOfSize:11];
    self.yuemoneylabel.textAlignment = NSTextAlignmentCenter;
    self.yuemoneylabel.text = @"约199元/月";
    self.yuemoneylabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.bjimageview addSubview:self.yuemoneylabel];
    
}


//赋值
- (void)setmodel:(BuyingneModel *)model{
    
    if (model.isselect == YES) {
     self.bjimageview.image = [UIImage imageNamed:@"VIP"];
        self.timelabel.textColor = [UIColor whiteColor];
        self.moneylabel.textColor = [UIColor whiteColor];
        self.yuemoneylabel.textColor = [UIColor whiteColor];
    }else{
      self.bjimageview.image = [UIImage imageNamed:@""];
        self.timelabel.textColor = [UIColor colorWithHexString:@"#333333"];
        self.moneylabel.textColor = [UIColor colorWithHexString:@"#333333"];
        self.yuemoneylabel.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    
    //是否显示推荐
    if ([model.recommend intValue] ==1) {
        self.icoimageview.hidden = NO;
    }
    self.timelabel.text = [NSString stringWithFormat:@"%@个月",model.vipMonths];
    self.moneylabel.text = [NSString stringWithFormat:@"%@币/月",model.avgRmbNum];
    self.yuemoneylabel.text = [NSString stringWithFormat:@"约%@元/月",model.avgCurrencyNum];
    
}
@end
