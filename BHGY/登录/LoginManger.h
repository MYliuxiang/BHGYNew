//
//  LoginManger.h
//  BHGY
//
//  Created by liuxiang on 2020/7/16.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface UserPhoto : NSObject

@property (nonatomic,copy)  NSString *createTime;
@property (nonatomic,copy)  NSString *sid;
@property (nonatomic,copy)  NSString *imageId;
@property (nonatomic,copy)  NSString *userId;
@property (nonatomic,assign)  int isItMe;
@property (nonatomic,assign)  int type;

@end


@interface LoginModel : NSObject
@property (nonatomic,copy)  NSString *account;
@property (nonatomic,copy)  NSString *token;   //token
@property (nonatomic,copy)  NSString *avatar;  //头像
@property (nonatomic,copy)  NSString *birthday; //生日
@property (nonatomic,copy)  NSString *mobile; //手机号
@property (nonatomic,assign)  int vip;
@property (nonatomic,strong)  NSArray *cityList;
@property (nonatomic,copy)  NSString *clientId;
@property (nonatomic,copy)  NSString *createTime;
@property (nonatomic,copy)  NSString *expectation;
@property (nonatomic,assign)  int flag;
@property (nonatomic,assign)  int goddess;
@property (nonatomic,assign)  int height;
@property (nonatomic,assign)  int hidden;
@property (nonatomic,strong)  NSArray *hobbyList; //爱好
@property (nonatomic,copy)  NSString *uid;
@property (nonatomic,copy)  NSString *lastLoginTime;
@property (nonatomic,strong)  NSArray *location;
@property (nonatomic,copy)  NSString *memo;
@property (nonatomic,copy)  NSString *nickName;
@property (nonatomic,copy)  NSString *openId;
@property (nonatomic,copy)  NSString *openType;
@property (nonatomic,copy)  NSString *profession;
@property (nonatomic,assign)  int realFlag;
@property (nonatomic,assign)  int realHuman;
@property (nonatomic,assign)  int sex; //1男0女
@property (nonatomic,assign)  int status;
@property (nonatomic,assign)  int weight;
@property (nonatomic,copy)  NSString *updateTime;
@property (nonatomic,copy)  NSString *userId;
@property (nonatomic,copy)  NSString *validateTime;
@property (nonatomic,copy)  NSString *wechat;
@property (nonatomic,strong)  NSArray *photoList;
@property (nonatomic,copy)  NSString *rongCloudTOken;




@end

@interface LoginManger : NSObject
@property(nonatomic,strong) LoginModel *currentLoginModel;
;
+ (instancetype)sharedManager;
@end

NS_ASSUME_NONNULL_END
