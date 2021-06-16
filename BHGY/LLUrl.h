//
//  LLUrl.h
//  BHGY
//
//  Created by liuxiang on 2020/7/16.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

//注册
extern NSString *const Url_register;
//获取验证码
extern NSString *const Url_getVerifyCode;
//退出登录
extern NSString *const Url_logout;
//重置密码
extern NSString *const Url_resetPassword;
//设置性别
extern NSString *const Url_updateSex;
//地址接口
extern NSString *const Url_province_findAll;
//日常爱好
extern NSString *const Url_hobby_findAll;
//职业
extern NSString *const Url_profession_findAll;
//完善资料
extern NSString *const Url_userInfo_updateInfo;
//更新头像
extern NSString *const Url_userInfo_updateAvatar;
//判断手机号是否注册
extern NSString *const Url_checkMobile;
//申请激活码
extern NSString *const Url_activationCode;
//申请邀请码
extern NSString *const Url_applyInviteCode;

//vip套餐接口
extern NSString *const Url_vipConfiguration;

//设置开锁密码
extern NSString *const Url_setSecurityPassword;




NS_ASSUME_NONNULL_BEGIN
@interface LLUrl : NSObject

@end

NS_ASSUME_NONNULL_END
