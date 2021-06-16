//
//  PerfectVC.h
//  BHGY
//
//  Created by 李立 on 2020/7/18.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PerfectVC : BaseViewController
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITextField *niketextfield; //名称
@property (nonatomic,strong) UITextField *citytextfield; //城市
@property (nonatomic,strong) UITextField *birthdaytextfield; //生日
@property (nonatomic,strong) UITextField *jobtextfield; //工作
@property (nonatomic,strong) UITextField *liketextfield; //爱好
@property (nonatomic,strong) UITextField *heighttextfield; //身高
@property (nonatomic,strong) UITextField *weighttextfield; //体重
@property (nonatomic,strong) UITextField *introducetextfield; //个人介绍
@property (nonatomic,strong) UIImageView *iconimageview; //头像
@property(nonatomic,strong)SeletedCityVC *sVC;
@property(nonatomic,strong)JobVC *jobVC;


@end

NS_ASSUME_NONNULL_END
