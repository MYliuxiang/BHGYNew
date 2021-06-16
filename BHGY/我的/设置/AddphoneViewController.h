//
//  AddphoneViewController.h
//  BHGY
//
//  Created by 李立 on 2020/7/11.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddphoneViewController : BaseViewController
@property(nonatomic,strong) UITextField *iphoneTextField;
@property(nonatomic,strong) UITextField *passwordTextField;
@property(nonatomic,strong) UITextField *codeTextField;
@property (nonatomic,strong) UIButton *codeButton;

@end

NS_ASSUME_NONNULL_END
