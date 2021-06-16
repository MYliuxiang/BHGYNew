//
//  HandleTool.h
//  WaiHui
//
//  Created by liuxiang on 2019/1/4.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/utsname.h>
#import "UIDevice+VKKeychainIDFV.h"
#define NUMBERSPERIOD @"0123456789."

NS_ASSUME_NONNULL_BEGIN

@interface HandleTool : NSObject
+(BOOL) isNumber:(NSString *)string;
+(BOOL) isPhone:(NSString *)string;
+(BOOL) isEmail:(NSString *)string;
+(BOOL) inputNum:(NSString *)string;

+(NSString *)dateToOld:(NSDate *)bornDate;

+(BOOL)isMobileNumber:(NSString *)mobileNum;


+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
                          withDateFormat:(NSString *)dateFormat
;

/*
 返回0、1、2 3为格式不正确，返回4为密码格式正确
 0长度不正确
 1没有大写或小写
 2含有特殊字符
 3没有数字
 */

+(int)checkIsHaveNumAndLetter:(NSString*)password;
//不检测长度
+ (int)checkIsHaveNumAndLetterNoLenth:(NSString*)password;
+ (int)checkSpecialCharacters:(NSString*)password;




//字典转json处理訊息字段
+ (NSString*)convertToJSONData:(id)infoDict;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//星座算法
+ (NSString *)getXingzuo:(NSDate *)in_date;
+ (NSArray *)getpreferOptions;

//处理活跃时间
+ (NSString *)handleActiveWith:(NSString *)times;

//处理浮点位数为0的情况
+ (NSString *)changeFloatWithFloat:(CGFloat)floatValue;

//获取当前显示的控制器
+ (UIViewController *)getCurrentVC;

+ (NSString *)getUUID;

+ (NSString *)peopleNumber:(NSInteger)numbers;

+ (NSString *)urlHander:(NSString *)urlStr;

//获取手机型号
+ (NSString *)getCurrentDeviceModel;

+ (BOOL)isIphoneXUp;


//切换到登录页面
+ (void)switchLgoinVC;

//切换的主页面
+ (void)switchMainVC;

+ (NSString *)getImageUrlStr:(NSString *)imageId;

+ (NSString *)getDistance:(int)distance;

+ (NSString *)getCount:(int)count;


@end

NS_ASSUME_NONNULL_END
