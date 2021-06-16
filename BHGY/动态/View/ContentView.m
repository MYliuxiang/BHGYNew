//
//  ContentView.m
//  BHGY
//
//  Created by liuxiang on 2020/7/8.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "ContentView.h"
@interface ContentView ()

@property (nonatomic, strong) NSArray *imageViewsArray;
@property (nonatomic, strong) UIImageView *img1;
@property (nonatomic, strong) UIImageView *img2;
@property (nonatomic, strong) UIImageView *img3;
@property (nonatomic, strong) UIImageView *img4;
@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;

@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIImageView *bgImg;

@property (nonatomic, strong) UIView *topView;







@end
@implementation ContentView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    
    
    self.bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"形状结合备份"]];
    self.bgImg.contentMode = UIViewContentModeScaleToFill;
    
    self.img1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"编组 55"]];
    self.img2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"编组 77"]];
    self.img3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"编组 81"]];
    self.img4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"编组 66"]];

    self.lab1 = [[UILabel alloc] init];
    self.lab1.font = [UIFont systemFontOfSize:12];
    self.lab1.textColor = [UIColor blackColor];
    
    self.lab2 = [[UILabel alloc] init];
    self.lab2.font = [UIFont systemFontOfSize:12];
    self.lab2.textColor = [UIColor blackColor];
    
    self.lab3 = [[UILabel alloc] init];
    self.lab3.font = [UIFont systemFontOfSize:12];
    self.lab3.textColor = [UIColor blackColor];
    
    
    self.lab4 = [[UILabel alloc] init];
    self.lab4.font = [UIFont systemFontOfSize:12];
    self.lab4.textColor = [UIColor blackColor];
    
    self.btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn3 setImage:[UIImage imageNamed:@"形状44"] forState:UIControlStateNormal];
    [self.btn3 setTitle:@"待定" forState:UIControlStateNormal];
    self.btn3.titleLabel.font = [UIFont systemFontOfSize:9];
    [self.btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btn3.backgroundColor = [UIColor colorWithHexString:@"#88C9FF"];
    self.btn3.layer.cornerRadius = 6.5;
    self.btn3.layer.masksToBounds = YES;
    [self.btn3 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    
    self.topView = [UIView new];
    
    [self sd_addSubviews:@[self.bgImg,self.topView,self.img1,self.img2,self.img3,self.img4,self.lab1,self.lab2,self.lab3,self.lab4,self.btn3]];
    
  
   
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 6; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        imageView.layer.cornerRadius = 7.5;
        imageView.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.imageViewsArray = [temp copy];
    
    
    self.lab1.text = @"社交聚会";
    self.lab2.text = @"06月16日 22:00";
    self.lab3.text = @"北京市";
    self.lab4.text = @"期望对象：看感觉，看脸";

        
    
}

- (void)setModel:(DynamicModel *)model{
    _model = model;
    
    self.bgImg.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    self.img1.sd_layout.leftSpaceToView(self, 20).topSpaceToView(self, 20).heightIs(14).widthIs(14);
   self.topView.sd_layout.leftSpaceToView(self.img1, 10).topSpaceToView(self, 10).rightSpaceToView(self, 20).heightIs(1);

    
    UIView *pTopView;
    if (model.type == 3) {
        //动态
        self.img2.hidden = YES;
        self.img3.hidden = YES;
        self.img4.hidden = YES;
        self.lab2.hidden = YES;
        self.lab3.hidden = YES;
        self.lab4.hidden = YES;
        self.btn3.hidden = YES;
        pTopView = self.lab1;
        self.lab1.sd_layout.leftSpaceToView(self.img1, 10).topSpaceToView(self.topView, 8).rightSpaceToView(self, 20).autoHeightRatio(0);
        if(model.content.length == 0){
            self.lab1.hidden = YES;
            self.img1.hidden = YES;
            pTopView = self.topView;

        }else{
            self.lab1.hidden = NO;
            self.img1.hidden = NO;
            self.lab1.text = model.content;
            self.img1.image = [UIImage imageNamed:@"编组 5(1)"];
            pTopView = self.lab1;

        }
        
    }else if(model.type == 1){
        //节目
        self.img1.hidden = NO;
        self.lab1.hidden = NO;
        self.img2.hidden = NO;
        self.img3.hidden = NO;
        self.img4.hidden = NO;
        self.lab2.hidden = NO;
        self.lab3.hidden = NO;
        self.lab4.hidden = NO;
        self.btn3.hidden = NO;
        self.lab1.sd_layout.leftSpaceToView(self.img1, 10).topSpaceToView(self.topView, 8).rightSpaceToView(self, 20).autoHeightRatio(0);

        self.img2.sd_layout.leftSpaceToView(self, 20).topSpaceToView(self.img1, 10).heightIs(14).widthIs(14);
        self.lab2.sd_layout.leftSpaceToView(self.img2, 10).topEqualToView(self.img2).rightSpaceToView(self, 20).autoHeightRatio(0);
        
        self.img3.sd_layout.leftSpaceToView(self, 20).topSpaceToView(self.img2, 10).heightIs(14).widthIs(14);
        self.lab3.sd_layout.leftSpaceToView(self.img3, 10).topEqualToView(self.img3).autoHeightRatio(0);
        [self.lab3 setSingleLineAutoResizeWithMaxWidth:100];

        [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab3.mas_right).offset(10);
            make.top.equalTo(self.lab3.mas_top);
            make.height.mas_equalTo(14);
        }];
        self.btn3.contentEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 7);
        
        self.img4.sd_layout.leftSpaceToView(self, 20).topSpaceToView(self.img3, 10).heightIs(14).widthIs(14);
        self.lab4.sd_layout.leftSpaceToView(self.img4, 10).topEqualToView(self.img4).autoHeightRatio(0).rightSpaceToView(self, 20);
        self.img1.image = [UIImage imageNamed:@"编组 55"];
        self.lab1.text = model.subject;
        self.lab2.text = model.meetingTime;
        self.lab3.text = model.city;
        self.lab4.text = [NSString stringWithFormat:@"期望对象：%@",model.expectation];
        pTopView = self.lab4;
        
    }else{
        //连麦
        self.img2.hidden = NO;
        self.img3.hidden = YES;
        self.img4.hidden = NO;
        self.lab2.hidden = NO;
        self.lab3.hidden = YES;
        self.lab4.hidden = NO;
        self.btn3.hidden = YES;
        self.lab1.sd_layout.leftSpaceToView(self.img1, 10).topSpaceToView(self.topView, 9).rightSpaceToView(self, 20).autoHeightRatio(0);
        self.img2.sd_layout.leftSpaceToView(self, 20).topSpaceToView(self.img1, 10).heightIs(14).widthIs(14);
        self.lab2.sd_layout.leftSpaceToView(self.img2, 10).topEqualToView(self.img2).rightSpaceToView(self, 20).autoHeightRatio(0);
        
//        self.img3.sd_layout.leftSpaceToView(self, 20).topSpaceToView(self.img2, 10).heightIs(14).widthIs(14);
//        self.lab3.sd_layout.leftSpaceToView(self.img3, 10).topEqualToView(self.img3).autoHeightRatio(0);
//        [self.lab3 setSingleLineAutoResizeWithMaxWidth:100];
//
//        [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.lab3.mas_right).offset(10);
//            make.top.equalTo(self.lab3.mas_top);
//            make.height.mas_equalTo(14);
//        }];
//        self.btn3.contentEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 7);
        
        self.img4.sd_layout.leftSpaceToView(self, 20).topSpaceToView(self.img2, 10).heightIs(14).widthIs(14);
        self.lab4.sd_layout.leftSpaceToView(self.img4, 10).topEqualToView(self.img4).autoHeightRatio(0).rightSpaceToView(self, 20);
        self.img1.image = [UIImage imageNamed:@"编组 55"];
        self.lab1.text = model.subject;
        self.lab2.text = model.meetingTime;
        self.lab3.text = model.city;
        self.lab4.text = [NSString stringWithFormat:@"期望对象：%@",model.expectation];
        pTopView = self.lab4;
        
    }
    UIView *botoomView;
    if (_model.imageList.count == 0) {
        [self setupAutoHeightWithBottomView:pTopView bottomMargin:15];
        return;
    }
    
    for (long i = _model.imageList.count; i < self.imageViewsArray.count; i++) {
           UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
           imageView.hidden = YES;
       }
       
       CGFloat itemW = [self itemWidthForPicPathArray:_model.imageList];
       CGFloat itemH = itemW;

       long perRowItemCount = [self perRowItemCountForPicPathArray:_model.imageList];
       CGFloat margin = 10;
    
    
    for (int i = 0; i < self.model.imageList.count; i++) {
        long columnIndex = i % perRowItemCount;
        long rowIndex = i / perRowItemCount;
        UIImageView *imageView = [self->_imageViewsArray objectAtIndex:i];
        imageView.hidden = NO;
        imageView.frame = CGRectMake(20 + columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
        imageView.sd_layout.topSpaceToView(pTopView, 10 + rowIndex * (itemH + margin)).widthIs(itemW).heightIs(itemH);
        [imageView sd_setImageWithURL:[NSURL URLWithString:[HandleTool getImageUrlStr:self.model.imageList[i]]] placeholderImage:[UIImage imageNamed:@"编组 2备份"]];
    }
       

    if (_model.imageList.count > self.imageViewsArray.count) {
        botoomView = self.imageViewsArray[5];
    }else{
        botoomView = self.imageViewsArray[_model.imageList.count - 1];
    }
    
    [self setupAutoHeightWithBottomView:pTopView bottomMargin:(_model.imageList.count  + 2)/ 3 * (itemH + 10) + 10];

    
}


#pragma mark - private actions

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    MyBrowserVC *vc = [MyBrowserVC new];
    vc.dataList = self.model.imageList;
    vc.selectIndex = tap.view.tag;
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.viewController presentViewController:nav animated:YES completion:nil];
}

- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    return (kScreenWidth - 30 - 40 - 20) / 3;
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
       
    return 3;
}


@end
