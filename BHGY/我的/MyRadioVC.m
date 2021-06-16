//
//  MyRadioVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/13.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "MyRadioVC.h"

@interface MyRadioVC ()
@property (nonatomic, strong) JXCategoryNumberView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listVCContainerView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *numbers;
@end

@implementation MyRadioVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titles = @[@"我的动态",@"我的节目"];
    self.customNavBar.title = @"我的广播";
    
    self.categoryView = [[JXCategoryNumberView alloc] init];
    self.categoryView.frame = CGRectMake(0, Height_NavBar, kScreenWidth,36);
    self.categoryView.delegate = self;
    self.categoryView.titles = self.titles;
    self.categoryView.titleColor = [MyColor colorWithHexString:@"#333333"];
    self.categoryView.titleSelectedColor = [MyColor colorWithHexString:@"#FB78A3"];
    self.categoryView.titleFont = [UIFont systemFontOfSize:14];
    self.categoryView.backgroundColor = [MyColor colorWithHexString:@"#FFFFFF"];
    self.categoryView.defaultSelectedIndex = 0;
    
    [self.view addSubview:self.categoryView];
    
    self.listVCContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listVCContainerView.frame = CGRectMake(0, Height_NavBar + 36, kScreenWidth, kScreenHeight - Height_NavBar - 36);
    self.listVCContainerView.defaultSelectedIndex = 0;
    [self.view addSubview:self.listVCContainerView];
    
    self.categoryView.contentScrollView = self.listVCContainerView.scrollView;
    
    
    
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
        MyDynamicVC *vc = [[MyDynamicVC alloc] init];
        return vc;
    }else{
        MyProVC *vc = [[MyProVC alloc] init];
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
