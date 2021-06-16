//
//  ThirdLoginHelper.h
//  BHGY
//
//  Created by liuxiang on 2020/7/15.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UMShare/UMShare.h>
#import <AuthenticationServices/AuthenticationServices.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppleIDCredential : NSObject
///苹果用户唯一标识符，该值在同一个开发者账号下的所有App下是一样的，开发者可以用该唯一标识符与自己后台系统的账号体系绑定起
@property(nonatomic,copy) NSString *userIdentifier;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *email;
/// 服务器验证需要使用的参数
@property(nonatomic,copy) NSString *identityTokenStr;
@property(nonatomic,copy) NSString *authorizationCodeStr;

@end

typedef NS_ENUM(NSInteger, EnumLoginType) {
    // Apple NetworkStatus Compatible Names.
    weixin = 0,
    qq = 1,
    apple = 2
};

typedef void(^SuccessHandler)(UMSocialUserInfoResponse *resp,AppleIDCredential *appleIDCredential);
typedef void(^FailtureHandler)(NSString * String);


@interface ThirdLoginHelper : NSObject<ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>

@property(nonatomic,copy)SuccessHandler success;
@property(nonatomic,copy)FailtureHandler failture;
+ (instancetype)shareInstance;
- (void)loginGetUserInfo:(EnumLoginType)loginType successHandler:(SuccessHandler)successHandler failtureHandler:(FailtureHandler)failtureHandler;

@end




NS_ASSUME_NONNULL_END
