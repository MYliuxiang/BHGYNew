//
//  MyBrowserVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/24.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "MyBrowserVC.h"

@interface MyBrowserVC ()<YBImageBrowserDataSource,YBImageBrowserDelegate>
@property(nonatomic,strong)YBImageBrowser *browser;
@property(nonatomic,strong) NSMutableArray *dataSouce;
@end

@implementation MyBrowserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    self.dataSouce = [NSMutableArray arrayWithArray:self.dataList];
    self.customNavBar.title = [NSString stringWithFormat:@"%ld/%ld",self.selectIndex + 1 ,self.dataSouce.count];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"fanhui"]];
    
    if (self.type == BrowserTypeMe) {
        [self.customNavBar wr_setRightButtonWithTitle:@"删除" titleColor:[UIColor whiteColor]];
        __weak typeof(self) weakSelf = self;
        self.customNavBar.onClickRightButton = ^{
            
            
            UserPhoto *photo = weakSelf.dataSouce[weakSelf.browser.currentPage];
            BADataEntity *entity = [BADataEntity new];
            entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userPhoto_remove];
            entity.needCache = NO;
            entity.parameters = @{@"id":photo.sid,@"type":@(photo.type)};
            [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
            [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
                NSDictionary *result = response;
                if ([result[@"code"] intValue] == 0) {
                    [weakSelf.browser.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakSelf.browser.currentPage inSection:0]]];
                    [weakSelf.dataSouce removeObjectAtIndex:weakSelf.browser.currentPage];
                    [weakSelf.browser reloadData];
                    if (weakSelf.photoBlock) {
                        weakSelf.photoBlock(weakSelf.dataSouce);
                    }
                    if (weakSelf.dataSouce.count == 0) {
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }
                }
                
            } failureBlock:^(NSError *error) {
                
                
            } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                
            }];
            
        };
    }

    __weak typeof(self) weakSelf = self;

    self.customNavBar.onClickLeftButton = ^{
        
//        self.browser.dataSource
//        for()
        
        
        
        if (weakSelf.photoBlock) {
            weakSelf.photoBlock(weakSelf.dataSouce);
        }
        [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
        
        
    };
    
    
      _browser = [YBImageBrowser new];
      // 禁止旋转（但是若当前控制器能旋转，图片浏览器也会跟随，布局可能会错位，这种情况还待处理）
      _browser.supportedOrientations = UIInterfaceOrientationMaskPortrait;
      // 这里演示使用代理来处理数据源（当然用数组也可以）
      _browser.dataSource = self;
      _browser.delegate = self;
      _browser.currentPage = self.selectIndex;
      // 关闭入场和出场动效
      _browser.defaultAnimatedTransition.showType = YBIBTransitionTypeNone;
      _browser.defaultAnimatedTransition.hideType = YBIBTransitionTypeCoherent;
      // 删除工具视图（你可能需要自定义的工具视图，那请自己实现吧）

    _browser.toolViewHandlers = @[];
      // 由于 self.view 的大小可能会变化，所以需要显式的赋值容器大小
      CGSize size = CGSizeMake(kScreenWidth, kScreenHeight - YBIBStatusbarHeight() - Height_NavBar );
      [_browser showToView:self.view containerSize:size];
    
    [_browser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(Height_NavBar, 0, 0, 0));
    }];
    
    
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - <YBImageBrowserDataSource>

- (NSInteger)yb_numberOfCellsInImageBrowser:(YBImageBrowser *)imageBrowser {
    return self.dataSouce.count;
}

- (id<YBIBDataProtocol>)yb_imageBrowser:(YBImageBrowser *)imageBrowser dataForCellAtIndex:(NSInteger)index {
    
    UserPhoto *photo = self.dataSouce[index];
        // 系统相册的图片
    MyCustomData *data = [MyCustomData new];
    data.imageURL = [NSURL URLWithString:[HandleTool getImageUrlStr:photo.imageId]];
    data.type = photo.type;
    data.sid = photo.sid;
    data.updatePhoto = ^(MyCustomData * _Nonnull data) {
        photo.type = data.type;
    };
    data.interactionProfile.disable = YES;  //关闭手势交互
//    __weak typeof(self) weakSelf = self;

    data.singleTouchBlock = ^(YBIBImageData * _Nonnull imageData) {
           
    };   //拦截单击事件
    return data;


}

#pragma mark YBImageBrowserDelegate
- (void)yb_imageBrowser:(YBImageBrowser *)imageBrowser pageChanged:(NSInteger)page data:(id<YBIBDataProtocol>)data{
    self.customNavBar.title = [NSString stringWithFormat:@"%ld/%ld",page + 1 ,self.dataSouce.count];
}
@end
