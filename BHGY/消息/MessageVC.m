//
//  MessageVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/2.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "MessageVC.h"
#import "ChatMessageVC.h"
#import "SystemMessageVC.h"
#import "MessageSetVC.h"

@interface MessageVC ()
@property (nonatomic, strong) JXCategoryNumberView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listVCContainerView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *numbers;


@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titles = @[@"聊天",@"系统消息"];
    self.customNavBar.title = @"消息";
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"设置"]];
    self.customNavBar.onClickRightButton = ^{
        MessageSetVC *vc = [[MessageSetVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
       self.categoryView = [[JXCategoryNumberView alloc] init];
       self.categoryView.frame = CGRectMake(0, Height_NavBar, kScreenWidth,36);
       self.categoryView.delegate = self;
       self.categoryView.titles = self.titles;
       self.categoryView.titleColor = [MyColor colorWithHexString:@"#333333"];
       self.categoryView.titleSelectedColor = [MyColor colorWithHexString:@"#FB78A3"];
       self.categoryView.titleFont = [UIFont systemFontOfSize:14];
       self.categoryView.backgroundColor = [MyColor colorWithHexString:@"#FFFFFF"];
       self.categoryView.defaultSelectedIndex = 0;
       
//      JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
//       self.categoryView.indicators = @[lineView];
       [self.view addSubview:self.categoryView];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = Color_line;
    lineView.frame = CGRectMake(0, 35.5, kScreenWidth, 0.5);
    [self.categoryView addSubview:lineView];
    
    
    
       
       self.listVCContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
       self.listVCContainerView.frame = CGRectMake(0, Height_NavBar + 36, kScreenWidth, kScreenHeight - Height_NavBar - 36 - Height_TabBar);
       self.listVCContainerView.defaultSelectedIndex = 0;
       [self.view addSubview:self.listVCContainerView];
       
       self.categoryView.contentScrollView = self.listVCContainerView.scrollView;
    _numbers = @[@7, @11];
    self.categoryView.counts = self.numbers;
    self.categoryView.numberLabelOffset = CGPointMake(10, 8);
    self.categoryView.numberBackgroundColor = [UIColor colorWithHexString:@"#FF4343"];
    self.categoryView.numberStringFormatterBlock = ^NSString *(NSInteger number) {
        if (number > 999) {
            return @"999+";
        }
        return [NSString stringWithFormat:@"%ld", (long)number];
    };
       
       
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    
    [self.listVCContainerView didClickSelectedItemAtIndex:index];
    
    
    
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}




#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    if (index == 0) {
         ChatMessageVC *vc = [[ChatMessageVC alloc] init];
           return vc;
    }else{
        SystemMessageVC *vc = [[SystemMessageVC alloc] init];
           return vc;
    }
   
    
    //    listVC.naviController = self.navigationController;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
