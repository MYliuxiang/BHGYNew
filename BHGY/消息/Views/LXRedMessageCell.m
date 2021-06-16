//
//  LXRedMessageCell.m
//  BHGY
//
//  Created by liuxiang on 2020/8/6.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "LXRedMessageCell.h"
#define Test_Message_Font_Size 16

@implementation LXRedMessageCell
+ (CGSize)sizeForMessageModel:(RCMessageModel *)model
      withCollectionViewWidth:(CGFloat)collectionViewWidth
         referenceExtraHeight:(CGFloat)extraHeight {
    LXRedMessageContent *message = (LXRedMessageContent *)model.content;
    CGSize size = [LXRedMessageCell getBubbleBackgroundViewSize:message];

    CGFloat __messagecontentview_height = size.height;

    if (__messagecontentview_height < [RCIM sharedRCIM].globalMessagePortraitSize.height) {
        __messagecontentview_height = [RCIM sharedRCIM].globalMessagePortraitSize.height;
    }

    __messagecontentview_height += extraHeight;

    return CGSizeMake(collectionViewWidth, __messagecontentview_height);
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
    self.redView = [[UIView alloc] initWithFrame:CGRectZero];
    self.redView.layer.cornerRadius = 7.5;
    self.redView.layer.masksToBounds = YES;
    [self.baseContentView addSubview:self.redView];
    self.redView.userInteractionEnabled = YES;
    
    self.redImg = [UIImageView new];
    self.redImg.image = [UIImage imageNamed:@"hongbao-weiling"];
    [self.redView addSubview:self.redImg];
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont systemFontOfSize:14];
    self.titleLab.textColor = [UIColor whiteColor];
    [self.redView addSubview:self.titleLab];
    
    self.statesLab = [[UILabel alloc] init];
    self.statesLab.font = [UIFont systemFontOfSize:11];
    self.statesLab.textColor = [UIColor whiteColor];
    self.statesLab.text = @"已被领取";
    [self.redView addSubview:self.statesLab];
    
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = [UIColor whiteColor];
    [self.redView addSubview:self.lineView];
    
    self.logoLab = [[UILabel alloc] init];
    self.logoLab.font = [UIFont systemFontOfSize:11];
    self.logoLab.textColor = [UIColor whiteColor];
    self.logoLab.text = @"佰花红包";
    [self.redView addSubview:self.logoLab];
    

//
//    @property (nonatomic,strong) UILabel *statesLab;
//
//    @property (nonatomic,strong) UIView *lineView;
//
//    @property (nonatomic,strong) UIView *logoLab;

    
    
    
    
    
    
    
    
    UILongPressGestureRecognizer *longPress =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    [self.redView addGestureRecognizer:longPress];

    UITapGestureRecognizer *textMessageTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTextMessage:)];
    textMessageTap.numberOfTapsRequired = 1;
    textMessageTap.numberOfTouchesRequired = 1;
    [self.redView addGestureRecognizer:textMessageTap];
    self.redView.userInteractionEnabled = YES;
}

- (void)tapTextMessage:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(didTapMessageCell:)]) {
        [self.delegate didTapMessageCell:self.model];
    }
}

- (void)setDataModel:(RCMessageModel *)model {
    [super setDataModel:model];
    [self setAutoLayout];
}

- (void)setAutoLayout {
    LXRedMessageContent *testMessage = (LXRedMessageContent *)self.model.content;
    RCMessage *msg = [[RCIMClient sharedRCIMClient] getMessage:self.model.messageId];
    NSString *extra = msg.extra;
   
    self.titleLab.text = testMessage.redtitle;

    if ([extra isEqualToString:@"1"]) {
        self.redView.backgroundColor = [UIColor colorWithHexString:@"#F06485"];
        
    }else{
         self.redView.backgroundColor = [UIColor colorWithHexString:@"#EB2050"];
    }
//    if (testMessage.status == 0) {
//
//
//    }else{
//
//
//    }

//    CGSize textLabelSize = [[self class] getTextLabelSize:testMessage];
//    CGSize bubbleBackgroundViewSize = [[self class] getBubbleSize:textLabelSize];
//    CGRect messageContentViewRect = self.baseContentView.frame;
//    self.redView.frame = CGRectMake((kScreenWidth - 253) / 2, 0, 253, 80);
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.baseContentView);
        make.size.mas_equalTo(CGSizeMake(253, 80));
        make.top.equalTo(self.baseContentView);
    }];
    
    [self.redImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 32));
        make.top.left.equalTo(self.redView).offset(15);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.redImg.mas_bottom).offset(12);
        make.height.mas_equalTo(0.25);
        make.left.right.equalTo(self.redView);
    }];
    
    [self.logoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(2);
        make.left.right.equalTo(self.redView).offset(15);
        make.right.equalTo(self.redView).offset(-15);
        
    }];
    if (![extra isEqualToString:@"1"]) {
        [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
               make.centerY.equalTo(self.redImg);
               make.left.equalTo(self.redImg.mas_right).offset(15);
            make.right.equalTo(self.redView).offset(-15);
            make.height.mas_equalTo(20);
          
        }];
        self.statesLab.hidden = YES;

    }else{
                
        [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.redImg.mas_top);
            make.left.equalTo(self.redImg.mas_right).offset(15);
            make.right.equalTo(self.redView).offset(-15);
            make.height.mas_equalTo(15);

        }];
        
        self.statesLab.hidden = NO;
        
        [self.statesLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom).offset(3);
            make.left.equalTo(self.redImg.mas_right).offset(15);
            make.right.equalTo(self.redView).offset(-15);
            
        }];
        
    }
    
    
     
  
}

- (void)longPressed:(id)sender {
    UILongPressGestureRecognizer *press = (UILongPressGestureRecognizer *)sender;
    if (press.state == UIGestureRecognizerStateEnded) {
        return;
    } else if (press.state == UIGestureRecognizerStateBegan) {
        [self.delegate didLongTouchMessageCell:self.model inView:self.redView];
    }
}

+ (CGSize)getTextLabelSize:(LXRedMessageContent *)message {
    if ([message.content length] > 0) {
        float maxWidth = 414 - (10 + [RCIM sharedRCIM].globalMessagePortraitSize.width + 10) * 2 - 5 - 35;
        CGRect textRect = [message.content
            boundingRectWithSize:CGSizeMake(maxWidth, 8000)
                         options:(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |
                                  NSStringDrawingUsesFontLeading)
                      attributes:@{
                          NSFontAttributeName : [UIFont systemFontOfSize:Test_Message_Font_Size]
                      }
                         context:nil];
        textRect.size.height = ceilf(textRect.size.height);
        textRect.size.width = ceilf(textRect.size.width);
        return CGSizeMake(textRect.size.width + 5, textRect.size.height + 5);
    } else {
        return CGSizeZero;
    }
}

+ (CGSize)getBubbleSize:(CGSize)textLabelSize {
    

    return CGSizeMake(253, 80);
}

+ (CGSize)getBubbleBackgroundViewSize:(LXRedMessageContent *)message {
    CGSize textLabelSize = [[self class] getTextLabelSize:message];
    
    return CGSizeMake(253, 80);
//    return [[self class] getBubbleSize:textLabelSize];
}

@end
