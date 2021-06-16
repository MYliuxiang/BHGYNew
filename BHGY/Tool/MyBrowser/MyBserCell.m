//
//  MyBserCell.m
//  BHGY
//
//  Created by liuxiang on 2020/7/24.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "MyBserCell.h"

@implementation MyBserCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (UIView *)bootomView{
    if (_bootomView == nil) {
        _bootomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - Height_NavBar - Height_TabBar, kScreenWidth,Height_TabBar )];
        _bootomView.backgroundColor = [UIColor whiteColor];
    }
    return _bootomView;;
}

- (void)creatUI{
//   UIBlurEffect *effect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    _blurEffectView =[[UIVisualEffectView alloc]initWithEffect:effect];
//    [self.imageScrollView.imageView addSubview:_blurEffectView];
//    _blurEffectView.userInteractionEnabled = YES;
    
   
//    [_blurEffectView.contentView addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(_blurEffectView.contentView);
//          }];
//    view.userInteractionEnabled = YES;
    
    [self addSubview:self.bootomView];
    
    
    _readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _readBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_readBtn setTitleColor:Color_Theme forState:UIControlStateNormal];
    [_readBtn setTitle:@"阅后即焚" forState:UIControlStateNormal];
    [_readBtn setImage:[UIImage imageNamed:@"椭圆形33"] forState:UIControlStateNormal];
    [_readBtn setImage:[UIImage imageNamed:@"gouxuan"] forState:UIControlStateSelected];
    [_readBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bootomView addSubview:_readBtn];
    
    [_readBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bootomView).offset(15);
        make.top.equalTo(self.bootomView);
        make.height.mas_equalTo(49);
        
    }];
    [_readBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
//
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//    [view addGestureRecognizer:longPress];
    
}

- (void)buttonClicked:(UIButton *)sender{
    
    MyCustomData *data = (MyCustomData *)_yb_cellData;
    int type;
    if (sender.selected) {
        type = 0;
        
    }else{
        type = 1;
    }
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userPhoto_updateType];
    entity.needCache = NO;
    entity.parameters = @{@"id":data.sid,@"type":@(type)};
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            sender.selected = !sender.selected;
            data.type = type;
            if (data.updatePhoto) {
                data.updatePhoto(data);
            }
        }
        
    } failureBlock:^(NSError *error) {
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
//    [_blurEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.imageScrollView.imageView);
//       }];
    [self.imageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self).offset();
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, Height_NavBar, 0));

    }];
}

//- (void)longPress:(UILongPressGestureRecognizer *)longPress
//{
//    // 一般开发中,长按操作只会做一次
//    // 假设在一开始长按的时候就做一次操作
//
//    NSLog(@"%ld",longPress.state);
//    if (longPress.state == UIGestureRecognizerStateBegan) {
//
//        NSLog(@"%ld",longPress.state);
//    }
//}


#pragma mark - <YBIBCellProtocol>

@synthesize yb_cellData = _yb_cellData;
@synthesize yb_hideBrowser = _yb_hideBrowser;

- (void)setYb_cellData:(id<YBIBDataProtocol>)yb_cellData {
    _yb_cellData = yb_cellData;
    [super setYb_cellData:yb_cellData];
    

    MyCustomData *data = (MyCustomData *)yb_cellData;
//    self.sdata = data;
    if (data.type == 0){
        self.readBtn.selected = NO;
    }else{
        self.readBtn.selected = YES;
    }
}

- (void)updateImageLayoutWithOrientation:(UIDeviceOrientation)orientation previousImageSize:(CGSize)previousImageSize{
    [super updateImageLayoutWithOrientation:orientation previousImageSize:previousImageSize];

}



@end
