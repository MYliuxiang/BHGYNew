//
//  LxRedTipCell.m
//  BHGY
//
//  Created by liuxiang on 2020/8/6.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "LxRedTipCell.h"

@implementation LxRedTipCell
+ (CGSize)sizeForMessageModel:(RCMessageModel *)model
      withCollectionViewWidth:(CGFloat)collectionViewWidth
         referenceExtraHeight:(CGFloat)extraHeight {
    LxRedTipContent *message = (LxRedTipContent *)model.content;
    CGSize size = [LxRedTipCell getBubbleBackgroundViewSize:message];

    CGFloat __messagecontentview_height = size.height;

    if (__messagecontentview_height < [RCIM sharedRCIM].globalMessagePortraitSize.height) {
        __messagecontentview_height = [RCIM sharedRCIM].globalMessagePortraitSize.height;
    }

    __messagecontentview_height += extraHeight;

    return CGSizeMake(collectionViewWidth, __messagecontentview_height - 25);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
        self.allowsSelection = NO;
//        self.messageTimeLabel.hidden = YES;
    }
    return self;
}

- (void)initialize {
   
    self.tipLab = [[UILabel alloc] init];
    self.tipLab.font = [UIFont systemFontOfSize:11];
    self.tipLab.textAlignment = NSTextAlignmentCenter;
    self.tipLab.textColor = Color_9;
    [self.baseContentView addSubview:self.tipLab];
           
}


- (void)setDataModel:(RCMessageModel *)model {
    [super setDataModel:model];
    [self setAutoLayout];
}

- (void)setAutoLayout {
    LxRedTipContent *testMessage = (LxRedTipContent *)self.model.content;
    RCUserInfo *userInfo = [[RCIM sharedRCIM] getUserInfoCache:self.model.senderUserId];

    NSString *str = [NSString stringWithFormat:@"%@收取了你的红包",userInfo.name];
    
    if ([self.model.senderUserId isEqualToString:[RCIM sharedRCIM].currentUserInfo.userId]) {

        str = [NSString stringWithFormat:@"你领取了红包"];
    }
    
    NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc]initWithString:str];
    //找出特定字符在整个字符串中的位置
    NSRange redRange = NSMakeRange([[contentStr string] rangeOfString:@"红包"].location, [[contentStr string] rangeOfString:@"红包"].length);
    //修改特定字符的颜色
    [contentStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#EB2050"] range:redRange];
    //修改特定字符的字体大小
    [self.tipLab setAttributedText:contentStr];
    
//    self.messageTimeLabel.hidden = YES;
//       [self.baseContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
//           make.edges.equalTo(self);
//       }];
    
    [self.tipLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.baseContentView);
        make.right.equalTo(self.baseContentView).offset(-15);
        make.height.mas_equalTo(20);
        make.top.equalTo(self.baseContentView);
      
    }];
    
   
      
}



+ (CGSize)getBubbleBackgroundViewSize:(LxRedTipContent *)message {
    
    return CGSizeMake(253, 20);
}

@end
