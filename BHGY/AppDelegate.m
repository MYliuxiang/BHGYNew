//
//  AppDelegate.m
//  BHGY
//
//  Created by liuxiang on 2020/7/2.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "AppDelegate.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import "LXRedMessageContent.h"
#import "LXRedMessageCell.h"



@interface AppDelegate ()<RCIMReceiveMessageDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    //设置全局状态栏字体颜色为黑色
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //打印日志
    BANetManagerShare.isOpenLog = YES;
    
    //设置网络请求头
    NSString *user_token = [NSString stringWithFormat:@"%@",[LoginManger sharedManager].currentLoginModel.token];
    NSDictionary *headerdic = @{@"user_token":user_token};
    [BANetManager sharedBANetManager].httpHeaderFieldDictionary = headerdic;
    
    [[RCIM sharedRCIM] initWithAppKey:RCAppKey];
    [self configRongIM];
        
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *rootVC;
    if ([LoginManger sharedManager].currentLoginModel == nil) {
        //未登录
        rootVC = [[BaseNavigationController alloc] initWithRootViewController:[LogingViewController new]];
    }else{
        
        
        UITabBarController *tab = [[UITabBarController alloc] init];
        
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[ChatMessageVC new]];
        
        tab.viewControllers = @[nav];
       

        rootVC = [[MainTabBarController alloc] init];
        
//        rootVC = [[BaseNavigationController alloc] initWithRootViewController:[ChatMessageVC new]];
//        rootVC = tab;

        [[RCIM sharedRCIM] connectWithToken:[LoginManger sharedManager].currentLoginModel.rongCloudTOken
        dbOpened:^(RCDBErrorCode code) {
            //消息数据库打开，可以进入到主页面
        }
        success:^(NSString *userId) {
            //连接成功
        }
        error:^(RCConnectErrorCode status) {
            if (status == RC_CONN_TOKEN_INCORRECT) {
                //从 APP 服务获取新 token，并重连
            } else {
                //无法连接到 IM 服务器，请根据相应的错误码作出对应处理
            }
          dispatch_async(dispatch_get_main_queue(), ^{
                                                       [HandleTool switchLgoinVC];
                                                   });
                             
        }];
    }
    
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];

    [[AppService shareInstance] registerAppService:application didFinishLaunchingWithOptions:launchOptions];
    
//    [UMConfigure initWithAppkey:Umappkey channel:@"App Store"];

    // U-Share 平台设置
//    [self confitUShareSettings];
//    [self configUSharePlatforms];
    
    
       
    return YES;
}


//配置融云
- (void)configRongIM{
    
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    [RCIM sharedRCIM].globalMessagePortraitSize = CGSizeMake(45, 45);
    [RCIM sharedRCIM].portraitImageViewCornerRadius = 7.5;
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_RECTANGLE;
    [RCIM sharedRCIM].globalMessagePortraitSize =  CGSizeMake(37, 37);
    //设置会话列表头像和会话页面头像
    [RCIM sharedRCIM].userInfoDataSource = RCDDataSource;
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    [RCIM sharedRCIM].showUnkownMessage = YES;
    [RCIM sharedRCIM].enableSendCombineMessage = YES;
    [RCIM sharedRCIM].enableBurnMessage = YES;
    [RCIM sharedRCIM].enableDarkMode = YES;
    [RCIM sharedRCIM].reeditDuration = 60;
    [RCIM sharedRCIM].enableTypingStatus = YES;
    [RCIM sharedRCIM].enableSyncReadStatus = YES;
    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    
    //注册自定义消息
    [[RCIM sharedRCIM] registerMessageType:[LXRedMessageContent class]];
    [[RCIM sharedRCIM] registerMessageType:[LxRedTipContent class]];

    //
        
}

#pragma mark RCIMReceiveMessageDelegate
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
   if ([message.content isMemberOfClass:[LxRedTipContent class]]) {
       
       LxRedTipContent *content = (LxRedTipContent *)message.content;
       
       [[RCIMClient sharedRCIMClient] setMessageExtra:[content.redMessageID longLongValue] value:@"1"];
       
       dispatch_async(dispatch_get_main_queue(), ^{
           [self xw_postNotificationWithName:@"chatReload" userInfo:nil];
       });
             
       
   }
 
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
        //配置微信平台的Universal Links
    //微信和QQ完整版会校验合法的universalLink，不设置会在初始化平台失败
    [UMSocialGlobal shareInstance].universalLinkDic = @{@(UMSocialPlatformType_WechatSession):@"https://umplus-sdk-download.oss-cn-shanghai.aliyuncs.com/",
                                                        @(UMSocialPlatformType_QQ):@"https://umplus-sdk-download.oss-cn-shanghai.aliyuncs.com/qq_conn/101830139"
                                                        };
}
- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    /*设置小程序回调app的回调*/
        [[UMSocialManager defaultManager] setLauchFromPlatform:(UMSocialPlatformType_WechatSession) completion:^(id userInfoResponse, NSError *error) {
        NSLog(@"setLauchFromPlatform:userInfoResponse:%@",userInfoResponse);
    }];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
   
}

- (BOOL)application:(UIApplication *)app openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
       if (!result) {
           // 其他如支付等SDK的回调
       }
       
    return result;
}

- (BOOL)application:(UIApplication *)app continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    
    if (![[UMSocialManager defaultManager] handleUniversalLink:userActivity options:nil]) {
        // 其他SDK的回调
    }
    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"关闭");
    
}

#pragma mark - private method
- (void)registerRemoteNotification:(UIApplication *)application {
    /**
     *  推送说明：
     *
     我们在知识库里还有推送调试页面加了很多说明，当遇到推送问题时可以去知识库里搜索还有查看推送测试页面的说明。
     *
     首先必须设置deviceToken，可以搜索本文件关键字“推送处理”。模拟器是无法获取devicetoken，也就没有推送功能。
     *
     当使用"开发／测试环境"的appkey测试推送时，必须用Development的证书打包，并且在后台上传"开发／测试环境"的推送证书，证书必须是development的。
     当使用"生产／线上环境"的appkey测试推送时，必须用Distribution的证书打包，并且在后台上传"生产／线上环境"的推送证书，证书必须是distribution的。
     */
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
            settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)
                  categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        //注册推送，用于iOS8之前的系统
        UIRemoteNotificationType myTypes =
            UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
}

/**
 * 推送处理2
 */
//注册用户通知设置
- (void)application:(UIApplication *)application
    didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

/**
 * 推送处理3
 */
- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    /*
     设置 deviceToken（已兼容 iOS 13），推荐使用，需升级 SDK 版本至 2.9.25
     不需要开发者对 deviceToken 进行处理，可直接传入。
     */
    [[RCIMClient sharedRCIMClient] setDeviceTokenData:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
#if TARGET_IPHONE_SIMULATOR
// 模拟器不能使用远程推送
#else
    // 请检查App的APNs的权限设置，更多内容可以参考文档
    // http://www.rongcloud.cn/docs/ios_push.html。
    NSLog(@"获取DeviceToken失败！！！");
    NSLog(@"ERROR：%@", error);
#endif
}

/**
 * 推送处理4
 * userInfo内容请参考官网文档
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    /**
     * 统计推送打开率2
     */
    [[RCIMClient sharedRCIMClient] recordRemoteNotificationEvent:userInfo];
    /**
     * 获取融云推送服务扩展字段2
     */
    NSDictionary *pushServiceData = [[RCIMClient sharedRCIMClient] getPushExtraFromRemoteNotification:userInfo];
    if (pushServiceData) {
        NSLog(@"该远程推送包含来自融云的推送服务");
        for (id key in [pushServiceData allKeys]) {
            NSLog(@"key = %@, value = %@", key, pushServiceData[key]);
        }
    } else {
        NSLog(@"该远程推送不包含来自融云的推送服务");
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    /**
     * 统计推送打开率3
     */
//    [[RCIMClient sharedRCIMClient] recordLocalNotificationEvent:notification];
}




@end
