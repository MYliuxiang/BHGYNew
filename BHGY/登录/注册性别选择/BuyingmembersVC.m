//
//  BuyingmembersVC.m
//  BHGY
//
//  Created by 小呗出行 on 2020/7/27.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BuyingmembersVC.h"
#import "BuyingmeCell.h"
#import "BuyingneModel.h"
@interface BuyingmembersVC ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation BuyingmembersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self stui];
    [self setdata];
    self.isfirst = @"YES";
}

//初始化数据
-(void)setdata
{
    
            //查看VIP套餐
            BADataEntity *entity = [BADataEntity new];
            entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_vipConfiguration];
            entity.needCache = NO;
       //     entity.parameters = @{@"sex":self.sexsring};
            [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
            [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
                NSDictionary *result = response;
                if ([result[@"code"] intValue] == 0) {
                  self.mutbalearray = [BuyingneModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
                    [self.collectionView reloadData];
                }
                
            } failureBlock:^(NSError *error) {
                
                
            } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                
            }];
    
}

-(void)stui{
    
  //粉红色背景
    UIView *topbjview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Height_NavBar)];
    topbjview.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
   topbjview.userInteractionEnabled = YES;
    [self.view addSubview:topbjview];
        
    //返回按钮
    UIButton *fanhuibutton = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhuibutton.frame = CGRectMake(12.5, Height_StatusBar+9, 30, 30);
    [fanhuibutton setImage:[UIImage imageNamed:@"模态返回按钮"] forState:UIControlStateNormal];
    [fanhuibutton addTarget:self action:@selector(fanhuibuttonaciton) forControlEvents:UIControlEventTouchUpInside];
   fanhuibutton.userInteractionEnabled = YES;
    [topbjview addSubview:fanhuibutton];
    
    //标题
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height_StatusBar+12.5, kScreenWidth, 22.5)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.text = @"会员中心";
    titlelabel.font = [UIFont systemFontOfSize:16];
    [topbjview addSubview:titlelabel];
    
    //会员特权
    UILabel *tequanlabel = [[UILabel alloc]initWithFrame:CGRectMake(20.5,topbjview.bottom+9.5, 200, 18.5)];
    tequanlabel.font = [UIFont systemFontOfSize:13];
    tequanlabel.text = @"会员特权";
    tequanlabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.view addSubview:tequanlabel];
    
    //白色视图
    UIView *baiseview = [[UIView alloc]initWithFrame:CGRectMake(0, tequanlabel.bottom+9.5, kScreenWidth, 132.5)];
    baiseview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baiseview];
    
  //标题
    NSArray *titlearray = @[@"看的更多",@"看的更省",@"看的更久",@"看的更爽"];
    NSArray *nexttitlearray = @[@"每天不限次数查看用户",@"每天10次免费机会查看付费相册或者社交账号",@"查看阅后即焚照片时间从2秒提升到6秒",@"免费发布节目广播"];

    for (int i = 0; i <titlearray.count; i++) {
        UILabel *toplabel = [[UILabel alloc]initWithFrame:CGRectMake(13.5, 28*i+15, 61.5, 18)];
        toplabel.backgroundColor = [UIColor colorWithHexString:@"#FFF5F5"];
        toplabel.textColor = [UIColor colorWithHexString:@"#FF7474"];
        toplabel.font = [UIFont systemFontOfSize:11];
        toplabel.textAlignment = NSTextAlignmentCenter;
        KViewBorderRadius(toplabel, 9, 0.5, [UIColor clearColor]);
        toplabel.text = titlearray[i];
        [baiseview addSubview:toplabel];
        
        //第二行label
        UILabel *bextlabel = [[UILabel alloc]initWithFrame:CGRectMake(toplabel.right+10, toplabel.top, 250, 15)];
        bextlabel.textColor = [UIColor colorWithHexString:@"#666666"];
        bextlabel.font = [UIFont systemFontOfSize:11];
        bextlabel.text = nexttitlearray[i];
        [baiseview addSubview:bextlabel];
    }
    
    
      //选择套餐
       UILabel *tclabel = [[UILabel alloc]initWithFrame:CGRectMake(20.5,baiseview.bottom+9.5, 200, 18.5)];
       tclabel.font = [UIFont systemFontOfSize:13];
       tclabel.text = @"选择套餐";
       tclabel.textColor = [UIColor colorWithHexString:@"#333333"];
       [self.view addSubview:tclabel];
    
    
     UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
         
              // 设置item的行间距和列间距
             layout.minimumInteritemSpacing = 0;
             layout.minimumLineSpacing = 0;
         
              // 设置item的大小
    //          CGFloat itemW = kScreenWidth / 2.5 ;
             layout.itemSize = CGSizeMake(110, 110);
        
             // 设置每个分区的 上左下右 的内边距
            layout.sectionInset = UIEdgeInsetsMake(0, 0 ,0, 0);
        
             // 设置区头和区尾的大小
    //         layout.headerReferenceSize = CGSizeMake(kScreenWidth, 65);
    //         layout.footerReferenceSize = CGSizeMake(kScreenWidth, 65);
        
             // 设置分区的头视图和尾视图 是否始终固定在屏幕上边和下边
             layout.sectionFootersPinToVisibleBounds = YES;
        
             // 设置滚动条方向
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, tclabel.bottom+9, kScreenWidth, 145) collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.showsVerticalScrollIndicator = NO;   //是否显示滚动条
        self.collectionView.showsHorizontalScrollIndicator = NO;
    //    self.collectionView.scrollEnabled = YES;  //滚动使能
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        //3、添加到控制器的view
        [self.view addSubview:self.collectionView];
        
        [self.collectionView registerClass:[BuyingmeCell class] forCellWithReuseIdentifier:@"BuyingmeCell"];
    
    
    //尾视图
    UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, self.collectionView.bottom, kScreenWidth, kScreenHeight)];
    footview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footview];
    self.moneylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 21)];
    self.moneylabel.textColor = [UIColor colorWithHexString:@"#FB78A3"];
    self.moneylabel.font = [UIFont systemFontOfSize:21];
    self.moneylabel.textAlignment = NSTextAlignmentCenter;
    self.moneylabel.text = @"支付金额：186元";
    [footview addSubview:self.moneylabel];
    
    //立即开通按钮
    UIButton *openbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    openbutton.frame = CGRectMake((kScreenWidth-345)/2, self.moneylabel.bottom+15, 345, 45);
    openbutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
    [openbutton setTitle:@"立即开通" forState:UIControlStateNormal];
    [openbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [openbutton addTarget:self action:@selector(buyvipaciton) forControlEvents:UIControlEventTouchUpInside];
    openbutton.titleLabel.font = [UIFont systemFontOfSize:15];
    KViewBorderRadius(openbutton, 22.5, 0.5, [UIColor clearColor]);
    [footview addSubview:openbutton];
    
}


#pragma mark -collectionview 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;   //返回section数
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.mutbalearray.count;  //每个section的Item数
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    创建item / 从缓存池中拿 Item
    BuyingmeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BuyingmeCell" forIndexPath:indexPath];
    // 外界在此给Item添加模型数据
    if(self.mutbalearray.count > 0){
     BuyingneModel * model = self.mutbalearray [indexPath.row];
        BOOL isfist =YES;
        
        for (int i = 0; i<self.mutbalearray.count; i++) {
            BuyingneModel *buymodel = self.mutbalearray[i];
            if (buymodel.isselect == YES) {
                isfist =NO;
            }
        }
      
        if (isfist == YES && indexPath.row ==0) {
            model.isselect = YES;
          self.moneylabel.text = [NSString stringWithFormat:@"支付金额：%@元",model.avgCurrencyNum];
            self.moneysring = model.avgCurrencyNum;
        }
        [cell setmodel:model];
    }
    return cell;

}

#pragma mark - 点击 某个Item时 调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     [collectionView deselectItemAtIndexPath:indexPath animated:YES];//取消选中
        self.isfirst = @"NO";
            //选中之后的cell变颜色
         BuyingneModel *model = self.mutbalearray [indexPath.row];
//       _bjimageview.image = [UIImage imageNamed:@"购买天数背景"];
//
         for (int i = 0; i<self.mutbalearray.count; i++) {
           BuyingneModel *model2 = self.mutbalearray[i];
             if (model2 ==model) {
                 if (model2.isselect == YES) {
                      model2.isselect = YES;
                 }else{
                 model2.isselect = YES;
                 }
             }else{
             model2.isselect = NO;
             }
         }
    self.moneylabel.text = [NSString stringWithFormat:@"支付金额：%@元",model.avgCurrencyNum];
      self.moneysring = model.avgCurrencyNum;
            [self.collectionView reloadData];
 }







//返回按钮点击
-(void)fanhuibuttonaciton{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



-(NSMutableArray *)mutbalearray {
    
    if (!_mutbalearray) {
        _mutbalearray = [[NSMutableArray alloc]init];
    }
    return _mutbalearray;
}


//购买会员
-(void)buyvipaciton{
    //购买成功后返回验证吗自动填入到填写邀请码界面并调用确认事件
    
}
@end
