//
//  AppService.m
//  BHGY
//
//  Created by liuxiang on 2020/7/3.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "AppService.h"

@implementation AppService
//单例
+ (instancetype)shareInstance
{
    static AppService *_instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _instace = [[self alloc] init];
    });
    return _instace;
}


- (instancetype)init
{
    self = [super init];
    if(self)
    {
       
        
    }
    return self;
}

- (void)registerAppService:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [self handleKeyBoard];
//    [self upDateLastOnline];
    
}

- (void)upDateLastOnline{
    
    //0.创建队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 180 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
      //3.要调用的任务
     dispatch_source_set_event_handler(timer, ^{
         NSLog(@"GCD-----%@",[NSThread currentThread]);
         BADataEntity *entity = [BADataEntity new];
         entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userInfo_updateLastLoginTime];
         entity.needCache = NO;
         entity.parameters = nil;
         
         [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
             NSDictionary *result = response;
             
         } failureBlock:^(NSError *error) {
             
             
         } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
             
         }];
         
     });

     //4.开始执行
     dispatch_resume(timer);
    
}

- (void)handleKeyBoard{
    //键盘处理
      IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
      manager.enable = YES;
      manager.shouldResignOnTouchOutside = YES;
      manager.shouldToolbarUsesTextFieldTintColor = YES;
      manager.enableAutoToolbar = NO;
    
    
    // wrnavgation
    [WRNavigationBar wr_widely];
     [WRNavigationBar wr_setBlacklist:@[@"TZImgePickHelper",@"TZImagePickerController",
     @"TZPhotoPickerController",
     @"TZGifPhotoPreviewController",
     @"TZAlbumPickerController",
     @"TZPhotoPreviewController",
     @"TZVideoPlayerController",@"RCConversationViewController",@"ChatVC"]];
//
    
 
    
//    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
//    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
//    [WRNavigationBar wr_setDefaultNavBarBarTintColor:Color_Theme];

    
    
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:Color_Theme] forBarMetrics:UIBarMetricsDefault];

    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:Color_Theme] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                                           NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FFFFFF"]}];
    
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(2, 1)
//                                                            forBarMetrics:UIBarMetricsDefault];
//       UIImage *tmpImage = [UIImage imageNamed:@"fanhui"];
//       CGSize newSize = CGSizeMake(10, 17);
//       UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0f);
//       [tmpImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
//       UIImage *backButtonImage = UIGraphicsGetImageFromCurrentImageContext();
//       UIGraphicsEndImageContext();
//       [[UINavigationBar appearance] setBackIndicatorImage:backButtonImage];
//       [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backButtonImage];
//
//    [UINavigationBar appearance].translucent = NO;
//


//   UIImage *backButtonImage = [[UIImage imageNamed:@"fanhui"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
//   [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
   //将返回按钮的文字position设置不在屏幕上显示
//   [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
}


+(BOOL)validateContactNumber:(NSString *)mobileNum
{
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 16[6], 17[5, 6, 7, 8], 18[0-9], 170[0-9], 19[89]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705,198
     * 联通号段: 130,131,132,155,156,185,186,145,175,176,1709,166
     * 电信号段: 133,153,180,181,189,177,1700,199
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|6[6]|7[05-8]|8[0-9]|9[89])\\d{8}$";

    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478]|9[8])\\d{8}$)|(^1705\\d{7}$)";
   
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|66|7[56]|8[56])\\d{8}$)|(^1709\\d{7}$)";

    NSString *CT = @"(^1(33|53|77|8[019]|99)\\d{8}$)|(^1700\\d{7}$)";
    
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
   // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
   // NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if(([regextestmobile evaluateWithObject:mobileNum] == YES)
       || ([regextestcm evaluateWithObject:mobileNum] == YES)
       || ([regextestct evaluateWithObject:mobileNum] == YES)
       || ([regextestcu evaluateWithObject:mobileNum] == YES)) {
        return YES;
    } else {
        return NO;
    }
}


@end

