//
//  ThirdLoginHelper.m
//  BHGY
//
//  Created by liuxiang on 2020/7/15.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "ThirdLoginHelper.h"

@implementation AppleIDCredential
@end


@implementation ThirdLoginHelper

+ (instancetype)shareInstance
{
    static ThirdLoginHelper *_instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


- (void)loginGetUserInfo:(EnumLoginType)loginType successHandler:(SuccessHandler)successHandler failtureHandler:(FailtureHandler)failtureHandler{
    self.success  = successHandler;
    self.failture = failtureHandler;
    if (loginType == apple) {
        //苹果登录
        [self handleAuthorizationAppleIDButtonPress];
        
    }else{
        
        UMSocialPlatformType type;
        if (loginType == weixin) {
            type = UMSocialPlatformType_WechatSession;
        }else{
            type = UMSocialPlatformType_QQ;
        }
        //其他平台登录
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:type currentViewController:nil completion:^(id result, NSError *error) {
            if (error == nil) {
                UMSocialResponse *resp = (UMSocialResponse *)result;
                if (self.success) {
                    self.success(resp, nil);
                }
            }else{
                
                if (self.failture != nil) {
                    self.failture(@"授权失败");
                }
                [MBProgressHUD showError:@"授权失败" toView:lxWindow];
                
            }
        }];
        
    }
}

// 处理授权
- (void)handleAuthorizationAppleIDButtonPress{
    NSLog(@"////////");
    
    if (@available(iOS 13.0, *)) {
        // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        // 创建新的AppleID 授权请求
        ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
        // 在用户授权期间请求的联系信息
        appleIDRequest.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[appleIDRequest]];
        // 设置授权控制器通知授权请求的成功与失败的代理
        authorizationController.delegate = self;
        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
        authorizationController.presentationContextProvider = self;
        // 在控制器初始化期间启动授权流
        [authorizationController performRequests];
    }else{
        // 处理不支持系统版本
        [MBProgressHUD showError:@"该系统版本不可用Apple登录" toView:lxWindow];
    }
}

#pragma mark - delegate
//@optional 授权成功地回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)){
   
    
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        // 用户登录使用ASAuthorizationAppleIDCredential
    
        ASAuthorizationAppleIDCredential *appleIDCredential = authorization.credential;
        
        NSString *user = appleIDCredential.user;
        // 使用过授权的，可能获取不到以下三个参数
        NSString *familyName = appleIDCredential.fullName.familyName;
        NSString *givenName = appleIDCredential.fullName.givenName;
        NSString *email = appleIDCredential.email;
        
        NSData *identityToken = appleIDCredential.identityToken;
        NSData *authorizationCode = appleIDCredential.authorizationCode;
        
        
        // 服务器验证需要使用的参数
        NSString *identityTokenStr = [[NSString alloc] initWithData:identityToken encoding:NSUTF8StringEncoding];
        NSString *authorizationCodeStr = [[NSString alloc] initWithData:authorizationCode encoding:NSUTF8StringEncoding];
        
        
           AppleIDCredential *credential = [[AppleIDCredential alloc] init];
        credential.userIdentifier = user;
        credential.name = [NSString stringWithFormat:@"%@%@",givenName,familyName];
        credential.email = email;
        credential.identityTokenStr = identityTokenStr;
        credential.authorizationCodeStr = authorizationCodeStr;
        if (self.success != nil) {
            self.success(nil, credential);
        }
        
               
        
        // Create an account in your system.
        // For the purpose of this demo app, store the userIdentifier in the keychain.
        //  需要使用钥匙串的方式保存用户的唯一信息
//        [YostarKeychain save:KEYCHAIN_IDENTIFIER(@"userIdentifier") data:user];
        
    }else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]){
        // 这个获取的是iCloud记录的账号密码，需要输入框支持iOS 12 记录账号密码的新特性，如果不支持，可以忽略
        // Sign in using an existing iCloud Keychain credential.
        // 用户登录使用现有的密码凭证
        ASPasswordCredential *passwordCredential = authorization.credential;
        // 密码凭证对象的用户标识 用户的唯一标识
        NSString *user = passwordCredential.user;
        // 密码凭证对象的密码
        NSString *password = passwordCredential.password;
        
    }else{
        NSLog(@"授权信息均不符");
        
    }
}

// 授权失败的回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)){
    // Handle error.
    NSLog(@"Handle error：%@", error);
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"用户取消了授权请求";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"授权请求失败";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"授权请求响应无效";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"未能处理授权请求";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"授权请求失败未知原因";
            break;
            
        default:
            break;
    }
    [MBProgressHUD showError:@"授权请求失败" toView:lxWindow];
    
}

// 告诉代理应该在哪个window 展示内容给用户
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)){
    NSLog(@"88888888888");
    // 返回window
    return [UIApplication sharedApplication].windows.lastObject;
}

@end
