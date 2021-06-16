//
//  PersonaldataViewController.h
//  BHGY
//
//  Created by 李立 on 2020/7/12.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonaldataViewController : BaseViewController
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImageView *touxiangimageView;
@property (nonatomic,strong) UITextField *nikenametextfield; //昵称
@property (nonatomic,strong) UITextField *citetextfield; //城市
@property (nonatomic,strong) UITextField *biredtextfield; //生日
@property (nonatomic,strong) UITextField *jobtextfield; //职业
@property (nonatomic,strong) UITextField *liketextfield; //爱好
@property (nonatomic,strong) UITextField *dxtextfield; //对象
@property (nonatomic,strong) UITextField *wxtextfield; //微信
@property (nonatomic,strong) UITextField *hegittextfield; //身高
@property (nonatomic,strong) UITextField *weighttextfield; //体重
@property (nonatomic,strong) UITextField *infotextfield; //个人介绍
@property(nonatomic,strong) UIImage *iconImage;
@property(nonatomic,strong) LoginModel *model;
@property(nonatomic,strong)JobVC *jobVC;
@property(nonatomic,strong)SeletedCityVC *sVC;


@end

NS_ASSUME_NONNULL_END
