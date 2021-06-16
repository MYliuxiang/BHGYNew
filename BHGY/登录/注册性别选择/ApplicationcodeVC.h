//
//  ApplicationcodeVC.h
//  BHGY
//
//  Created by 李立 on 2020/7/26.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplicationcodeVC : BaseViewController
@property(nonatomic,strong) UITextField *iphoneTextField;
@property(nonatomic,strong) UITextField *passwordTextField;
@property(nonatomic,strong) UITextField *codeTextField;
@property(nonatomic,strong) UITextField *tuijianrTextField;

@property (nonatomic,strong) UIView *baiseview;
@property (nonatomic,strong) UIView *bjview;
@end

NS_ASSUME_NONNULL_END
