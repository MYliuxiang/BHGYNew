//
//  MyVC.h
//  BHGY
//
//  Created by liuxiang on 2020/7/2.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BaseViewController.h"
#import "MyRadioVC.h"
#import "ComplaintVC.h"
#import "MyPhotoCell.h"
#import "MyBlackVC.h"
#import "PhotoSetAlert.h"
#import "MyCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyVC : BaseViewController
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *topbjview; //头部背景视图
@property (nonatomic,strong) UIButton *headbutton; //头像
@property (nonatomic,strong) UILabel *sexlabel; //性别
@property (nonatomic,strong) UILabel *xingzuolabel; //星座
@property (nonatomic,strong) UILabel *joblabel; //工作
@property (nonatomic,strong) UIImageView *seximageview; //性别图标
@property (nonatomic,strong)UIView *bjview;
@property (nonatomic,strong)UIView *baiseview;

@end

NS_ASSUME_NONNULL_END
